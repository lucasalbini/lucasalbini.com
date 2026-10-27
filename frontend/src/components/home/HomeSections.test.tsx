// @vitest-environment happy-dom
import { describe, expect, it, vi } from "vitest";
import { dom, render } from "@/test/render";
import { CollectionsList, NowSection, VideoGrid } from "@/components/home/HomeSections";

vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));

const VIDEO = {
  video_id: "dQw4w9WgXcQ",
  title: "Belém em 10 minutos",
  url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  published_at: "2026-10-20T15:00:00Z",
  thumbnail_url: "https://i1.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg",
};

describe("NowSection", () => {
  it("is hidden until the profile says what Lucas is living", () => {
    expect(render(<NowSection text={null} />)).toBe("");
  });

  it("shows the text under 'Agora'", () => {
    const text = dom(render(<NowSection text="Editando o vídeo de Belém." />)).body.textContent;

    expect(text).toContain("Agora");
    expect(text).toContain("Editando o vídeo de Belém.");
  });
});

describe("VideoGrid", () => {
  it("is hidden when the channel feed is empty", () => {
    expect(render(<VideoGrid videos={[]} channelUrl={null} />)).toBe("");
  });

  it("links each video and the channel", () => {
    const doc = dom(render(<VideoGrid videos={[VIDEO]} channelUrl="https://youtube.com/@x" />));
    const hrefs = [...doc.querySelectorAll("a")].map((a) => a.getAttribute("href"));

    expect(hrefs).toEqual(["https://youtube.com/@x", VIDEO.url]);
  });

  it("works without a thumbnail or a channel link", () => {
    const doc = dom(render(<VideoGrid videos={[{ ...VIDEO, thumbnail_url: null }]} channelUrl={null} />));

    expect(doc.querySelector("img")).toBeNull();
    expect(doc.querySelectorAll("a")).toHaveLength(1);
  });
});

describe("CollectionsList", () => {
  it("is hidden when there are no collections", () => {
    expect(render(<CollectionsList collections={[]} />)).toBe("");
  });

  it("links each collection to its page", () => {
    const collections = [
      { document_id: "c1", title: "Viagens", slug: "viagens", description: "Lugares", cover: { url: "/uploads/c.jpg" } },
      { document_id: "c2", title: "Projetos", slug: "projetos", description: null, cover: null },
    ];
    const hrefs = [...dom(render(<CollectionsList collections={collections} />)).querySelectorAll("a")].map((a) =>
      a.getAttribute("href"),
    );

    expect(hrefs).toEqual(["/colecoes/viagens", "/colecoes/projetos"]);
  });
});
