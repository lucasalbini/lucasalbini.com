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

const LEGACY_DB = process.env.LEGACY_DB_NAME || "strapi_legacy";

export async function importLegacyDump(strapi: Core.Strapi): Promise<void> {
  const postsExisting = await strapi.db.query("api::post.post").count();
  const doLegacy = postsExisting === 0;

  let fileIdMap = new Map<number, number>();
  if (doLegacy) {
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
      fileIdMap = await importFiles(strapi, legacy);
      await safeStep(strapi, "profile", () => importProfile(strapi, legacy));
      await safeStep(strapi, "skills", () => importSkills(strapi, legacy));
      await safeStep(strapi, "experiences", () => importExperiences(strapi, legacy));
      await safeStep(strapi, "education", () => importEducation(strapi, legacy));
      await safeStep(strapi, "certifications", () => importCertifications(strapi, legacy));
      await safeStep(strapi, "publications", () => importPublications(strapi, legacy));
      await safeStep(strapi, "posts", () => importPosts(strapi, legacy, fileIdMap));
    } finally {
      await legacy.end();
    }
  } else {
    strapi.log.info("[import-legacy] posts already present; skipping legacy import (demo seed still runs).");
    // Rebuild fileIdMap-ish by pulling current file ids so demo projects can borrow covers.
    const files = (await strapi.db.query("plugin::upload.file").findMany({ limit: 50 })) as Array<{ id: number }>;
    files.forEach((f, i) => fileIdMap.set(i, f.id));
  }

  await safeStep(strapi, "demo-projects", () => seedDemoProjects(strapi, fileIdMap));
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

  const created: any = await (strapi.documents("api::profile.profile").create as any)({
    data,
    locale: "pt-BR",
    status: "published",
  });

  // English shell — same content, marked for later translation.
  if (created?.documentId) {
    try {
      await (strapi.documents("api::profile.profile").update as any)({
        documentId: created.documentId,
        locale: "en",
        status: "published",
        data: {
          role: profileRow.designation ?? null,
          location: profileRow.location ?? null,
          short_bio: shortBio,
          long_bio: longBio,
        },
      });
    } catch (e) {
      strapi.log.warn(`[import-legacy] en profile shell failed: ${(e as Error).message}`);
    }
  }
  strapi.log.info("[import-legacy] profile: imported");
}

// -------------------- skills --------------------

async function importSkills(strapi: Core.Strapi, legacy: Client): Promise<void> {
  const rows = (
    await legacy.query(`
      SELECT name, icon_name, summary, category, url
      FROM skills
      WHERE locale = 'pt-BR' AND published_at IS NOT NULL
      ORDER BY id
    `)
  ).rows;
  let ok = 0;
  for (const r of rows) {
    try {
      await (strapi.documents("api::skill.skill").create as any)({
        data: {
          name: r.name,
          icon_name: r.icon_name ?? null,
          summary: r.summary ?? null,
          category: r.category,
          url: r.url ?? null,
        },
        locale: "pt-BR",
        status: "published",
      });
      ok++;
    } catch (e) {
      strapi.log.warn(`[import-legacy] skill '${r.name}' failed: ${(e as Error).message}`);
    }
  }
  strapi.log.info(`[import-legacy] skills: imported ${ok}/${rows.length}`);
}

// -------------------- experiences --------------------

