import { afterEach, describe, expect, it, vi } from "vitest";
import { getCV, getLatestVideos, getPost, getProfile, listPosts, NotFoundError, qs } from "@/lib/api";

function mockFetch(status: number, body: unknown = {}) {
  const fn = vi.fn(async () => new Response(JSON.stringify(body), { status }));
  vi.stubGlobal("fetch", fn);
  return fn;
}

function requested(fn: ReturnType<typeof mockFetch>): { url: URL; init: RequestInit & { next?: { tags?: string[] } } } {
  const [url, init] = fn.mock.calls[0] as unknown as [string, RequestInit & { next?: { tags?: string[] } }];
  return { url: new URL(url), init };
}

afterEach(() => {
  vi.unstubAllGlobals();
});

describe("listPosts", () => {
  it("sends only the filters that were given", async () => {
    const fetch = mockFetch(200, { data: [], pagination: {} });

    await listPosts({ category: "travel", pageSize: 6 });

    const { url } = requested(fetch);
    expect(url.pathname).toBe("/posts");
    expect(Object.fromEntries(url.searchParams)).toEqual({ category: "travel", pageSize: "6" });
  });

  it("tags the fetch so a published post refreshes lists and the home", async () => {
    const fetch = mockFetch(200, { data: [], pagination: {} });

    await listPosts();

    expect(requested(fetch).init.next?.tags).toEqual(["posts", "home"]);
  });
});

describe("getPost", () => {
  it("returns null for a missing (or private) post instead of throwing", async () => {
    mockFetch(404);

    await expect(getPost("belem-diario")).resolves.toBeNull();
  });

  it("encodes the slug into the path", async () => {
    const fetch = mockFetch(200, {});

    await getPost("a b");

    expect(requested(fetch).url.pathname).toBe("/posts/a%20b");
  });

  it("surfaces server errors so the page shows an error, not a 404", async () => {
    mockFetch(500);

    await expect(getPost("x")).rejects.toThrow("GET /posts/x -> 500");
  });
});

describe("other endpoints", () => {
  it("asks for the profile without a locale", async () => {
    const fetch = mockFetch(200, { name: "Lucas" });

    await getProfile();

    expect(requested(fetch).url.search).toBe("");
  });

  it("still asks for the CV in pt-BR, since those entries stay localized in Strapi", async () => {
    const fetch = mockFetch(200, {});

    await getCV();

    expect(requested(fetch).url.searchParams.get("locale")).toBe("pt-BR");
  });

  it("treats a missing YouTube endpoint as no videos", async () => {
    mockFetch(404);

    await expect(getLatestVideos()).resolves.toEqual([]);
  });
});

describe("qs", () => {
  it("drops null and undefined but keeps false and zero", () => {
    expect(qs({ a: undefined, b: null, c: false, d: 0 })).toBe("?c=false&d=0");
  });

  it("is empty when nothing is set", () => {
    expect(qs({})).toBe("");
  });
});

it("NotFoundError names the missing path", () => {
  expect(new NotFoundError("/x").message).toBe("not found: /x");
});
