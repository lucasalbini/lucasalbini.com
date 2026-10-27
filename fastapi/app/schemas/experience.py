from __future__ import annotations

from datetime import date
from typing import Any

from app.schemas.common import BaseDTO, Media, normalize_media


class Responsibility(BaseDTO):
    description: str


class Position(BaseDTO):
    designation: str
    start_date: date
    end_date: date | None = None
    is_current: bool = False
    responsibilities: list[Responsibility] = []


class Experience(BaseDTO):
    document_id: str
    company_name: str
    company_url: str | None = None
    company_location: str | None = None
    company_logo: Media | None = None
    order: int | None = None
    positions: list[Position] = []
    locale: str


def to_experience(raw: dict[str, Any]) -> Experience:
    return Experience(
        document_id=raw.get("documentId", ""),
        company_name=raw.get("company_name", ""),
        company_url=raw.get("company_url"),
        company_location=raw.get("company_location"),
        company_logo=normalize_media(raw.get("company_logo")),
        order=raw.get("order"),
        positions=[Position.model_validate(p) for p in (raw.get("positions") or [])],
        locale=raw.get("locale", ""),
    )
