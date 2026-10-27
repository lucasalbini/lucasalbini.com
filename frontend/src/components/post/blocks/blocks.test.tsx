// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { BlockRenderer, PostBlocks } from "@/components/post/blocks/BlockRenderer";
import type { Place, PostBlock } from "@/lib/types";

vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));
// next/script needs the Next runtime; record it as a plain tag instead.
vi.mock("next/script", () => ({ default: ({ src }: { src: string }) => <script data-src={src} /> }));

const IMG = { url: "/uploads/baia.jpg", width: 1200, height: 800, alternativeText: "Baía do Guajará" };
const PLACE: Place = {
  document_id: "p1",
  name: "Mercado Ver-o-Peso",
  slug: "ver-o-peso",
  kind: "attraction",
  latitude: -1.4525,
  longitude: -48.5034,
  address: null,
  city: "Belém",
  country: "Brasil",
  url: null,
  note: "Ir às 6h.",
  photo: null,
};

const html = (block: PostBlock) => dom(render(<BlockRenderer block={block} />));

describe("BlockRenderer", () => {
  it("renders rich text through the block editor renderer", () => {
    const doc = html({ type: "text", body: [{ type: "paragraph", children: [{ type: "text", text: "Cheguei numa quinta." }] }] });

    expect(doc.querySelector("p")?.textContent).toBe("Cheguei numa quinta.");
  });

  it("ignores block types it does not know", () => {
    expect(render(<BlockRenderer block={{ type: "poll" } as unknown as PostBlock} />)).toBe("");
  });

  it("keeps blocks in the order they were written", () => {
    const blocks: PostBlock[] = [
      { type: "callout", body: "Leve capa de chuva.", tone: "tip" },
      { type: "link", url: "https://github.com/x", title: "Repositório", description: null },
    ];
    const text = dom(render(<PostBlocks blocks={blocks} />)).body.textContent ?? "";

    expect(text.indexOf("Leve capa")).toBeLessThan(text.indexOf("Repositório"));
  });
});

describe("image and gallery", () => {
  it("breaks wide images out of the reading column", () => {
    const figure = html({ type: "image", image: IMG, caption: "Vista da baía", layout: "wide" }).querySelector("figure");

    expect(figure?.className).toContain("bleed-wide");
    expect(figure?.querySelector("figcaption")?.textContent).toBe("Vista da baía");
  });

  it("keeps column images inside the text width", () => {
    const figure = html({ type: "image", image: IMG, caption: null, layout: "column" }).querySelector("figure");

    expect(figure?.className).not.toMatch(/bleed/);
  });

  it("uses the caption as alt text when the image has none", () => {
    const img = html({ type: "image", image: { url: "/u.jpg" }, caption: "Açaí", layout: "full" }).querySelector("img");

    expect(img?.getAttribute("alt")).toBe("Açaí");
  });

  it("links every gallery photo to the full image", () => {
    const doc = html({ type: "gallery", images: [IMG, { ...IMG, url: "/uploads/b.jpg" }], caption: "Ver-o-Peso, 6h" });

    expect([...doc.querySelectorAll("a")].map((a) => a.getAttribute("href"))).toEqual(["/uploads/baia.jpg", "/uploads/b.jpg"]);
  });
});

describe("embeds", () => {
  it("embeds YouTube without cookies", () => {
    const iframe = html({ type: "youtube", url: "https://youtu.be/dQw4w9WgXcQ", caption: null }).querySelector("iframe");

    expect(iframe?.getAttribute("src")).toBe("https://www.youtube-nocookie.com/embed/dQw4w9WgXcQ");
  });

  it("falls back to a plain link when the YouTube URL is not a video", () => {
    const doc = html({ type: "youtube", url: "https://www.youtube.com/@lucas", caption: null });

    expect(doc.querySelector("iframe")).toBeNull();
    expect(doc.querySelector("a")?.getAttribute("href")).toBe("https://www.youtube.com/@lucas");
  });

  it("uses the official Instagram embed, with a link that works before the script runs", () => {
    const doc = html({ type: "instagram", url: "https://www.instagram.com/reel/ABC123/?igsh=x", caption: null });

    expect(doc.querySelector("blockquote.instagram-media")?.getAttribute("data-instgrm-permalink")).toBe(
      "https://www.instagram.com/reel/ABC123/",
    );
    expect(doc.querySelector("blockquote a")?.textContent).toBe("Ver no Instagram");
    expect(doc.querySelector("script")?.getAttribute("data-src")).toBe("https://www.instagram.com/embed.js");
  });
});

describe("places", () => {
  it("numbers each place and offers directions", () => {
    const doc = html({ type: "places", title: "Onde fui", places: [PLACE] });

    expect(doc.querySelector("h2")?.textContent).toBe("Onde fui");
    expect(doc.body.textContent).toContain("Atração · Belém");
    expect(doc.querySelector('a[href*="google.com/maps"]')?.textContent).toBe("Como chegar");
  });

  it("links the place website only when there is one", () => {
    const withSite = html({ type: "places", title: null, places: [{ ...PLACE, url: "https://x.com" }] });
    const withoutSite = html({ type: "places", title: null, places: [PLACE] });

    expect(withSite.querySelector('a[href="https://x.com"]')).not.toBeNull();
    expect(withoutSite.querySelectorAll("a")).toHaveLength(1);
  });
});

describe("download, link and callout", () => {
  it("offers the file for download with its type and size", () => {
    const doc = html({ type: "download", file: { url: "/uploads/roteiro.pdf", ext: ".pdf", size: 1536 }, label: "Roteiro", description: null });
    const a = doc.querySelector("a");

    expect(a?.hasAttribute("download")).toBe(true);
    expect(a?.textContent).toContain("Baixar · PDF · 1,5 MB");
  });

  it("still labels a download whose size is unknown", () => {
    const doc = html({ type: "download", file: { url: "/uploads/x" }, label: "Arquivo", description: null });

    expect(doc.body.textContent).toContain("Baixar");
  });

  it("opens external links in a new tab and shows their domain", () => {
    const a = html({ type: "link", url: "https://www.github.com/lucas", title: "Repo", description: "Código" }).querySelector("a");

    expect(a?.getAttribute("target")).toBe("_blank");
    expect(a?.textContent).toContain("github.com");
  });

  it("labels callouts by tone", () => {
    expect(html({ type: "callout", body: "Cuidado", tone: "warning" }).body.textContent).toContain("Atenção");
  });
});
