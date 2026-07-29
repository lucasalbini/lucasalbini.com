from __future__ import annotations
from fastapi import APIRouter, HTTPException, Query
from app.services.strapi_client import fetch
from app.schemas.tag import Tag, to_tag
from app.schemas.post import Post, to_post
from app.schemas.project import Project, to_project
from app.schemas.lab import Lab, to_lab
from app.schemas.common import BaseDTO
from app.config import settings

router = APIRouter(prefix="/tags", tags=["tags"])


class TagAggregation(BaseDTO):
    tag: Tag
    posts: list[Post] = []
    projects: list[Project] = []
    lab: list[Lab] = []


@router.get("", response_model=list[Tag])
async def list_tags(locale: str = Query(default=settings.default_locale)):
    raw = await fetch(
        "tags",
        locale=locale,
        sort=["label:asc"],
        pagination={"page": 1, "pageSize": 200},
    )
    return [to_tag(t) for t in (raw.get("data") or [])]


@router.get("/{slug}", response_model=TagAggregation)
async def tag_aggregate(slug: str, locale: str = Query(default=settings.default_locale)):
    """Aggregate everything with this tag across posts, projects and lab notes.
    Powers /tags/[tag] on the frontend.
    """
    tags_raw = await fetch(
        "tags",
        locale=locale,
        filters={"filters[slug][$eq]": slug},
        pagination={"page": 1, "pageSize": 1},
    )
    tag_items = tags_raw.get("data") or []
    if not tag_items:
        raise HTTPException(status_code=404, detail="tag not found")
    tag = to_tag(tag_items[0])

    posts_raw = await fetch(
        "posts",
        locale=locale,
        populate={"cover": True, "tags": True, "localizations": {"fields": ["locale", "slug"]}},
        filters={"filters[tags][slug][$eq]": slug},
        sort=["publishedAt:desc"],
        pagination={"page": 1, "pageSize": 50},
    )
    projects_raw = await fetch(
        "projects",
        locale=locale,
        populate={"cover": True, "tags": True, "stack": True, "localizations": {"fields": ["locale", "slug"]}},
        filters={"filters[tags][slug][$eq]": slug},
        sort=["year:desc"],
        pagination={"page": 1, "pageSize": 50},
    )
    lab_raw = await fetch(
        "labs",
        populate={"tags": True},
        filters={"filters[tags][slug][$eq]": slug},
        sort=["date:desc"],
        pagination={"page": 1, "pageSize": 50},
    )
    return TagAggregation(
        tag=tag,
        posts=[to_post(p) for p in (posts_raw.get("data") or [])],
        projects=[to_project(p) for p in (projects_raw.get("data") or [])],
        lab=[to_lab(n) for n in (lab_raw.get("data") or [])],
    )
