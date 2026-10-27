// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { SocialLinks } from "@/components/ui/SocialLinks";

vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));
vi.mock("next-intl/server", async () => (await import("@/test/render")).intlServerMock());
// The toggle is a client component wired to next-themes; it has its own concerns.
vi.mock("@/components/layout/ThemeToggle", () => ({ ThemeToggle: () => null }));

describe("Header", () => {
  it("navigates to the Portuguese routes with no locale prefix", async () => {
    const doc = dom(render(await Header()));
    const hrefs = [...doc.querySelectorAll("nav a")].map((a) => a.getAttribute("href"));

    expect(hrefs).toEqual(["/arquivo", "/arquivo/viagens", "/arquivo/projetos", "/sobre"]);
  });
});

describe("Footer", () => {
  it("prints the year it is given", async () => {
    const doc = dom(render(await Footer({ links: [], year: 2031 })));

    expect(doc.body.textContent).toContain("© 2031");
  });

  it("links the single unprefixed RSS feed", async () => {
    const doc = dom(render(await Footer({ links: [], year: 2026 })));

    expect(doc.querySelector('a[aria-label="RSS"]')?.getAttribute("href")).toBe("/feed.xml");
  });
});

describe("SocialLinks", () => {
  it("labels Instagram and YouTube links by platform", () => {
    const links = [
      { platform: "instagram", url: "https://instagram.com/x" },
      { platform: "YouTube", url: "https://youtube.com/@x" },
    ];
    const labels = [...dom(render(<SocialLinks links={links} />)).querySelectorAll("a")].map((a) => a.getAttribute("aria-label"));

    expect(labels).toEqual(["instagram", "YouTube"]);
  });
});
