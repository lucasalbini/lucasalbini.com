import { test } from "node:test";
import assert from "node:assert/strict";
import { revalidationWebhookSpec, webhookDiffers, WEBHOOK_EVENTS } from "./revalidation-webhook.ts";

test("points at the FastAPI receiver inside the compose network by default", () => {
  assert.equal(revalidationWebhookSpec({}).url, "http://fastapi:8000/hooks/strapi");
});

test("signs requests with the shared secret the FastAPI checks", () => {
  const spec = revalidationWebhookSpec({ STRAPI_WEBHOOK_SECRET: "s3cret" });
  assert.deepEqual(spec.headers, { "X-Webhook-Secret": "s3cret" });
});

test("sends no secret header when none is configured", () => {
  assert.deepEqual(revalidationWebhookSpec({ STRAPI_WEBHOOK_SECRET: "" }).headers, {});
});

test("covers publish and unpublish, so hiding a post refreshes the site", () => {
  const events = revalidationWebhookSpec({}).events;
  assert.ok(events.includes("entry.publish") && events.includes("entry.unpublish"));
});

test("a stored webhook matching the spec needs no update", () => {
  const spec = revalidationWebhookSpec({ STRAPI_WEBHOOK_SECRET: "a" });
  assert.equal(webhookDiffers({ ...spec, events: [...WEBHOOK_EVENTS].reverse(), isEnabled: true }, spec), false);
});

test("a rotated secret, a moved URL or a disabled webhook triggers an update", () => {
  const spec = revalidationWebhookSpec({ STRAPI_WEBHOOK_SECRET: "new" });
  assert.equal(webhookDiffers({ ...spec, headers: { "X-Webhook-Secret": "old" } }, spec), true);
  assert.equal(webhookDiffers({ ...spec, url: "http://elsewhere/hook" }, spec), true);
  assert.equal(webhookDiffers({ ...spec, isEnabled: false }, spec), true);
});
