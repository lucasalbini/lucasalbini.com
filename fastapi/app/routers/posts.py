from __future__ import annotations
from fastapi import APIRouter, HTTPException, Query
from app.services.strapi_client import fetch
from app.schemas.common import Paginated, Pagination
from app.schemas.post import Post, to_post
from app.config import settings

router = APIRouter(prefix="/posts", tags=["posts"])

POPULATE = {
    "cover": True,
    "tags": True,
    "localizations": {"fields": ["locale", "slug"]},
}


@router.get("", response_model=Paginated[Post])
async def list_posts(
    locale: str = Query(default=settings.default_locale),
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=10, ge=1, le=100, alias="pageSize"),
    featured: bool | None = Query(default=None),
    tag: str | None = Query(default=None),
):
    filters: dict[str, str] = {}
    if featured is not None:
        filters["filters[featured][$eq]"] = str(featured).lower()
    if tag:
        filters["filters[tags][slug][$eq]"] = tag

    sort = ["featured:desc", "featured_order:asc", "publishedAt:desc"] if featured else ["publishedAt:desc"]

    raw = await fetch(
        "posts",
        locale=locale,
        populate=POPULATE,
        filters=filters,
        sort=sort,
        pagination={"page": page, "pageSize": page_size},
    )
    return Paginated[Post](
        data=[to_post(p) for p in (raw.get("data") or [])],
        pagination=Pagination.model_validate(raw.get("meta", {}).get("pagination", {})),
    )


@router.get("/{slug}", response_model=Post)
async def get_post_by_slug(slug: str, locale: str = Query(default=settings.default_locale)):
    raw = await fetch(
        "posts",
        locale=locale,
        populate=POPULATE,
        filters={"filters[slug][$eq]": slug},
        pagination={"page": 1, "pageSize": 1},
    )
    items = raw.get("data") or []
    if not items:
        raise HTTPException(status_code=404, detail="post not found")
    return to_post(items[0])
