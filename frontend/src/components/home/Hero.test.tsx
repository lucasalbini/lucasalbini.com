// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { Hero } from "@/components/home/Hero";
import type { Profile } from "@/lib/types";

vi.mock("next-intl/server", async () => (await import("@/test/render")).intlServerMock());

const profile = (overrides: Partial<Profile> = {}) =>
  ({ name: "Lucas Albini", short_bio: null, location: null, avatar: null, social_links: [], ...overrides }) as Profile;

describe("Hero", () => {
  it("turns Instagram and YouTube into follow buttons", async () => {
    const links = [
      { platform: "youtube", url: "https://youtube.com/@x" },
      { platform: "instagram", url: "https://instagram.com/x" },
      { platform: "github", url: "https://github.com/x" },
    ];
    const doc = dom(render(await Hero({ profile: profile({ social_links: links }) })));

    expect([...doc.querySelectorAll("a.btn-primary")].map((a) => a.textContent)).toEqual(["Instagram", "YouTube"]);
    expect(doc.querySelector('a[aria-label="github"]')).not.toBeNull();
  });

  it("falls back to the default links when the profile has none", async () => {
    const doc = dom(render(await Hero({ profile: null })));

    expect(doc.querySelectorAll("a.btn-primary")).toHaveLength(0);
    expect(doc.querySelector('a[aria-label="linkedin"]')).not.toBeNull();
  });

  it("shows initials when the profile has no avatar", async () => {
    expect(dom(render(await Hero({ profile: profile() }))).body.textContent).toContain("LA");
  });

  it("shows the avatar when there is one", async () => {
    const doc = dom(render(await Hero({ profile: profile({ avatar: { url: "/uploads/eu.jpg" }, location: "Curitiba" }) })));

    expect(doc.querySelector("img")?.getAttribute("alt")).toBe("Lucas Albini");
    expect(doc.body.textContent).toContain("Curitiba");
  });
});
