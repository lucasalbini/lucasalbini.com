from __future__ import annotations
from typing import Any, Optional
from app.schemas.common import BaseDTO, Media, normalize_media


class Skill(BaseDTO):
    document_id: str
    name: str
    icon_name: Optional[str] = None
    summary: Optional[str] = None
    category: str
    url: Optional[str] = None
    icon: Optional[Media] = None
    locale: str


def to_skill(raw: dict[str, Any]) -> Skill:
    return Skill(
        document_id=raw.get("documentId", ""),
        name=raw.get("name", ""),
        icon_name=raw.get("icon_name"),
        summary=raw.get("summary"),
        category=raw.get("category", ""),
        url=raw.get("url"),
        icon=normalize_media(raw.get("icon")),
        locale=raw.get("locale", ""),
    )
