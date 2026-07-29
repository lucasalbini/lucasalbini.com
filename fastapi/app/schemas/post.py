from __future__ import annotations
from datetime import datetime
from typing import Any, Optional
from app.schemas.common import BaseDTO, Media, extract_available_locales, normalize_media
from app.schemas.tag import Tag, to_tag


class Post(BaseDTO):
    document_id: str
    title: str
    slug: str
    summary: str
    body: list = []
    cover: Optional[Media] = None
    tags: list[Tag] = []
    featured: bool = False
    featured_order: int = 0
    reading_time_minutes: Optional[int] = None
    published_at: Optional[datetime] = None
    locale: str
    available_locales: list[str] = []


def _estimate_reading_time(body: list) -> Optional[int]:
    """Rough estimate from block editor content. Not stored server-side."""
    if not body:
        return None
    words = 0
    for block in body:
        for child in block.get("children", []) or []:
            text = child.get("text", "")
            if text:
                words += len(text.split())
    if not words:
        return None
    return max(1, round(words / 200))


def to_post(raw: dict[str, Any]) -> Post:
    body = raw.get("body") or []
    return Post(
        document_id=raw.get("documentId", ""),
        title=raw.get("title", ""),
        slug=raw.get("slug", ""),
        summary=raw.get("summary", ""),
        body=body,
        cover=normalize_media(raw.get("cover")),
        tags=[to_tag(t) for t in (raw.get("tags") or [])],
        featured=bool(raw.get("featured", False)),
        featured_order=int(raw.get("featured_order") or 0),
        reading_time_minutes=_estimate_reading_time(body),
        published_at=raw.get("publishedAt"),
        locale=raw.get("locale", ""),
        available_locales=extract_available_locales(raw, raw.get("locale", "")),
    )
