import { describe, expect, it } from "vitest";
import { buildRss, escapeXml } from "@/lib/rss";

const FEED = { title: "Lucas Albini", description: "Tudo", siteUrl: "https://x.com/", feedUrl: "https://x.com/feed.xml" };

describe("buildRss", () => {
  it("lists each post as an item with its absolute link", () => {
    const xml = buildRss({
      ...FEED,
      items: [{ title: "Belém", url: "https://x.com/belem", summary: "Açaí", publishedAt: "2026-10-20T12:00:00Z" }],
    });

    expect(xml).toContain("<link>https://x.com/belem</link>");
    expect(xml).toContain("<pubDate>Tue, 20 Oct 2026 12:00:00 GMT</pubDate>");
  });

  it("omits pubDate instead of inventing one when the post has no publish date", () => {
    const xml = buildRss({ ...FEED, items: [{ title: "t", url: "u", summary: "s", publishedAt: null }] });

    expect(xml).not.toContain("<pubDate>");
  });

  it("escapes markup in titles so the feed stays valid XML", () => {
    expect(escapeXml(`Tom & "Jerry" <3 'x'`)).toBe("Tom &amp; &quot;Jerry&quot; &lt;3 &apos;x&apos;");
  });
});
