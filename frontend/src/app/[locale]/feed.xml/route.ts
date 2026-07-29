import type { Locale } from "@/lib/i18n/routing";
import { listPosts } from "@/lib/api";
import { absoluteUrl } from "@/lib/format";

function escapeXml(s: string) {
  return s
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

export const revalidate = 3600;

export async function GET(_req: Request, { params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  const supported: Locale[] = ["pt", "en"];
  if (!supported.includes(locale as Locale)) {
    return new Response("Not Found", { status: 404 });
  }
  const loc = locale as Locale;

  const posts = await listPosts(loc, { pageSize: 50 });
  const site = process.env.NEXT_PUBLIC_SITE_URL || "http://localhost";
  const feedUrl = `${site}/${loc}/feed.xml`;
  const homeUrl = `${site}/${loc}`;
  const title = loc === "pt" ? "Lucas Albini — Blog" : "Lucas Albini — Blog";
  const desc = loc === "pt"
    ? "Posts sobre IA aplicada, engenharia e desenvolvimento de jogos."
    : "Posts on applied AI, engineering and game development.";

  const items = posts.data.map((p) => {
    const url = absoluteUrl(`/${loc}/blog/${p.slug}`);
    return `
    <item>
      <title>${escapeXml(p.title)}</title>
      <link>${escapeXml(url)}</link>
      <guid isPermaLink="true">${escapeXml(url)}</guid>
      <pubDate>${p.published_at ? new Date(p.published_at).toUTCString() : new Date().toUTCString()}</pubDate>
      <description>${escapeXml(p.summary)}</description>
    </item>`;
  }).join("");

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>${escapeXml(title)}</title>
    <link>${escapeXml(homeUrl)}</link>
    <description>${escapeXml(desc)}</description>
    <language>${loc === "pt" ? "pt-BR" : "en"}</language>
    <atom:link href="${escapeXml(feedUrl)}" rel="self" type="application/rss+xml"/>
    ${items}
  </channel>
</rss>`;

  return new Response(xml, {
    headers: {
      "content-type": "application/rss+xml; charset=utf-8",
      "cache-control": "public, s-maxage=3600, stale-while-revalidate=86400",
    },
  });
}
