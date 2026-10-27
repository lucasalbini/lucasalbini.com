import { describe, expect, it } from "vitest";
import { pageMetadata, publicPath } from "@/lib/metadata";

describe("publicPath", () => {
  it("translates internal pathnames to Portuguese without a locale prefix", () => {
    expect(publicPath({ pathname: "/archive/[category]", params: { category: "viagens" } })).toBe("/arquivo/viagens");
  });

  it("puts posts at the root", () => {
    expect(publicPath({ pathname: "/[slug]", params: { slug: "cinco-dias-em-belem" } })).toBe("/cinco-dias-em-belem");
  });
});

describe("pageMetadata", () => {
  it("sets the canonical URL to the public path", () => {
    expect(pageMetadata({ title: "Sobre", href: "/about" }).alternates).toEqual({ canonical: "/sobre" });
  });

  it("keeps unlisted pages out of search engines", () => {
    expect(pageMetadata({ title: "t", href: "/", noindex: true }).robots).toEqual({ index: false, follow: false });
  });

  it("lets public pages be indexed", () => {
    expect(pageMetadata({ title: "t", href: "/" }).robots).toBeUndefined();
  });
});
