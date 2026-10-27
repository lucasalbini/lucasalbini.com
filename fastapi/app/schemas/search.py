from __future__ import annotations

from app.schemas.common import BaseDTO


class SearchHit(BaseDTO):
    kind: str  # "post" | "project" | "lab"
    document_id: str
    title: str
    slug: str
    summary: str | None = None
    locale: str | None = None
    score: float = 0.0


class SearchResponse(BaseDTO):
    query: str
    locale: str
    hits: list[SearchHit] = []
