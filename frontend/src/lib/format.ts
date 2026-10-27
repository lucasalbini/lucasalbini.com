import type { Locale } from "@/lib/i18n/routing";

const INTL_LOCALE: Record<Locale, string> = { pt: "pt-BR" };

const DATE_ONLY = /^\d{4}-\d{2}-\d{2}$/;

export function formatDate(iso: string | null | undefined, locale: Locale, opts: Intl.DateTimeFormatOptions = { day: "numeric", month: "long", year: "numeric" }): string {
  if (!iso) return "";
  const d = new Date(iso);
  if (isNaN(d.getTime())) return iso;
  // A calendar day ("2026-10-10", a post's `date`) parses as UTC midnight; formatting it
  // in a local zone west of UTC would show the day before.
  const timeZone = DATE_ONLY.test(iso) ? "UTC" : opts.timeZone;
  return new Intl.DateTimeFormat(INTL_LOCALE[locale], { ...opts, timeZone }).format(d);
}

export function formatShortDate(iso: string | null | undefined, locale: Locale): string {
  return formatDate(iso, locale, { day: "2-digit", month: "short", year: "numeric" });
}

export function formatYear(iso: string | null | undefined): string {
  if (!iso) return "";
  const d = new Date(iso);
  return isNaN(d.getTime()) ? iso : String(d.getFullYear());
}

export function absoluteUrl(path: string): string {
  const base = process.env.NEXT_PUBLIC_SITE_URL || "http://localhost";
  return path.startsWith("http") ? path : `${base.replace(/\/$/, "")}${path.startsWith("/") ? path : `/${path}`}`;
}

/** Resolve a Strapi upload URL (which may be relative like `/uploads/foo.jpg`)
 * into a URL the browser can hit. During dev, nginx serves /uploads directly. */
export function mediaUrl(url: string | undefined | null): string {
  if (!url) return "";
  if (url.startsWith("http")) return url;
  const base = process.env.NEXT_PUBLIC_STRAPI_URL || process.env.NEXT_PUBLIC_SITE_URL || "";
  return `${base.replace(/\/$/, "")}${url}`;
}
