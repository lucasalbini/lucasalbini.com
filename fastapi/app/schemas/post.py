from __future__ import annotations

import datetime as dt
from typing import Any, Literal

from app.schemas.blocks import Block, to_blocks, word_count
from app.schemas.common import BaseDTO, Media, normalize_media
from app.schemas.tag import Tag, to_tag
from app.services.visibility import Visibility

Category = Literal["travel", "project", "idea", "life", "work"]

WORDS_PER_MINUTE = 200


class CollectionRef(BaseDTO):
    title: str
    slug: str


class PostSummary(BaseDTO):
    """What cards and lists need. No body: list queries don't populate the dynamic zone."""

    document_id: str
    title: str
    slug: str
    summary: str
    cover: Media | None = None
    category: Category
    visibility: Visibility = "public"
    # `dt.date`, not `date`: the field name would shadow the type inside the class body.
    date: dt.date | None = None
    tags: list[Tag] = []
    collection: CollectionRef | None = None
    featured: bool = False
    featured_order: int = 0
    published_at: dt.datetime | None = None


class Post(PostSummary):
    body: list[Block] = []
    instagram_url: str | None = None
    youtube_url: str | None = None
    reading_time_minutes: int | None = None


def _collection_ref(raw: Any) -> CollectionRef | None:
    if not isinstance(raw, dict) or not raw.get("slug"):
        return None
    return CollectionRef(title=raw.get("title", ""), slug=raw["slug"])


def _summary_fields(raw: dict[str, Any]) -> dict[str, Any]:
    return {
        "document_id": raw.get("documentId", ""),
        "title": raw.get("title", ""),
        "slug": raw.get("slug", ""),
        "summary": raw.get("summary", ""),
        "cover": normalize_media(raw.get("cover")),
        "category": raw.get("category") or "life",
        "visibility": raw.get("visibility") or "public",
        "date": raw.get("date"),
        "tags": [to_tag(t) for t in (raw.get("tags") or [])],
        "collection": _collection_ref(raw.get("collection")),
        "featured": bool(raw.get("featured", False)),
        "featured_order": int(raw.get("featured_order") or 0),
        "published_at": raw.get("publishedAt"),
    }


def to_post_summary(raw: dict[str, Any]) -> PostSummary:
    return PostSummary(**_summary_fields(raw))


def to_post(raw: dict[str, Any]) -> Post:
    body = to_blocks(raw.get("body"))
    words = word_count(body)
    return Post(
        **_summary_fields(raw),
        body=body,
        instagram_url=raw.get("instagram_url") or None,
        youtube_url=raw.get("youtube_url") or None,
        reading_time_minutes=max(1, round(words / WORDS_PER_MINUTE)) if words else None,
    )
