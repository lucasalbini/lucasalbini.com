/**
 * One-shot import from the legacy Strapi dump into the new schema.
 *
 * Runs from the bootstrap when IMPORT_LEGACY=1. Idempotent-ish: skips if
 * profile already exists (crude but effective for our data set).
 * Legacy dump is expected pre-loaded into a companion database.
 *
 * We rely on `strapi.db.query()` rather than `strapi.documents()` for
 * count/existence checks (simpler types) and use `strapi.documents(...).create`
 * with `as any` casts for schema-shape flexibility during migration.
 */

/* eslint-disable @typescript-eslint/no-explicit-any */

import type { Core } from "@strapi/strapi";
import { Client } from "pg";
import { markdownToBlocks, firstParagraphAsText } from "./markdown-to-blocks";
import { toIsoDate } from "./dates";

const LEGACY_DB = process.env.LEGACY_DB_NAME || "strapi_legacy";

export async function importLegacyDump(strapi: Core.Strapi): Promise<void> {
  const postsExisting = await strapi.db.query("api::post.post").count();
  if (postsExisting === 0) {
    const legacy = new Client({
      host: process.env.DATABASE_HOST || "postgres",
      port: parseInt(process.env.DATABASE_PORT || "5432", 10),
      user: process.env.DATABASE_USERNAME || "strapi",
      password: process.env.DATABASE_PASSWORD || "",
      database: LEGACY_DB,
    });
    try {
      await legacy.connect();
    } catch (e) {
      strapi.log.warn(`[import-legacy] cannot connect to ${LEGACY_DB}: ${(e as Error).message}`);
      return;
    }
    try {
      const fileIdMap = await importFiles(strapi, legacy);
      await safeStep(strapi, "profile", () => importProfile(strapi, legacy));
      await safeStep(strapi, "posts", () => importPosts(strapi, legacy, fileIdMap));
    } finally {
      await legacy.end();
    }
  } else {
    strapi.log.info("[import-legacy] posts already present; skipping legacy import.");
  }
  strapi.log.info("[import-legacy] done.");
}

async function safeStep(strapi: Core.Strapi, name: string, fn: () => Promise<void>): Promise<void> {
  try {
    await fn();
  } catch (e) {
    strapi.log.error(`[import-legacy] step '${name}' failed: ${(e as Error).message}`);
    if ((e as Error).stack) strapi.log.error((e as Error).stack);
  }
}

// -------------------- files --------------------

async function importFiles(strapi: Core.Strapi, legacy: Client): Promise<Map<number, number>> {
  const idMap = new Map<number, number>();
  const rows = (await legacy.query("SELECT * FROM files ORDER BY id")).rows;
  for (const f of rows) {
    const existing = await strapi.db.query("plugin::upload.file").findOne({ where: { hash: f.hash } });
    if (existing) {
      idMap.set(f.id, (existing as { id: number }).id);
      continue;
    }
    const created = await strapi.db.query("plugin::upload.file").create({
      data: {
        name: f.name,
        alternativeText: f.alternative_text,
        width: f.width,
        height: f.height,
        formats: f.formats,
        hash: f.hash,
        ext: f.ext,
        mime: f.mime,
        size: f.size,
        url: f.url,
        provider: f.provider || "local",
        folderPath: f.folder_path || "/",
      },
    });
    idMap.set(f.id, (created as { id: number }).id);
  }
  strapi.log.info(`[import-legacy] files: mapped ${idMap.size}`);
  return idMap;
}

// -------------------- profile --------------------

