import type { Core } from "@strapi/strapi";
import { importLegacyDump } from "./scripts/import-legacy";

export default {
  register(/* { strapi }: { strapi: Core.Strapi } */) {},

  async bootstrap({ strapi }: { strapi: Core.Strapi }) {
    await ensureLocales(strapi);
    await grantPublicReadPermissions(strapi);
    if (process.env.IMPORT_LEGACY === "1") {
      try {
        await importLegacyDump(strapi);
      } catch (e) {
        strapi.log.error(`[bootstrap] legacy import failed: ${(e as Error).message}`);
        if ((e as Error).stack) strapi.log.error((e as Error).stack);
      }
    }
  },
};

const REQUIRED_LOCALES: Array<{ code: string; name: string; isDefault: boolean }> = [
  { code: "pt-BR", name: "Portuguese (Brazil) (pt-BR)", isDefault: true },
  { code: "en", name: "English (en)", isDefault: false },
];

const PUBLIC_READ_UIDS = [
  "api::post.post",
  "api::project.project",
  "api::profile.profile",
  "api::tag.tag",
  "api::lab.lab",
  "api::experience.experience",
  "api::education.education",
  "api::certification.certification",
  "api::publication.publication",
  "api::skill.skill",
];

async function ensureLocales(strapi: Core.Strapi) {
  const localeService = strapi.plugin("i18n").service("locales");
  const existing = await localeService.find();
  const existingCodes = new Set(existing.map((l: { code: string }) => l.code));

  for (const target of REQUIRED_LOCALES) {
    if (existingCodes.has(target.code)) continue;
    await localeService.create({
      code: target.code,
      name: target.name,
      isDefault: target.isDefault,
    });
    strapi.log.info(`[bootstrap] created locale ${target.code}`);
  }
}

async function grantPublicReadPermissions(strapi: Core.Strapi) {
  const publicRole = await strapi
    .query("plugin::users-permissions.role")
    .findOne({ where: { type: "public" } });

  if (!publicRole) {
    strapi.log.warn("[bootstrap] public role not found; skipping permission grants");
    return;
  }

  const wanted = new Set<string>();
  for (const uid of PUBLIC_READ_UIDS) {
    wanted.add(`${uid}.find`);
    wanted.add(`${uid}.findOne`);
  }

  const existing = await strapi
    .query("plugin::users-permissions.permission")
    .findMany({ where: { role: publicRole.id, action: { $in: [...wanted] } } });

  const existingActions = new Set(existing.map((p: { action: string }) => p.action));

  for (const action of wanted) {
    if (existingActions.has(action)) continue;
    await strapi.query("plugin::users-permissions.permission").create({
      data: { action, role: publicRole.id },
    });
    strapi.log.info(`[bootstrap] granted public: ${action}`);
  }
}
