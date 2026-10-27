// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { PostHeader } from "@/components/post/PostHeader";
import type { Post } from "@/lib/types";

vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));

const POST = {
  title: "Cinco dias em Belém",
  summary: "Açaí e chuva.",
  category: "travel",
  date: "2026-10-10",
  collection: { title: "Viagens", slug: "viagens" },
  reading_time_minutes: 4,
  instagram_url: "https://www.instagram.com/reel/ABC/",
  youtube_url: null,
} as unknown as Post;

describe("PostHeader", () => {
  it("links the category and the collection the post belongs to", () => {
    const hrefs = [...dom(render(<PostHeader post={POST} />)).querySelectorAll("p a")].map((a) => a.getAttribute("href"));

    expect(hrefs).toEqual(["/arquivo/viagens", "/colecoes/viagens"]);
  });

  it("points to the Instagram version and omits the missing YouTube one", () => {
    const text = dom(render(<PostHeader post={POST} />)).body.textContent;

    expect(text).toContain("Ver no Instagram");
    expect(text).not.toContain("Ver no YouTube");
  });

  it("shows the day of the experience and reading time", () => {
    const text = dom(render(<PostHeader post={{ ...POST, collection: null }} />)).body.textContent;

    expect(text).toContain("10 de outubro de 2026");
    expect(text).toContain("4 min de leitura");
  });
});
