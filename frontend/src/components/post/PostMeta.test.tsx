// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { PostMeta } from "@/components/post/PostMeta";
import type { Post } from "@/lib/types";

vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));

const POST = {
  title: "Cinco dias em Belém",
  category: "travel",
  date: "2026-10-10",
  reading_time_minutes: 6,
  collection: { title: "Viagens", slug: "viagens" },
  instagram_url: "https://www.instagram.com/p/ABC/",
  youtube_url: null,
  tags: [{ document_id: "t", label: "Amazônia", slug: "amazonia" }],
} as unknown as Post;

const labels = (html: string) => [...dom(html).querySelectorAll("dt")].map((d) => d.textContent);

describe("PostMeta", () => {
  it("lists category, date, reading time, collection, networks and tags", () => {
    expect(labels(render(<PostMeta post={POST} />))).toEqual(["Categoria", "Data", "Leitura", "Coleção", "Também em", "Tags"]);
  });

  it("links category, collection and tags to their pages", () => {
    const hrefs = [...dom(render(<PostMeta post={POST} />)).querySelectorAll("a")].map((a) => a.getAttribute("href"));

    expect(hrefs).toEqual(["/arquivo/viagens", "/colecoes/viagens", "https://www.instagram.com/p/ABC/", "/tags/amazonia"]);
  });

  it("leaves out what the post does not have", () => {
    const bare = { ...POST, date: null, reading_time_minutes: null, collection: null, instagram_url: null, tags: [] } as unknown as Post;

    expect(labels(render(<PostMeta post={bare} />))).toEqual(["Categoria"]);
  });

  it("shows YouTube when the post has a video", () => {
    const text = dom(render(<PostMeta post={{ ...POST, youtube_url: "https://youtu.be/x" } as Post} />)).body.textContent;

    expect(text).toContain("YouTube");
  });
});