async function importExperiences(strapi: Core.Strapi, legacy: Client): Promise<void> {
  const rows = (
    await legacy.query(`
      SELECT id, company_name, company_url, company_location, "order"
      FROM experiences
      WHERE locale = 'pt-BR' AND published_at IS NOT NULL
      ORDER BY "order"
    `)
  ).rows;

  for (const exp of rows) {
    const posCmps = (
      await legacy.query(
        `SELECT cmp_id, "order"
         FROM experiences_cmps
         WHERE entity_id = $1 AND component_type = 'shared.position' AND field = 'positions'
         ORDER BY "order"`,
        [exp.id],
      )
    ).rows;

    const positions: any[] = [];
    for (const pc of posCmps) {
      const pos = (
        await legacy.query(
          `SELECT id, designation, start_date, end_date, is_current
           FROM components_shared_positions WHERE id = $1`,
          [pc.cmp_id],
        )
      ).rows[0];
      if (!pos) continue;

      const respCmps = (
        await legacy.query(
          `SELECT cmp_id, "order"
           FROM components_shared_positions_cmps
           WHERE entity_id = $1 AND component_type = 'shared.responsibility' AND field = 'responsibilities'
           ORDER BY "order"`,
          [pos.id],
        )
      ).rows;
      const responsibilities: any[] = [];
      for (const rc of respCmps) {
        const r = (
          await legacy.query(
            `SELECT description FROM components_shared_responsibilities WHERE id = $1`,
            [rc.cmp_id],
          )
        ).rows[0];
        if (r) responsibilities.push({ description: r.description });
      }

      positions.push({
        designation: pos.designation,
        start_date: pos.start_date,
        end_date: pos.end_date,
        is_current: pos.is_current,
        responsibilities,
      });
    }

    await (strapi.documents("api::experience.experience").create as any)({
      data: {
        company_name: exp.company_name,
        company_url: exp.company_url ?? null,
        company_location: exp.company_location ?? null,
        order: exp.order ?? null,
        positions,
      },
      locale: "pt-BR",
      status: "published",
    });
  }
  strapi.log.info(`[import-legacy] experiences: imported ${rows.length}`);
}

// -------------------- education --------------------

async function importEducation(strapi: Core.Strapi, legacy: Client): Promise<void> {
  const rows = (
    await legacy.query(`
      SELECT institution, degree, field_of_study, start_date, end_date, description
      FROM educations
      WHERE locale = 'pt-BR' AND published_at IS NOT NULL
      ORDER BY start_date DESC NULLS LAST
    `)
  ).rows;
  for (const r of rows) {
    await (strapi.documents("api::education.education").create as any)({
      data: {
        institution: r.institution,
        degree: r.degree ?? null,
        field_of_study: r.field_of_study ?? null,
        start_date: r.start_date,
        end_date: r.end_date,
        description: r.description ?? null,
      },
      locale: "pt-BR",
      status: "published",
    });
  }
  strapi.log.info(`[import-legacy] education: imported ${rows.length}`);
}

// -------------------- certifications --------------------

async function importCertifications(strapi: Core.Strapi, legacy: Client): Promise<void> {
  const rows = (
    await legacy.query(`
      SELECT name, issuer, issue_date, credential_url
      FROM certifications
      WHERE published_at IS NOT NULL
      ORDER BY issue_date DESC NULLS LAST
    `)
  ).rows;
  for (const r of rows) {
    await (strapi.documents("api::certification.certification").create as any)({
      data: {
        name: r.name,
        issuer: r.issuer ?? null,
        issue_date: r.issue_date,
        credential_url: r.credential_url ?? null,
      },
      status: "published",
    });
  }
  strapi.log.info(`[import-legacy] certifications: imported ${rows.length}`);
}

// -------------------- publications --------------------

async function importPublications(strapi: Core.Strapi, legacy: Client): Promise<void> {
  const rows = (
    await legacy.query(`
      SELECT title, journal, authors, date, url, doi, abstract
      FROM publications
      WHERE locale = 'pt-BR' AND published_at IS NOT NULL
      ORDER BY date DESC NULLS LAST
    `)
  ).rows;
  for (const r of rows) {
    await (strapi.documents("api::publication.publication").create as any)({
      data: {
        title: r.title,
        journal: r.journal ?? null,
        authors: r.authors ?? null,
        date: r.date,
        url: r.url ?? null,
        doi: r.doi ?? null,
        abstract: r.abstract ?? null,
      },
      locale: "pt-BR",
      status: "published",
    });
  }
  strapi.log.info(`[import-legacy] publications: imported ${rows.length}`);
}

// -------------------- posts --------------------

