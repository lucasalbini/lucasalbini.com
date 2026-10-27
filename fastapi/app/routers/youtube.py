from __future__ import annotations

import logging

import httpx
from fastapi import APIRouter, Query

from app.schemas.youtube import YoutubeVideo
from app.services import youtube
from app.services.strapi_client import fetch

router = APIRouter(prefix="/youtube", tags=["youtube"])
log = logging.getLogger(__name__)


async def _channel_id() -> str | None:
    """`profile.youtube_channel_id`, or None when the profile or the field is missing.

    profile is not localized, so no locale is sent.
    """
    try:
        raw = await fetch("profile", fields=["youtube_channel_id"], allow_missing=True)
    except httpx.HTTPError as exc:
        log.warning("youtube: could not read profile from Strapi: %r", exc)
        return None
    data = raw.get("data")
    if not data:
        log.warning("youtube: profile not found in Strapi")
        return None
    return data.get("youtube_channel_id") or None


@router.get("/latest", response_model=list[YoutubeVideo])
async def latest(limit: int = Query(default=6, ge=1, le=15)):
    """Latest videos of the channel set in the profile. `[]` (never an error) when there
    is no channel or YouTube fails, so the home can hide the section."""
    channel_id = await _channel_id()
    if not channel_id:
        return []
    videos = await youtube.fetch_latest(channel_id)
    return videos[:limit]
