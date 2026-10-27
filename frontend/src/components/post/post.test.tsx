// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { pickRelated, RelatedPosts } from "@/components/post/RelatedPosts";
import { CategoryNav } from "@/components/post/CategoryNav";
import { PostList } from "@/components/post/PostList";
import { AuthorBio } from "@/components/post/AuthorBio";
import type { PostSummary, Profile } from "@/lib/types";

vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));

function post(id: string, overrides: Partial<PostSummary> = {}): PostSummary {
  return {
    document_id: id,
    title: `Post ${id}`,
    slug: `post-${id}`,
    summary: "",
    cover: null,
    category: "work",
    visibility: "public",
    date: "2026-01-01",
    tags: [],
    collection: null,
    featured: false,
    featured_order: 0,
    published_at: null,
    ...overrides,
  };
}

const tag = (slug: string) => ({ document_id: slug, label: slug, slug });

describe("pickRelated", () => {
  const current = post("belem", { category: "travel", tags: [tag("amazonia")] });

  it("never suggests the post being read", () => {
    expect(pickRelated(current, [current]).map((p) => p.document_id)).toEqual([]);
  });

  it("prefers the same category over shared tags", () => {
    const sameCategory = post("rio", { category: "travel" });
    const sharedTag = post("rag", { tags: [tag("amazonia")] });

    expect(pickRelated(current, [sharedTag, sameCategory])[0].document_id).toBe("rio");
  });

  it("breaks ties with the most recent date", () => {
    const older = post("a", { category: "travel", date: "2025-01-01" });
    const newer = post("b", { category: "travel", date: "2026-05-01" });

    expect(pickRelated(current, [older, newer]).map((p) => p.document_id)).toEqual(["b", "a"]);
  });

  it("returns at most three suggestions", () => {
    const many = ["1", "2", "3", "4"].map((id) => post(id));

    expect(pickRelated(current, many)).toHaveLength(3);
  });
});

describe("RelatedPosts", () => {
  it("renders nothing when there is nothing to suggest", () => {
    expect(render(<RelatedPosts current={post("x")} candidates={[]} />)).toBe("");
  });

  it("links each suggestion to its post", () => {
    const doc = dom(render(<RelatedPosts current={post("x")} candidates={[post("y")]} />));

    expect(doc.querySelector("a")?.getAttribute("href")).toBe("/post-y");
  });
});

describe("CategoryNav", () => {
  it("lists every category under /arquivo in Portuguese", () => {
    const hrefs = [...dom(render(<CategoryNav active={null} />)).querySelectorAll("a")].map((a) => a.getAttribute("href"));

    expect(hrefs).toEqual(["/arquivo", "/arquivo/viagens", "/arquivo/projetos", "/arquivo/ideias", "/arquivo/vida", "/arquivo/trabalho"]);
  });

  it("marks the active category as the current page", () => {
    const current = dom(render(<CategoryNav active="idea" />)).querySelector('[aria-current="page"]');

    expect(current?.textContent).toBe("Ideias");
  });
});

describe("PostList", () => {
  it("shows the empty message when there are no posts", () => {
    expect(dom(render(<PostList posts={[]} empty="Nada aqui." />)).body.textContent).toBe("Nada aqui.");
  });

  it("renders every post once", () => {
    const doc = dom(render(<PostList posts={[post("1"), post("2"), post("3")]} empty="" />));

    expect([...doc.querySelectorAll("a")].map((a) => a.getAttribute("href"))).toEqual(["/post-1", "/post-2", "/post-3"]);
  });
});

describe("AuthorBio", () => {
  const profile = { name: "Lucas Albini", role: "Tech Lead", short_bio: "Escrevo sobre o que vivo." } as Profile;

  it("renders nothing without a profile", () => {
    expect(render(<AuthorBio profile={null} />)).toBe("");
  });

  it("points readers to the about page", () => {
    const doc = dom(render(<AuthorBio profile={profile} />));

    expect(doc.querySelector('a[href="/sobre"]')).not.toBeNull();
  });
});
