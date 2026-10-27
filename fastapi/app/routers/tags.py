from __future__ import annotations

from fastapi import APIRouter, HTTPException

from app.routers.posts import SUMMARY_POPULATE
from app.schemas.common import BaseDTO
from app.schemas.post import PostSummary, to_post_summary
from app.schemas.tag import Tag, to_tag
from app.services.strapi_client import fetch
from app.services.visibility import LISTED, visibility_filter

router = APIRouter(prefix="/tags", tags=["tags"])


class TagAggregation(BaseDTO):
    tag: Tag
    posts: list[PostSummary] = []


@router.get("", response_model=list[Tag])
async def list_tags():
    raw = await fetch(
        "tags",
        sort=["label:asc"],
        pagination={"page": 1, "pageSize": 200},
    )
    return [to_tag(t) for t in (raw.get("data") or [])]


@router.get("/{slug}", response_model=TagAggregation)
async def tag_aggregate(slug: str):
    """Every public post with this tag. Powers /tags/[tag] on the frontend."""
    tags_raw = await fetch(
        "tags",
        filters={"filters[slug][$eq]": slug},
        pagination={"page": 1, "pageSize": 1},
    )
    tag_items = tags_raw.get("data") or []
    if not tag_items:
        raise HTTPException(status_code=404, detail="tag not found")

    posts_raw = await fetch(
        "posts",
        populate=SUMMARY_POPULATE,
        filters={"filters[tags][slug][$eq]": slug, **visibility_filter(LISTED)},
        sort=["date:desc"],
        pagination={"page": 1, "pageSize": 100},
    )
    return TagAggregation(
        tag=to_tag(tag_items[0]),
        posts=[to_post_summary(p) for p in (posts_raw.get("data") or [])],
    )
