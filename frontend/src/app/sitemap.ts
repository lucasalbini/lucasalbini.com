import type { MetadataRoute } from "next";
import { routing, getPathname } from "@/lib/i18n/routing";
import { listPosts, listProjects } from "@/lib/api";

const SITE = process.env.NEXT_PUBLIC_SITE_URL || "http://localhost";

type Href = { pathname: string; params?: Record<string, string> };

function alternatesFor(href: Href): Record<string, string> {
  const out: Record<string, string> = {};
  for (const l of routing.locales) {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    out[l === "pt" ? "pt-BR" : l] = `${SITE}${getPathname({ locale: l, href } as any)}`;
  }
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  out["x-default"] = `${SITE}${getPathname({ locale: "en", href } as any)}`;
  return out;
}

function entry(href: Href, priority = 0.5): MetadataRoute.Sitemap[number] {
  return {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    url: `${SITE}${getPathname({ locale: "en", href } as any)}`,
    lastModified: new Date(),
    changeFrequency: "weekly",
    priority,
    alternates: { languages: alternatesFor(href) },
  };
}

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const staticHrefs: Href[] = [
    { pathname: "/" },
    { pathname: "/about" },
    { pathname: "/blog" },
    { pathname: "/projects" },
    { pathname: "/lab" },
    { pathname: "/publications" },
  ];
  const staticEntries = staticHrefs.map((h) => entry(h, h.pathname === "/" ? 1 : 0.7));

  // Dynamic entries: blog posts and projects in both locales.
  const [ptPosts, enPosts, ptProjects, enProjects] = await Promise.all([
    listPosts("pt", { pageSize: 200 }).catch(() => ({ data: [] })),
    listPosts("en", { pageSize: 200 }).catch(() => ({ data: [] })),
    listProjects("pt", { pageSize: 200 }).catch(() => ({ data: [] })),
    listProjects("en", { pageSize: 200 }).catch(() => ({ data: [] })),
  ]);

  const postSlugs = new Set<string>();
  for (const p of ptPosts.data) postSlugs.add(p.slug);
  for (const p of enPosts.data) postSlugs.add(p.slug);
  const projectSlugs = new Set<string>();
  for (const p of ptProjects.data) projectSlugs.add(p.slug);
  for (const p of enProjects.data) projectSlugs.add(p.slug);

  const postEntries = [...postSlugs].map((slug) => entry({ pathname: "/blog/[slug]", params: { slug } }, 0.6));
  const projectEntries = [...projectSlugs].map((slug) => entry({ pathname: "/projects/[slug]", params: { slug } }, 0.6));

  return [...staticEntries, ...postEntries, ...projectEntries];
}