async function importPosts(strapi: Core.Strapi, legacy: Client, fileIdMap: Map<number, number>): Promise<void> {
  const rows = (
    await legacy.query(`
      SELECT id, title, slug, content, excerpt, featured, tags, categories, reading_time
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
      locale: "pt-BR",
    });
    if (created?.documentId) labelToId.set(label, created.documentId);
  }
  strapi.log.info(`[import-legacy] tags: created ${labelToId.size}`);

  for (let i = 0; i < rows.length; i++) {
    const p = rows[i];
    const contentMd = (p.content as string | null) ?? "";
    const summary = (p.excerpt as string | null) ?? firstParagraphAsText(contentMd, 200);
    const body = markdownToBlocks(contentMd);

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
        featured: !!p.featured,
        featured_order: i,
        tags: postTagIds,
      },
      locale: "pt-BR",
      status: "published",
    });
  }
  strapi.log.info(`[import-legacy] posts: imported ${rows.length}`);
}

// -------------------- demo projects --------------------

/**
 * The legacy dump had zero projects. Seeds three placeholders so the "Building"
 * section on the home isn't empty out of the box. Reuses existing post cover
 * files so cards ship with imagery — swap in the admin when the real ones exist.
 */
async function seedDemoProjects(strapi: Core.Strapi, fileIdMap: Map<number, number>): Promise<void> {
  const count = await strapi.db.query("api::project.project").count();
  if (count > 0) {
    strapi.log.info("[import-legacy] projects: already have content, skipping demo seed");
    return;
  }

  const covers = [...fileIdMap.values()];
  const pick = (i: number) => covers[i % Math.max(covers.length, 1)];

  const demo: any[] = [
    {
      title: "lucasalbini.com",
      slug: "lucasalbini-com",
      summary: "Este próprio site: hub bilíngue com Next.js 15, Strapi v5, FastAPI e pgvector — em preparo para busca semântica e RAG.",
      kind: "tool",
      status: "active",
      year: 2026,
      featured: true,
      featured_order: 0,
      repo_url: "https://github.com/lucasalbini/lucasalbini.com",
      demo_url: "https://lucasalbini.com",
      cover: pick(0) ?? undefined,
      body: [
        { type: "paragraph", children: [{ type: "text", text: "Reescrita do zero como hub curado: home minimalista, blog e projetos com cards, /lab pra experimentos rápidos, i18n de verdade (pt-BR + en com rotas traduzidas)." }] },
      ],
    },
    {
      title: "RAG Playground",
      slug: "rag-playground",
      summary: "Sandbox pra iterar rápido sobre pipelines de retrieval + geração — comparação lado-a-lado de embeddings, rerankers e prompts.",
      kind: "ai",
      status: "experiment",
      year: 2026,
      featured: true,
      featured_order: 1,
      cover: pick(1) ?? undefined,
      body: [
        { type: "paragraph", children: [{ type: "text", text: "Ambiente pra ligar chunks, embeddings e prompts em segundos, versionar tudo e medir custo x qualidade em cada troca." }] },
      ],
    },
    {
      title: "Coming soon",
      slug: "coming-soon",
      summary: "Próximo projeto de jogo — usando Godot + IA generativa para NPCs. Em desenvolvimento, mais em breve.",
      kind: "game",
      status: "paused",
      year: 2026,
      featured: true,
      featured_order: 2,
      cover: pick(2) ?? undefined,
      body: [
        { type: "paragraph", children: [{ type: "text", text: "Placeholder. Substitua no admin quando o projeto estiver publicavel." }] },
      ],
    },
  ];

  let ok = 0;
  for (const d of demo) {
    try {
      await (strapi.documents("api::project.project").create as any)({
        data: d,
        locale: "pt-BR",
        status: "published",
      });
      ok++;
    } catch (e) {
      strapi.log.warn(`[import-legacy] demo project '${d.title}' failed: ${(e as Error).message}`);
    }
  }
  strapi.log.info(`[import-legacy] demo projects: seeded ${ok}/${demo.length}`);
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
