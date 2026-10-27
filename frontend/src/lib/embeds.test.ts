import { describe, expect, it } from "vitest";
import { fileInfo, instagramPermalink, mapsUrl, youtubeEmbedUrl, youtubeId } from "@/lib/embeds";

describe("youtubeId", () => {
  it.each([
    ["https://www.youtube.com/watch?v=dQw4w9WgXcQ&t=42s", "dQw4w9WgXcQ"],
    ["https://youtu.be/dQw4w9WgXcQ?si=abc", "dQw4w9WgXcQ"],
    ["https://m.youtube.com/watch?v=dQw4w9WgXcQ", "dQw4w9WgXcQ"],
    ["https://www.youtube.com/shorts/dQw4w9WgXcQ", "dQw4w9WgXcQ"],
    ["https://www.youtube.com/live/dQw4w9WgXcQ", "dQw4w9WgXcQ"],
    ["https://www.youtube-nocookie.com/embed/dQw4w9WgXcQ", "dQw4w9WgXcQ"],
  ])("reads the id from %s", (url, id) => {
    expect(youtubeId(url)).toBe(id);
  });

  it.each([
    "https://www.youtube.com/@lucas",
    "https://vimeo.com/123",
    "https://www.youtube.com/watch?v=curto",
    "não é url",
  ])("returns null for %s", (url) => {
    expect(youtubeId(url)).toBeNull();
  });

  it("embeds through the no-cookie domain", () => {
    expect(youtubeEmbedUrl("dQw4w9WgXcQ")).toBe("https://www.youtube-nocookie.com/embed/dQw4w9WgXcQ");
  });
});

describe("instagramPermalink", () => {
  it("strips tracking params from a shared reel", () => {
    expect(instagramPermalink("https://www.instagram.com/reel/C0abc_-1/?igsh=xyz")).toBe(
      "https://www.instagram.com/reel/C0abc_-1/",
    );
  });

  it("accepts posts linked through a profile path", () => {
    expect(instagramPermalink("https://instagram.com/lucas.albini/p/ABC123/")).toBe("https://www.instagram.com/p/ABC123/");
  });

  it("normalizes the /reels/ share path to /reel/", () => {
    expect(instagramPermalink("https://www.instagram.com/reels/ABC123/")).toBe("https://www.instagram.com/reel/ABC123/");
  });

  it.each(["https://www.instagram.com/lucas/", "https://example.com/reel/ABC/", "x"])("rejects %s", (url) => {
    expect(instagramPermalink(url)).toBeNull();
  });
});

describe("helpers", () => {
  it("builds a Google Maps search for the coordinates", () => {
    expect(mapsUrl(-1.4525, -48.5034)).toBe("https://www.google.com/maps/search/?api=1&query=-1.4525,-48.5034");
  });

  it.each([
    [".pdf", 1536, "PDF · 1,5 MB"],
    [".zip", 0.2, "ZIP · 1 KB"],
    [null, 74.12, "74 KB"],
    [".jpg", null, "JPG"],
    [null, null, ""],
  ])("describes %s of %s KB as %s", (ext, size, expected) => {
    expect(fileInfo(ext, size)).toBe(expected);
  });
});
