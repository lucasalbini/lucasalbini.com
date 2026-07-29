from __future__ import annotations
from datetime import date
from typing import Any, Optional
from app.schemas.common import BaseDTO, Media, normalize_media


class Certification(BaseDTO):
    document_id: str
    name: str
    issuer: Optional[str] = None
    issue_date: Optional[date] = None
    credential_url: Optional[str] = None
    badge_image: Optional[Media] = None


def to_certification(raw: dict[str, Any]) -> Certification:
    return Certification(
        document_id=raw.get("documentId", ""),
        name=raw.get("name", ""),
        issuer=raw.get("issuer"),
        issue_date=raw.get("issue_date"),
        credential_url=raw.get("credential_url"),
        badge_image=normalize_media(raw.get("badge_image")),
    )
