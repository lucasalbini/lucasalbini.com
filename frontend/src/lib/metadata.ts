import type { Metadata } from "next";
import { getPathname } from "@/lib/i18n/routing";

type Href = Parameters<typeof getPathname>[0]["href"];

/** Public (Portuguese) path for an internal href, e.g. `/archive` → `/arquivo`. */
export function publicPath(href: Href): string {
  return getPathname({ locale: "pt", href });
}

export function pageMetadata(input: {
  title: string;
  description?: string;
  ogImage?: string;
  href: Href;
  /** Unlisted posts: reachable by link, kept out of search engines (ADR-0002 §3.4). */
  noindex?: boolean;
}): Metadata {
  const { title, description, ogImage, href, noindex } = input;
  return {
    title,
    description,
    alternates: { canonical: publicPath(href) },
    robots: noindex ? { index: false, follow: false } : undefined,
    openGraph: {
      title,
      description,
      locale: "pt_BR",
      images: ogImage ? [{ url: ogImage }] : undefined,
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
      images: ogImage ? [ogImage] : undefined,
    },
  };
}
