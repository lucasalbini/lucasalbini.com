from __future__ import annotations

from app.schemas.common import BaseDTO


class SearchHit(BaseDTO):
    document_id: str
    title: str
    slug: str
    summary: str | None = None
    category: str | None = None


class SearchResponse(BaseDTO):
    query: str
    hits: list[SearchHit] = []
