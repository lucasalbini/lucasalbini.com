import { defineRouting } from "next-intl/routing";
import { createNavigation } from "next-intl/navigation";

/**
 * Portuguese only (ADR-0002 §4.3). next-intl stays with a single locale and no URL
 * prefix so English can come back by editing this file, not by rebuilding routing.
 * The canonical (internal) pathnames are English; the public ones are Portuguese.
 */
export const routing = defineRouting({
  locales: ["pt"],
  defaultLocale: "pt",
  localePrefix: "never",
  localeDetection: false,
  pathnames: {
    "/": "/",
    "/about": "/sobre",
    "/archive": "/arquivo",
    "/archive/[category]": "/arquivo/[category]",
    "/collections/[slug]": "/colecoes/[slug]",
    "/tags/[tag]": "/tags/[tag]",
    "/[slug]": "/[slug]",
  },
});

export type Locale = (typeof routing.locales)[number];

/** Strapi locale for the content types that are still localized (CV, publications). */
export const API_LOCALE = "pt-BR";

export const { Link, redirect, usePathname, useRouter, getPathname } = createNavigation(routing);