async function importProfile(strapi: Core.Strapi, legacy: Client): Promise<void> {
  const profileRow = (
    await legacy.query(`
      SELECT id, name, designation, company, location, summary
      FROM profiles
      WHERE locale = 'pt-BR' AND published_at IS NOT NULL
      ORDER BY id DESC LIMIT 1
    `)
  ).rows[0];
  if (!profileRow) {
    strapi.log.warn("[import-legacy] no profile row in legacy");
    return;
  }

  const socialRows = (
    await legacy.query(
      `SELECT c.platform, c.url, c.icon_name
       FROM components_shared_social_links c
       JOIN profiles_cmps pc ON pc.cmp_id = c.id
       WHERE pc.entity_id = $1 AND pc.component_type = 'shared.social-link'
       ORDER BY pc.order`,
      [profileRow.id],
    )
  ).rows;

  const summary = profileRow.summary ?? "";
  const shortBio = firstParagraphAsText(summary, 280);
  const longBio = markdownToBlocks(summary);
  const socialLinks = socialRows.map((s: any) => ({
    platform: s.platform,
    url: s.url,
    icon_name: s.icon_name,
  }));

  const data: any = {
    name: profileRow.name,
    role: profileRow.designation ?? null,
    company: profileRow.company ?? null,
    location: profileRow.location ?? null,
    short_bio: shortBio,
    long_bio: longBio,
    social_links: socialLinks,
  };

  await (strapi.documents("api::profile.profile").create as any)({
    data,
    status: "published",
  });
  strapi.log.info("[import-legacy] profile: imported");
}

// -------------------- posts --------------------

async function importPosts(strapi: Core.Strapi, legacy: Client, fileIdMap: Map<number, number>): Promise<void> {
  const rows = (
    await legacy.query(`
      SELECT id, title, slug, content, excerpt, featured, tags, categories, reading_time, published_at
      FROM posts
      WHERE locale = 'pt-BR' AND published_at IS NOT NULL
      ORDER BY id
    `)
  ).rows;

  // Collect unique tags from the legacy JSON fields to seed the tag collection.
  const tagLabels = new Set<string>();
  for (const p of rows) {
    for (const t of (Array.isArray(p.tags) ? p.tags : [])) if (typeof t === "string") tagLabels.add(t);
    for (const c of (Array.isArray(p.categories) ? p.categories : [])) if (typeof c === "string") tagLabels.add(c);
  }
  const labelToId = new Map<string, string>();
  for (const label of tagLabels) {
    const created: any = await (strapi.documents("api::tag.tag").create as any)({
      data: { label, slug: slugify(label) },
    });
    if (created?.documentId) labelToId.set(label, created.documentId);
  }
  strapi.log.info(`[import-legacy] tags: created ${labelToId.size}`);

  for (let i = 0; i < rows.length; i++) {
    const p = rows[i];
    const contentMd = (p.content as string | null) ?? "";
    const summary = (p.excerpt as string | null) ?? firstParagraphAsText(contentMd, 200);
    const body = [{ __component: "blocks.text", body: markdownToBlocks(contentMd) }];

    const coverRow = (
      await legacy.query(
        `SELECT file_id FROM files_related_mph
         WHERE related_type = 'api::post.post' AND related_id = $1 AND field = 'featured_image'
         ORDER BY "order" LIMIT 1`,
        [p.id],
      )
    ).rows[0];
    const coverId = coverRow ? fileIdMap.get(coverRow.file_id) ?? null : null;

    const postTagIds = [
      ...((Array.isArray(p.tags) ? p.tags : []) as string[]),
      ...((Array.isArray(p.categories) ? p.categories : []) as string[]),
    ]
      .filter((t): t is string => typeof t === "string")
      .map((label) => labelToId.get(label))
      .filter((x): x is string => !!x);

    await (strapi.documents("api::post.post").create as any)({
      data: {
        title: p.title,
        slug: p.slug,
        summary: summary || p.title,
        body,
        cover: coverId ?? undefined,
        // Legacy posts are all technical articles about AI work.
        category: "work",
        visibility: "public",
        date: toIsoDate(p.published_at, new Date()),
        featured: !!p.featured,
        featured_order: i,
        tags: postTagIds,
      },
      status: "published",
    });
  }
  strapi.log.info(`[import-legacy] posts: imported ${rows.length}`);
}

function slugify(s: string): string {
  return s
    .toLowerCase()
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-z0-9\s-]/g, "")
    .trim()
    .replace(/\s+/g, "-");
}

