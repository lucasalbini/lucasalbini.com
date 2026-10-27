import { describe, expect, it } from "vitest";
import { findSocialLink, pickHomePosts, splitSocialLinks } from "@/lib/home";
import type { PostSummary } from "@/lib/types";

const post = (id: string) => ({ document_id: id }) as PostSummary;
const ids = (posts: PostSummary[]) => posts.map((p) => p.document_id);

describe("pickHomePosts", () => {
  it("leads with the first featured post", () => {
    expect(pickHomePosts([post("f1")], [post("r1")]).lead?.document_id).toBe("f1");
  });

  it("leads with the newest post when nothing is featured", () => {
    expect(pickHomePosts([], [post("r1"), post("r2")]).lead?.document_id).toBe("r1");
  });

  it("never shows a featured post twice when it is also among the recent ones", () => {
    const { lead, rest } = pickHomePosts([post("a")], [post("a"), post("b")]);

    expect([lead?.document_id, ...ids(rest)]).toEqual(["a", "b"]);
  });

  it("caps the total number of posts", () => {
    const recent = ["1", "2", "3", "4", "5"].map(post);

    expect(pickHomePosts([], recent, 3).rest).toHaveLength(2);
  });

  it("has no lead on an empty site", () => {
    expect(pickHomePosts([], [])).toEqual({ lead: null, rest: [] });
  });
});

describe("social links", () => {
  const links = [
    { platform: "github", url: "g" },
    { platform: "YouTube", url: "y" },
    { platform: "instagram", url: "i" },
  ];

  it("puts Instagram then YouTube first and keeps the rest as secondary", () => {
    const { primary, secondary } = splitSocialLinks(links);

    expect(primary.map((l) => l.url)).toEqual(["i", "y"]);
    expect(secondary.map((l) => l.url)).toEqual(["g"]);
  });

  it("finds a network regardless of capitalization", () => {
    expect(findSocialLink(links, "youtube")?.url).toBe("y");
  });

  it("returns null for a network that is not configured", () => {
    expect(findSocialLink(links, "tiktok")).toBeNull();
  });
});
