/**
 * The webhook that keeps the site fresh: every content change in Strapi is POSTed to the
 * FastAPI receiver, which drops its cache and revalidates the Next pages (ADR-0001 §3.4).
 * Kept as code so a fresh database (or a new server) never ends up without it.
 */

export const WEBHOOK_NAME = "revalidate-site";

export const WEBHOOK_EVENTS = [
  "entry.create",
  "entry.update",
  "entry.delete",
  "entry.publish",
  "entry.unpublish",
] as const;

export interface WebhookSpec {
  name: string;
  url: string;
  headers: Record<string, string>;
  events: string[];
}

export function revalidationWebhookSpec(env: Record<string, string | undefined>): WebhookSpec {
  const secret = env.STRAPI_WEBHOOK_SECRET ?? "";
  return {
    name: WEBHOOK_NAME,
    url: env.REVALIDATION_WEBHOOK_URL || "http://fastapi:8000/hooks/strapi",
    // Empty secret: the FastAPI skips the check too (development only).
    headers: secret ? { "X-Webhook-Secret": secret } : {},
    events: [...WEBHOOK_EVENTS],
  };
}

/** True when the stored webhook differs from what the environment asks for. */
export function webhookDiffers(existing: Partial<WebhookSpec> & { isEnabled?: boolean }, spec: WebhookSpec): boolean {
  const sameEvents =
    (existing.events ?? []).length === spec.events.length && spec.events.every((e) => existing.events?.includes(e));
  return (
    existing.url !== spec.url ||
    JSON.stringify(existing.headers ?? {}) !== JSON.stringify(spec.headers) ||
    !sameEvents ||
    existing.isEnabled === false
  );
}
