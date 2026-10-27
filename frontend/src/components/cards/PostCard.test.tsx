// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { FeaturedPostCard, PostCard, PostRow } from "@/components/cards/PostCard";
import type { PostSummary } from "@/lib/types";

vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));

const POST: PostSummary = {
  document_id: "d1",
  title: "Cinco dias em Belém",
  slug: "cinco-dias-em-belem",
  summary: "Açaí e chuva.",
  cover: null,
  category: "travel",
  visibility: "public",
  date: "2026-10-10",
  tags: [],
  collection: null,
  featured: false,
  featured_order: 0,
  published_at: null,
};

describe("post cards", () => {
  it("link to the post at the site root", () => {
    const doc = dom(render(<PostCard post={POST} />));

    expect(doc.querySelector("a")?.getAttribute("href")).toBe("/cinco-dias-em-belem");
  });

  it("show the category in Portuguese and the day of the experience", () => {
    const text = dom(render(<FeaturedPostCard post={POST} />)).body.textContent;

    expect(text).toContain("Viagem");
    expect(text).toContain("10 de out. de 2026");
  });

  it("fall back to the title when there is no cover image", () => {
    const doc = dom(render(<PostCard post={POST} />));

    expect(doc.querySelector("img")).toBeNull();
    expect(doc.body.textContent?.match(/Cinco dias em Belém/g)).toHaveLength(2);
  });

  it("use the cover alt text when the image has one", () => {
    const post = { ...POST, cover: { url: "/uploads/c.jpg", alternativeText: "Baía do Guajará" } };

    expect(dom(render(<PostCard post={post} />)).querySelector("img")?.getAttribute("alt")).toBe("Baía do Guajará");
  });

  it("render as a compact row with the date", () => {
    const doc = dom(render(<ul><PostRow post={POST} /></ul>));

    expect(doc.querySelector("time")?.getAttribute("datetime")).toBe("2026-10-10");
  });
});
