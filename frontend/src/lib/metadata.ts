import type { Metadata } from "next";
import type { Locale } from "@/lib/i18n/routing";
import { getPathname, routing } from "@/lib/i18n/routing";

interface AlternatesInput {
  href: {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    pathname: any;
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    params?: any;
  };
}

/**
 * Build hreflang alternates for a page. Always includes both locales and x-default (→ en).
 * Use in generateMetadata() so search engines see the equivalent URL in each language.
 */
export function alternates({ href }: AlternatesInput): Metadata["alternates"] {
  const languages: Record<string, string> = {};
  for (const locale of routing.locales) {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    languages[locale === "pt" ? "pt-BR" : locale] = getPathname({ locale, href } as any);
  }
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  languages["x-default"] = getPathname({ locale: "en", href } as any);
  return { languages };
}

export function pageMetadata(input: {
  locale: Locale;
  title: string;
  description?: string;
  ogImage?: string;
  href: AlternatesInput["href"];
}): Metadata {
  const { locale, title, description, ogImage, href } = input;
  return {
    title,
    description,
    alternates: alternates({ href }),
    openGraph: {
      title,
      description,
      locale: locale === "pt" ? "pt_BR" : "en_US",
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
