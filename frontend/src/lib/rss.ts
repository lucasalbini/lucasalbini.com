export interface RssItem {
  title: string;
  url: string;
  summary: string;
  publishedAt: string | null;
}

export function escapeXml(s: string): string {
  return s
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

function item(i: RssItem): string {
  const pubDate = i.publishedAt ? `\n      <pubDate>${new Date(i.publishedAt).toUTCString()}</pubDate>` : "";
  return `
    <item>
      <title>${escapeXml(i.title)}</title>
      <link>${escapeXml(i.url)}</link>
      <guid isPermaLink="true">${escapeXml(i.url)}</guid>${pubDate}
      <description>${escapeXml(i.summary)}</description>
    </item>`;
}

export function buildRss(feed: {
  title: string;
  description: string;
  siteUrl: string;
  feedUrl: string;
  items: RssItem[];
}): string {
  return `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>${escapeXml(feed.title)}</title>
    <link>${escapeXml(feed.siteUrl)}</link>
    <description>${escapeXml(feed.description)}</description>
    <language>pt-BR</language>
    <atom:link href="${escapeXml(feed.feedUrl)}" rel="self" type="application/rss+xml"/>${feed.items.map(item).join("")}
  </channel>
</rss>`;
}
