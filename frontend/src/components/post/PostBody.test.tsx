// @vitest-environment happy-dom
import { describe, expect, it } from "vitest";
import { dom, render } from "@/test/render";
import { PostBody } from "@/components/post/PostBody";
import type { Block } from "@/lib/types";

const t = (text: string, marks: Record<string, boolean> = {}) => ({ type: "text" as const, text, ...marks });
const html = (blocks: Block[]) => dom(render(<PostBody blocks={blocks} />));

describe("PostBody (rich text from the Strapi block editor)", () => {
  it("renders paragraphs with inline marks", () => {
    const doc = html([{ type: "paragraph", children: [t("negrito", { bold: true }), t("itálico", { italic: true }), t("cod", { code: true }), t("sub", { underline: true }), t("risco", { strikethrough: true })] }]);

    expect(doc.querySelector("p strong")?.textContent).toBe("negrito");
    expect(doc.querySelector("p em")?.textContent).toBe("itálico");
    expect(doc.querySelector("p code")?.textContent).toBe("cod");
    expect(doc.querySelector("p u")?.textContent).toBe("sub");
    expect(doc.querySelector("p s")?.textContent).toBe("risco");
  });

  it("keeps links clickable inside text", () => {
    const doc = html([{ type: "paragraph", children: [{ type: "link", url: "https://x.com", children: [t("aqui")] }] }]);

    expect(doc.querySelector("a")?.getAttribute("href")).toBe("https://x.com");
  });

  it("never emits an h1 (the post title owns it) and caps depth at h4", () => {
    const doc = html([
      { type: "heading", level: 1, children: [t("um")] },
      { type: "heading", level: 3, children: [t("três")] },
      { type: "heading", level: 6, children: [t("seis")] },
    ]);

    expect([...doc.querySelectorAll("h1,h2,h3,h4,h5,h6")].map((h) => h.tagName)).toEqual(["H2", "H3", "H4"]);
  });

  it("renders ordered and unordered lists", () => {
    const item = (text: string) => ({ type: "list-item", children: [t(text)] }) as unknown as Block["children"] extends (infer C)[] | undefined ? C : never;
    const doc = html([
      { type: "list", format: "ordered", children: [item("um")] },
      { type: "list", format: "unordered", children: [item("dois")] },
    ]);

    expect(doc.querySelector("ol li")?.textContent).toBe("um");
    expect(doc.querySelector("ul li")?.textContent).toBe("dois");
  });

  it("renders quotes and code blocks", () => {
    const doc = html([
      { type: "quote", children: [t("citação")] },
      { type: "code", children: [t("print('oi')")] },
    ]);

    expect(doc.querySelector("blockquote")?.textContent).toBe("citação");
    expect(doc.querySelector("pre code")?.textContent).toBe("print('oi')");
  });

  it("renders inline images and skips images without a file", () => {
    const doc = html([
      { type: "image", image: { url: "/uploads/a.jpg", alternativeText: "Baía" } },
      { type: "image" },
    ]);

    expect([...doc.querySelectorAll("img")].map((i) => i.getAttribute("alt"))).toEqual(["Baía"]);
  });

  it("ignores node types it does not know", () => {
    expect(render(<PostBody blocks={[{ type: "table" }]} />)).toBe("");
  });
});
