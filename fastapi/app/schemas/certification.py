from __future__ import annotations

from datetime import date
from typing import Any

from app.schemas.common import BaseDTO, Media, normalize_media


class Certification(BaseDTO):
    document_id: str
    name: str
    issuer: str | None = None
    issue_date: date | None = None
    credential_url: str | None = None
    badge_image: Media | None = None


def to_certification(raw: dict[str, Any]) -> Certification:
    return Certification(
        document_id=raw.get("documentId", ""),
        name=raw.get("name", ""),
        issuer=raw.get("issuer"),
        issue_date=raw.get("issue_date"),
        credential_url=raw.get("credential_url"),
        badge_image=normalize_media(raw.get("badge_image")),
    )
