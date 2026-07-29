from __future__ import annotations
from datetime import date
from typing import Any, Optional
from app.schemas.common import BaseDTO, extract_available_locales


class Publication(BaseDTO):
    document_id: str
    title: str
    journal: Optional[str] = None
    authors: Optional[str] = None
    date: Optional[date] = None
    url: Optional[str] = None
    doi: Optional[str] = None
    abstract: Optional[str] = None
    locale: str
    available_locales: list[str] = []


def to_publication(raw: dict[str, Any]) -> Publication:
    return Publication(
        document_id=raw.get("documentId", ""),
        title=raw.get("title", ""),
        journal=raw.get("journal"),
        authors=raw.get("authors"),
        date=raw.get("date"),
        url=raw.get("url"),
        doi=raw.get("doi"),
        abstract=raw.get("abstract"),
        locale=raw.get("locale", ""),
        available_locales=extract_available_locales(raw, raw.get("locale", "")),
    )
