from __future__ import annotations

from typing import Any

from app.schemas.common import BaseDTO, Media, normalize_media
from app.schemas.post import PostSummary


class Collection(BaseDTO):
    document_id: str
    title: str
    slug: str
    description: str | None = None
    cover: Media | None = None


class CollectionDetail(Collection):
    posts: list[PostSummary] = []


def to_collection(raw: dict[str, Any]) -> Collection:
    return Collection(
        document_id=raw.get("documentId", ""),
        title=raw.get("title", ""),
        slug=raw.get("slug", ""),
        description=raw.get("description"),
        cover=normalize_media(raw.get("cover")),
    )
