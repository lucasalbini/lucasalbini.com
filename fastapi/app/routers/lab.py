"""Lab notes: deliberately not localized. The response is language-agnostic;
the `language` field feeds the badge in each locale listing on the frontend.
"""

from __future__ import annotations
from fastapi import APIRouter, Query
from app.services.strapi_client import fetch
from app.schemas.common import Paginated, Pagination
from app.schemas.lab import Lab, to_lab

router = APIRouter(prefix="/lab", tags=["lab"])

POPULATE = {"tags": True}


@router.get("", response_model=Paginated[Lab])
async def list_lab(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=30, ge=1, le=100, alias="pageSize"),
    language: str | None = Query(default=None, description="Filter by original language pt|en"),
    tag: str | None = Query(default=None),
):
    filters: dict[str, str] = {}
    if language:
        filters["filters[language][$eq]"] = language
    if tag:
        filters["filters[tags][slug][$eq]"] = tag

    raw = await fetch(
        "labs",
        populate=POPULATE,
        filters=filters,
        sort=["date:desc"],
        pagination={"page": page, "pageSize": page_size},
    )
    return Paginated[Lab](
        data=[to_lab(n) for n in (raw.get("data") or [])],
        pagination=Pagination.model_validate(raw.get("meta", {}).get("pagination", {})),
    )
