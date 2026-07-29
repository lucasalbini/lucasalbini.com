import { defineRouting } from "next-intl/routing";
import { createNavigation } from "next-intl/navigation";

/**
 * URL locales use short codes (`pt`, `en`) — nicer paths, lowercase.
 * The Strapi/API locale is `pt-BR`, so `apiLocale()` maps between them.
 *
 * Route segments are translated so URLs feel native in each language:
 *   /pt/projetos   ↔  /en/projects
 *   /pt/sobre      ↔  /en/about
 *   /pt/publicacoes ↔ /en/publications
 * The canonical (internal) path used in Link/redirect calls is the English one.
 */
export const routing = defineRouting({
  locales: ["pt", "en"],
  defaultLocale: "pt",
  localePrefix: "always",
  localeCookie: {
    name: "NEXT_LOCALE",
    maxAge: 60 * 60 * 24 * 365,
  },
  pathnames: {
    "/": "/",
    "/about": {
      pt: "/sobre",
      en: "/about",
    },
    "/projects": {
      pt: "/projetos",
      en: "/projects",
    },
    "/projects/[slug]": {
      pt: "/projetos/[slug]",
      en: "/projects/[slug]",
    },
    "/blog": "/blog",
    "/blog/[slug]": "/blog/[slug]",
    "/lab": "/lab",
    "/tags/[tag]": "/tags/[tag]",
  },
});

export type Locale = (typeof routing.locales)[number];

const API_LOCALE_MAP: Record<Locale, string> = {
  pt: "pt-BR",
  en: "en",
};

export function apiLocale(locale: Locale): string {
  return API_LOCALE_MAP[locale];
}

export function uiLocale(apiLoc: string): Locale {
  return apiLoc.startsWith("pt") ? "pt" : "en";
}

export const { Link, redirect, usePathname, useRouter, getPathname } = createNavigation(routing);
