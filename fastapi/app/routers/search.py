"""Full-text search across posts, projects and lab notes.

Current implementation uses Strapi's `$containsi` filter over title/summary.
When volume grows, migrate to Postgres `tsvector` + trigram — the endpoint
contract stays the same.
"""

from __future__ import annotations
import asyncio
from fastapi import APIRouter, Query
from app.services.strapi_client import fetch
from app.schemas.search import SearchHit, SearchResponse
from app.config import settings

router = APIRouter(prefix="/search", tags=["search"])


async def _search_posts(q: str, locale: str) -> list[SearchHit]:
    raw = await fetch(
        "posts",
        locale=locale,
        filters={
            "filters[$or][0][title][$containsi]": q,
            "filters[$or][1][summary][$containsi]": q,
        },
        fields=["title", "slug", "summary", "locale"],
        pagination={"page": 1, "pageSize": 10},
    )
    return [
        SearchHit(
            kind="post",
            document_id=p.get("documentId", ""),
            title=p.get("title", ""),
            slug=p.get("slug", ""),
            summary=p.get("summary"),
            locale=p.get("locale"),
        )
        for p in (raw.get("data") or [])
    ]


async def _search_projects(q: str, locale: str) -> list[SearchHit]:
    raw = await fetch(
        "projects",
        locale=locale,
        filters={
            "filters[$or][0][title][$containsi]": q,
            "filters[$or][1][summary][$containsi]": q,
        },
        fields=["title", "slug", "summary", "locale"],
        pagination={"page": 1, "pageSize": 10},
    )
    return [
        SearchHit(
            kind="project",
            document_id=p.get("documentId", ""),
            title=p.get("title", ""),
            slug=p.get("slug", ""),
            summary=p.get("summary"),
            locale=p.get("locale"),
        )
        for p in (raw.get("data") or [])
    ]


async def _search_lab(q: str) -> list[SearchHit]:
    raw = await fetch(
        "labs",
        filters={"filters[title][$containsi]": q},
        fields=["title", "slug", "language"],
        pagination={"page": 1, "pageSize": 10},
    )
    return [
        SearchHit(
            kind="lab",
            document_id=n.get("documentId", ""),
            title=n.get("title", ""),
            slug=n.get("slug", ""),
            summary=None,
            locale=n.get("language"),
        )
        for n in (raw.get("data") or [])
    ]


@router.get("", response_model=SearchResponse)
async def search(
    q: str = Query(min_length=2, max_length=100),
    locale: str = Query(default=settings.default_locale),
):
    posts, projects, lab = await asyncio.gather(
        _search_posts(q, locale), _search_projects(q, locale), _search_lab(q)
    )
    return SearchResponse(query=q, locale=locale, hits=posts + projects + lab)
