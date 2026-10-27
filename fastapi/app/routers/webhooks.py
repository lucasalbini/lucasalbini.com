"""Strapi webhook receiver.

Configure in Strapi Admin: Settings → Webhooks → new webhook
  URL:    http://fastapi:8000/hooks/strapi
  Headers: X-Webhook-Secret: <STRAPI_WEBHOOK_SECRET>  (if set)
  Events:  entry.publish, entry.unpublish, entry.update, entry.delete

We drop the affected cache slice locally, then ask Next to revalidate the
matching tags per locale.
"""

from __future__ import annotations

import logging

from fastapi import APIRouter, Header, HTTPException, Request

from app.config import settings
from app.services.revalidate import call_next_revalidate
from app.services.strapi_client import invalidate

router = APIRouter(prefix="/hooks", tags=["webhooks"])
log = logging.getLogger(__name__)

MODEL_TO_ENDPOINT = {
    "api::post.post": "posts",
    "api::project.project": "projects",
    "api::profile.profile": "profile",
    "api::lab.lab": "labs",
    "api::tag.tag": "tags",
    "api::experience.experience": "experiences",
    "api::education.education": "educations",
    "api::certification.certification": "certifications",
    "api::publication.publication": "publications",
    "api::skill.skill": "skills",
}

MODEL_TO_TAG_PREFIX = {
    "api::post.post": "posts",
    "api::project.project": "projects",
    "api::profile.profile": "profile",
    "api::lab.lab": "lab",
    "api::tag.tag": "tags",
    "api::experience.experience": "cv",
    "api::education.education": "cv",
    "api::certification.certification": "cv",
    "api::skill.skill": "cv",
    "api::publication.publication": "publications",
}


@router.post("/strapi", status_code=204)
async def strapi_webhook(request: Request, x_webhook_secret: str | None = Header(default=None)):
    if settings.strapi_webhook_secret and x_webhook_secret != settings.strapi_webhook_secret:
        raise HTTPException(status_code=401, detail="invalid webhook secret")

    payload = await request.json()
    event = payload.get("event", "")
    model = payload.get("model", "")
    entry = payload.get("entry", {}) or {}
    locale = entry.get("locale") or "*"

    log.info("strapi webhook event=%s model=%s locale=%s", event, model, locale)

    endpoint = MODEL_TO_ENDPOINT.get(model)
    if endpoint:
        dropped = invalidate(prefix=endpoint)
        log.info("cache invalidated: %s (%d entries)", endpoint, dropped)

    tag_prefix = MODEL_TO_TAG_PREFIX.get(model)
    tags: list[str] = []
    if tag_prefix:
        if locale == "*":
            tags = [f"{tag_prefix}:{loc}" for loc in settings.supported_locales]
        else:
            tags = [f"{tag_prefix}:{locale}"]
        # Home shows featured — always revalidate home too on content changes.
        if tag_prefix in {"posts", "projects", "lab"}:
            for loc in settings.supported_locales:
                tags.append(f"home:{loc}")

    if tags:
        await call_next_revalidate(tags)
    return None
