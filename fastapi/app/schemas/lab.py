from __future__ import annotations
from datetime import date
from typing import Any, Optional
from app.schemas.common import BaseDTO
from app.schemas.tag import Tag, to_tag


class Lab(BaseDTO):
    document_id: str
    title: str
    slug: str
    date: date
    body: list = []
    external_link: Optional[str] = None
    language: str  # "pt" | "en" — feeds the badge in both locale listings
    tags: list[Tag] = []


def to_lab(raw: dict[str, Any]) -> Lab:
    return Lab(
        document_id=raw.get("documentId", ""),
        title=raw.get("title", ""),
        slug=raw.get("slug", ""),
        date=raw.get("date"),
        body=raw.get("body") or [],
        external_link=raw.get("external_link"),
        language=raw.get("language", "pt"),
        tags=[to_tag(t) for t in (raw.get("tags") or [])],
    )
