// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { Hero } from "@/components/home/Hero";
import type { Profile } from "@/lib/types";

vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));
vi.mock("next-intl/server", async () => (await import("@/test/render")).intlServerMock());

describe("Hero", () => {
  it("sends visitors to the archive instead of a projects page", async () => {
    const doc = dom(render(await Hero({ profile: null })));

    expect(doc.querySelector('a[href="/arquivo"]')?.textContent).toBe("Ver o arquivo");
  });

  it("shows initials when the profile has no avatar", async () => {
    const doc = dom(render(await Hero({ profile: { name: "Lucas Albini", social_links: [] } as unknown as Profile })));

    expect(doc.body.textContent).toContain("LA");
  });
});
