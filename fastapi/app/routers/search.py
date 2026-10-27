"""Full-text search over public posts.

Uses Strapi's `$containsi` over title/summary. When volume grows, migrate to Postgres
`tsvector` + trigram — the endpoint contract stays the same.
"""

from __future__ import annotations

from fastapi import APIRouter, Query

from app.schemas.search import SearchHit, SearchResponse
from app.services.strapi_client import fetch
from app.services.visibility import LISTED, visibility_filter

router = APIRouter(prefix="/search", tags=["search"])


@router.get("", response_model=SearchResponse)
async def search(q: str = Query(min_length=2, max_length=100)):
    # Wrapped in $and so the visibility filter can't be OR-ed away by the text match.
    filters = {
        "filters[$and][0][$or][0][title][$containsi]": q,
        "filters[$and][0][$or][1][summary][$containsi]": q,
        **visibility_filter(LISTED, path="filters[$and][1][visibility]"),
    }
    raw = await fetch(
        "posts",
        filters=filters,
        fields=["title", "slug", "summary", "category"],
        pagination={"page": 1, "pageSize": 20},
    )
    hits = [
        SearchHit(
            document_id=p.get("documentId", ""),
            title=p.get("title", ""),
            slug=p.get("slug", ""),
            summary=p.get("summary"),
            category=p.get("category"),
        )
        for p in (raw.get("data") or [])
    ]
    return SearchResponse(query=q, hits=hits)
