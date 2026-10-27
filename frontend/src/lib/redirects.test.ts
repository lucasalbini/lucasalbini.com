import { describe, expect, it } from "vitest";
import { LEGACY_REDIRECTS, type Redirect } from "@/lib/redirects";

/**
 * Minimal matcher for the path-to-regexp subset the rules use (`:name`, `:name(a|b)`,
 * `:name*`). Applies the first matching rule, like Next does.
 */
function compile(rule: Redirect): RegExp {
  const pattern = rule.source
    .split("/")
    .map((seg) => {
      const param = seg.match(/^:(\w+)(\(([^)]+)\))?(\*)?$/);
      if (!param) return seg.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
      const [, name, , choices, star] = param;
      if (star) return `(?<${name}>.*)`;
      return `(?<${name}>${choices ?? "[^/]+"})`;
    })
    .join("/");
  return new RegExp(`^${pattern}$`);
}

function resolve(path: string): string | null {
  for (const rule of LEGACY_REDIRECTS) {
    const m = path.match(compile(rule));
    if (!m) continue;
    return rule.destination.replace(/:(\w+)\*?/g, (_, name: string) => m.groups?.[name] ?? "");
  }
  return null;
}

describe("legacy redirects", () => {
  it.each([
    ["/pt/blog/introducao-ao-rag", "/introducao-ao-rag"],
    ["/en/blog/introducao-ao-rag", "/introducao-ao-rag"],
    ["/blog/introducao-ao-rag", "/introducao-ao-rag"],
    ["/pt/blog", "/arquivo"],
    ["/pt/projetos/lucasalbini-com", "/lucasalbini-com"],
    ["/en/projects/lucasalbini-com", "/lucasalbini-com"],
    ["/pt/projetos", "/arquivo/projetos"],
    ["/pt/lab", "/arquivo/ideias"],
    ["/en/about", "/sobre"],
    ["/pt/sobre", "/sobre"],
    ["/pt/publicacoes", "/sobre#publications"],
    ["/pt/feed.xml", "/feed.xml"],
    ["/pt/tags/rag", "/tags/rag"],
    ["/pt", "/"],
    ["/en", "/"],
  ])("%s → %s", (from, to) => {
    expect(resolve(from)).toBe(to);
  });

  it("leaves current URLs alone", () => {
    for (const path of ["/", "/arquivo", "/cinco-dias-em-belem", "/sobre", "/pteronauta"]) {
      expect(resolve(path)).toBeNull();
    }
  });

  it("only issues permanent redirects", () => {
    expect(LEGACY_REDIRECTS.every((r) => r.permanent)).toBe(true);
  });
});
