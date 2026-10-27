import type { MetadataRoute } from "next";
import { listPosts } from "@/lib/api";
import { CATEGORIES, categorySegment } from "@/lib/categories";
import { publicPath } from "@/lib/metadata";

const SITE = process.env.NEXT_PUBLIC_SITE_URL || "http://localhost";

function entry(path: string, priority: number, lastModified?: string | null): MetadataRoute.Sitemap[number] {
  return {
    url: `${SITE}${path}`,
    lastModified: lastModified ? new Date(lastModified) : undefined,
    changeFrequency: "weekly",
    priority,
  };
}

/** Only public posts: the API already leaves unlisted and private ones out of lists. */
export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const posts = await listPosts({ pageSize: 100 }).catch(() => ({ data: [] }));

  return [
    entry(publicPath("/"), 1),
    entry(publicPath("/archive"), 0.8),
    entry(publicPath("/about"), 0.6),
    ...CATEGORIES.map((c) =>
      entry(publicPath({ pathname: "/archive/[category]", params: { category: categorySegment(c) } }), 0.7),
    ),
    ...posts.data.map((p) =>
      entry(publicPath({ pathname: "/[slug]", params: { slug: p.slug } }), 0.6, p.published_at),
    ),
  ];
}
