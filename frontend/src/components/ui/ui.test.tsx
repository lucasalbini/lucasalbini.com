// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { Container } from "@/components/layout/Container";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { AuthorBio } from "@/components/post/AuthorBio";
import type { Profile } from "@/lib/types";

vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));

describe("Container", () => {
  it.each([
    ["reading", "max-w-[46rem]"],
    ["wide", "max-w-5xl"],
    ["full", "max-w-5xl"],
    ["default", "max-w-3xl"],
  ] as const)("%s width uses %s", (size, cls) => {
    expect(dom(render(<Container size={size}>x</Container>)).querySelector("div")?.className).toContain(cls);
  });

  it("can render as another element", () => {
    expect(dom(render(<Container as="section">x</Container>)).querySelector("section")).not.toBeNull();
  });
});

describe("SectionHeading", () => {
  it("adds a 'see all' link when given one", () => {
    const doc = dom(render(<SectionHeading title="Recentes" linkHref="/archive" linkLabel="Ver tudo" />));

    expect(doc.querySelector("a")?.getAttribute("href")).toBe("/arquivo");
  });

  it("is just the title without a link", () => {
    expect(dom(render(<SectionHeading title="Agora" />)).querySelector("a")).toBeNull();
  });
});

describe("AuthorBio", () => {
  it("shows the avatar, role and company when the profile has them", () => {
    const profile = { name: "Lucas", role: "Tech Lead", company: "Atos", avatar: { url: "/uploads/eu.jpg" } } as Profile;
    const doc = dom(render(<AuthorBio profile={profile} />));

    expect(doc.querySelector("img")?.getAttribute("alt")).toBe("Lucas");
    expect(doc.body.textContent).toContain("Tech Lead · Atos");
  });
});
