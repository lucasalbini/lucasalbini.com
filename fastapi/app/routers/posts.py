from __future__ import annotations

from typing import Annotated, Any

from fastapi import APIRouter, HTTPException, Query

from app.schemas.blocks import body_populate
from app.schemas.common import Paginated, Pagination
from app.schemas.post import Category, Post, PostSummary, to_post, to_post_summary
from app.services.strapi_client import fetch
from app.services.visibility import LISTED, REACHABLE, visibility_filter

router = APIRouter(prefix="/posts", tags=["posts"])

SUMMARY_POPULATE: dict[str, Any] = {
    "cover": True,
    "tags": True,
    "collection": {"fields": ["title", "slug"]},
}

DETAIL_POPULATE: dict[str, Any] = {**SUMMARY_POPULATE, "body": body_populate()}


@router.get("", response_model=Paginated[PostSummary])
async def list_posts(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=10, ge=1, le=100, alias="pageSize"),
    category: Annotated[Category | None, Query()] = None,
    tag: str | None = Query(default=None),
    collection: str | None = Query(default=None),
    featured: bool | None = Query(default=None),
):
    filters = visibility_filter(LISTED)
    if category:
        filters["filters[category][$eq]"] = category
    if tag:
        filters["filters[tags][slug][$eq]"] = tag
    if collection:
        filters["filters[collection][slug][$eq]"] = collection
    if featured is not None:
        filters["filters[featured][$eq]"] = str(featured).lower()

    sort = ["date:desc", "publishedAt:desc"]
    if featured:
        sort = ["featured_order:asc", *sort]

    raw = await fetch(
        "posts",
        populate=SUMMARY_POPULATE,
        filters=filters,
        sort=sort,
        pagination={"page": page, "pageSize": page_size},
    )
    return Paginated[PostSummary](
        data=[to_post_summary(p) for p in (raw.get("data") or [])],
        pagination=Pagination.model_validate(raw.get("meta", {}).get("pagination", {})),
    )


@router.get("/{slug}", response_model=Post)
async def get_post_by_slug(slug: str):
    raw = await fetch(
        "posts",
        populate=DETAIL_POPULATE,
        filters={"filters[slug][$eq]": slug, **visibility_filter(REACHABLE)},
        pagination={"page": 1, "pageSize": 1},
    )
    items = raw.get("data") or []
    if not items:
        raise HTTPException(status_code=404, detail="post not found")
    return to_post(items[0])
