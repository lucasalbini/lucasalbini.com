/** Timestamp → `YYYY-MM-DD` (UTC) for Strapi `date` fields. Missing or unparseable input
 *  falls back to `fallback`, which callers inject so the result stays deterministic. */
export function toIsoDate(value: Date | string | null | undefined, fallback: Date): string {
  const d = value ? new Date(value) : fallback;
  return (isNaN(d.getTime()) ? fallback : d).toISOString().slice(0, 10);
}
