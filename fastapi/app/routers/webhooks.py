"""Strapi webhook receiver.

Configure in Strapi Admin: Settings → Webhooks → new webhook
  URL:    http://fastapi:8000/hooks/strapi
  Headers: X-Webhook-Secret: <STRAPI_WEBHOOK_SECRET>  (if set)
  Events:  entry.publish, entry.unpublish, entry.update, entry.delete

We drop the affected cache slices locally, then ask Next to revalidate the matching
tags. Single locale (ADR-0002), so tags carry no locale suffix.
"""

from __future__ import annotations

import logging
from typing import NamedTuple

from fastapi import APIRouter, Header, HTTPException, Request

from app.config import settings
from app.services.revalidate import call_next_revalidate
from app.services.strapi_client import invalidate

router = APIRouter(prefix="/hooks", tags=["webhooks"])
log = logging.getLogger(__name__)


class Invalidation(NamedTuple):
    cache_prefixes: tuple[str, ...]  # Strapi endpoints cached by strapi_client
    next_tags: tuple[str, ...]  # tags used by the Next fetches


# Places, collections and tags are populated inside posts, so editing them must also
# drop the cached posts.
INVALIDATIONS: dict[str, Invalidation] = {
    "api::post.post": Invalidation(("posts",), ("posts", "home")),
    "api::place.place": Invalidation(("places", "posts"), ("posts",)),
    "api::collection.collection": Invalidation(("collections", "posts"), ("collections", "posts", "home")),
    "api::tag.tag": Invalidation(("tags", "posts"), ("tags", "posts")),
    "api::profile.profile": Invalidation(("profile",), ("profile", "home")),
    "api::project.project": Invalidation(("projects",), ("projects",)),
    "api::lab.lab": Invalidation(("labs",), ("lab",)),
    "api::experience.experience": Invalidation(("experiences",), ("cv",)),
    "api::education.education": Invalidation(("educations",), ("cv",)),
    "api::certification.certification": Invalidation(("certifications",), ("cv",)),
    "api::skill.skill": Invalidation(("skills",), ("cv",)),
    "api::publication.publication": Invalidation(("publications",), ("publications",)),
}


@router.post("/strapi", status_code=204)
async def strapi_webhook(request: Request, x_webhook_secret: str | None = Header(default=None)):
    if settings.strapi_webhook_secret and x_webhook_secret != settings.strapi_webhook_secret:
        raise HTTPException(status_code=401, detail="invalid webhook secret")

    payload = await request.json()
    event = payload.get("event", "")
    # Strapi v5 sends `model` as the singular name ("post") and the full UID in `uid`.
    uid = payload.get("uid") or payload.get("model", "")
    log.info("strapi webhook event=%s uid=%s", event, uid)

    invalidation = INVALIDATIONS.get(uid)
    if not invalidation:
        return None

    for prefix in invalidation.cache_prefixes:
        dropped = invalidate(prefix=prefix)
        log.info("cache invalidated: %s (%d entries)", prefix, dropped)
    await call_next_revalidate(list(invalidation.next_tags))
    return None
