from __future__ import annotations
from typing import Optional
from app.schemas.common import BaseDTO


class SearchHit(BaseDTO):
    kind: str  # "post" | "project" | "lab"
    document_id: str
    title: str
    slug: str
    summary: Optional[str] = None
    locale: Optional[str] = None
    score: float = 0.0


class SearchResponse(BaseDTO):
    query: str
    locale: str
    hits: list[SearchHit] = []
