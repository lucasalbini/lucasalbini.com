from __future__ import annotations

from app.schemas.common import BaseDTO


class Tag(BaseDTO):
    document_id: str
    label: str
    slug: str


def to_tag(raw: dict) -> Tag:
    return Tag(
        document_id=raw.get("documentId", ""),
        label=raw.get("label", ""),
        slug=raw.get("slug", ""),
    )
