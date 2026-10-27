from __future__ import annotations

from fastapi import APIRouter, HTTPException

from app.routers.posts import SUMMARY_POPULATE
from app.schemas.collection import Collection, CollectionDetail, to_collection
from app.schemas.post import to_post_summary
from app.services.strapi_client import fetch
from app.services.visibility import LISTED, visibility_filter

router = APIRouter(prefix="/collections", tags=["collections"])

# A collection is read like a book: oldest chapter first.
CHAPTER_ORDER = ["date:asc", "publishedAt:asc"]


@router.get("", response_model=list[Collection])
async def list_collections():
    raw = await fetch(
        "collections",
        populate={"cover": True},
        sort=["title:asc"],
        pagination={"page": 1, "pageSize": 100},
    )
    return [to_collection(c) for c in (raw.get("data") or [])]


@router.get("/{slug}", response_model=CollectionDetail)
async def get_collection(slug: str):
    raw = await fetch(
        "collections",
        populate={"cover": True},
        filters={"filters[slug][$eq]": slug},
        pagination={"page": 1, "pageSize": 1},
    )
    items = raw.get("data") or []
    if not items:
        raise HTTPException(status_code=404, detail="collection not found")

    posts_raw = await fetch(
        "posts",
        populate=SUMMARY_POPULATE,
        filters={"filters[collection][slug][$eq]": slug, **visibility_filter(LISTED)},
        sort=CHAPTER_ORDER,
        pagination={"page": 1, "pageSize": 100},
    )
    return CollectionDetail(
        **to_collection(items[0]).model_dump(),
        posts=[to_post_summary(p) for p in (posts_raw.get("data") or [])],
    )
