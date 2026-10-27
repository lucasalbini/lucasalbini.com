from __future__ import annotations

from datetime import date
from typing import Any

from app.schemas.common import BaseDTO, Media, normalize_media


class Education(BaseDTO):
    document_id: str
    institution: str
    degree: str | None = None
    field_of_study: str | None = None
    start_date: date | None = None
    end_date: date | None = None
    description: str | None = None
    logo: Media | None = None
    locale: str


def to_education(raw: dict[str, Any]) -> Education:
    return Education(
        document_id=raw.get("documentId", ""),
        institution=raw.get("institution", ""),
        degree=raw.get("degree"),
        field_of_study=raw.get("field_of_study"),
        start_date=raw.get("start_date"),
        end_date=raw.get("end_date"),
        description=raw.get("description"),
        logo=normalize_media(raw.get("logo")),
        locale=raw.get("locale", ""),
    )
