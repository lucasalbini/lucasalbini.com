"""Trigger revalidateTag on the Next frontend after Strapi content changes.

The Next side exposes GET /api/revalidate?tag=<tag>&secret=<REVALIDATE_SECRET>.
Silently no-ops if next_url or revalidate_secret is missing (useful in tests).
"""

from __future__ import annotations

import logging

import httpx

from app.config import settings

log = logging.getLogger(__name__)


async def call_next_revalidate(tags: list[str]) -> None:
    if not settings.next_url or not settings.revalidate_secret:
        log.debug("revalidate skipped: next_url or revalidate_secret not set")
        return
    async with httpx.AsyncClient(timeout=10) as client:
        for tag in tags:
            try:
                r = await client.post(
                    f"{settings.next_url.rstrip('/')}/api/revalidate",
                    params={"tag": tag, "secret": settings.revalidate_secret},
                )
                if r.status_code >= 400:
                    log.warning("revalidate tag=%s failed status=%s body=%s", tag, r.status_code, r.text[:200])
            except httpx.HTTPError as e:
                log.warning("revalidate tag=%s raised: %s", tag, e)
