import { describe, expect, it } from "vitest";
import { CATEGORIES, categoryFromSegment, categorySegment } from "@/lib/categories";

describe("categories", () => {
  it("uses the Portuguese plural in URLs", () => {
    expect(categorySegment("travel")).toBe("viagens");
  });

  it("maps every URL segment back to its category", () => {
    for (const c of CATEGORIES) expect(categoryFromSegment(categorySegment(c))).toBe(c);
  });

  it("rejects segments that are not categories, including the English enum", () => {
    expect(categoryFromSegment("travel")).toBeNull();
  });
});
