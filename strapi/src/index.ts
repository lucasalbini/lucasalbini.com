import type { Core } from "@strapi/strapi";

export default {
  register(/* { strapi }: { strapi: Core.Strapi } */) {},

  async bootstrap({ strapi }: { strapi: Core.Strapi }) {
    await ensureLocales(strapi);
  },
};

const REQUIRED_LOCALES: Array<{ code: string; name: string; isDefault: boolean }> = [
  { code: "pt-BR", name: "Portuguese (Brazil) (pt-BR)", isDefault: true },
  { code: "en", name: "English (en)", isDefault: false },
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
