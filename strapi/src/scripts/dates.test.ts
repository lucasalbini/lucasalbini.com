import { test } from "node:test";
import assert from "node:assert/strict";
import { toIsoDate } from "./dates.ts";

const FALLBACK = new Date("2026-01-01T00:00:00Z");

test("legacy timestamp becomes its UTC calendar day", () => {
  assert.equal(toIsoDate("2026-02-15T23:30:00.000Z", FALLBACK), "2026-02-15");
});

test("Date objects from pg rows are accepted", () => {
  assert.equal(toIsoDate(new Date("2025-07-04T10:00:00Z"), FALLBACK), "2025-07-04");
});

test("missing timestamp uses the injected fallback day", () => {
  assert.equal(toIsoDate(null, FALLBACK), "2026-01-01");
});

test("unparseable timestamp uses the fallback instead of throwing", () => {
  assert.equal(toIsoDate("not a date", FALLBACK), "2026-01-01");
});
