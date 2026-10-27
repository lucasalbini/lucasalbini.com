import { afterEach, describe, expect, it, vi } from "vitest";

import { absoluteUrl, formatDate, formatShortDate, formatYear, mediaUrl } from "@/lib/format";

// Midday UTC keeps the calendar day stable in any runner timezone.
const ISO = "2024-03-15T12:00:00Z";

afterEach(() => {
  vi.unstubAllEnvs();
});

describe("formatDate", () => {
  it("writes the long Brazilian date for the pt locale", () => {
    expect(formatDate(ISO, "pt")).toBe("15 de março de 2024");
  });

  it("writes the long US date for the en locale", () => {
    expect(formatDate(ISO, "en")).toBe("March 15, 2024");
  });

  it("returns an empty string when there is no date", () => {
    expect(formatDate(null, "pt")).toBe("");
  });

  it("returns the raw input when it is not a parseable date", () => {
    expect(formatDate("em breve", "pt")).toBe("em breve");
  });
});

describe("formatShortDate", () => {
  it("uses a two-digit day and abbreviated month", () => {
    expect(formatShortDate(ISO, "en")).toBe("Mar 15, 2024");
  });
});

describe("formatYear", () => {
  it("extracts the year from an ISO date", () => {
    expect(formatYear(ISO)).toBe("2024");
  });

  it("returns an empty string when there is no date", () => {
    expect(formatYear(undefined)).toBe("");
  });
});

describe("absoluteUrl", () => {
  it("prefixes a relative path with the site URL without doubling slashes", () => {
    vi.stubEnv("NEXT_PUBLIC_SITE_URL", "https://lucasalbini.com/");

    expect(absoluteUrl("/pt/blog")).toBe("https://lucasalbini.com/pt/blog");
  });

  it("adds the missing leading slash to the path", () => {
    vi.stubEnv("NEXT_PUBLIC_SITE_URL", "https://lucasalbini.com");

    expect(absoluteUrl("pt/blog")).toBe("https://lucasalbini.com/pt/blog");
  });

  it("falls back to localhost when the site URL is not configured", () => {
    vi.stubEnv("NEXT_PUBLIC_SITE_URL", "");

    expect(absoluteUrl("/pt")).toBe("http://localhost/pt");
  });

  it("keeps URLs that are already absolute", () => {
    expect(absoluteUrl("https://github.com/lucasalbini")).toBe("https://github.com/lucasalbini");
  });
});

describe("mediaUrl", () => {
  it("prefixes a relative Strapi upload with the public Strapi URL", () => {
    vi.stubEnv("NEXT_PUBLIC_STRAPI_URL", "https://cms.example.com/");

    expect(mediaUrl("/uploads/cover.jpg")).toBe("https://cms.example.com/uploads/cover.jpg");
  });

  it("falls back to the site URL when no Strapi URL is set", () => {
    vi.stubEnv("NEXT_PUBLIC_STRAPI_URL", "");
    vi.stubEnv("NEXT_PUBLIC_SITE_URL", "https://lucasalbini.com");

    expect(mediaUrl("/uploads/cover.jpg")).toBe("https://lucasalbini.com/uploads/cover.jpg");
  });

  it("keeps absolute media URLs untouched", () => {
    expect(mediaUrl("https://cdn.example.com/a.gif")).toBe("https://cdn.example.com/a.gif");
  });

  it("returns an empty string when there is no media", () => {
    expect(mediaUrl(null)).toBe("");
  });
});
