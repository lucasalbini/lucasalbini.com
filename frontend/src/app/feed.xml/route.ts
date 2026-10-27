import { listPosts } from "@/lib/api";
import { absoluteUrl } from "@/lib/format";
import { buildRss } from "@/lib/rss";

export const revalidate = 3600;

export async function GET() {
  const posts = await listPosts({ pageSize: 50 });
  const xml = buildRss({
    title: "Lucas Albini",
    description: "Viagens, projetos, ideias e o que mais eu viver.",
    siteUrl: absoluteUrl("/"),
    feedUrl: absoluteUrl("/feed.xml"),
    items: posts.data.map((p) => ({
      title: p.title,
      url: absoluteUrl(`/${p.slug}`),
      summary: p.summary,
      publishedAt: p.published_at,
    })),
  });

  return new Response(xml, {
    headers: {
      "content-type": "application/rss+xml; charset=utf-8",
      "cache-control": "public, s-maxage=3600, stale-while-revalidate=86400",
    },
  });
}
