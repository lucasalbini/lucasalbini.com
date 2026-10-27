from __future__ import annotations

from fastapi import APIRouter, HTTPException, Query

from app.config import settings
from app.schemas.common import Paginated, Pagination
from app.schemas.project import Project, to_project
from app.services.strapi_client import fetch

router = APIRouter(prefix="/projects", tags=["projects"])

POPULATE = {
    "cover": True,
    "tags": True,
    "stack": True,
    "localizations": {"fields": ["locale", "slug"]},
}


@router.get("", response_model=Paginated[Project])
async def list_projects(
    locale: str = Query(default=settings.default_locale),
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=24, ge=1, le=100, alias="pageSize"),
    featured: bool | None = Query(default=None),
    kind: str | None = Query(default=None),
    status: str | None = Query(default=None),
    tag: str | None = Query(default=None),
):
    filters: dict[str, str] = {}
    if featured is not None:
        filters["filters[featured][$eq]"] = str(featured).lower()
    if kind:
        filters["filters[kind][$eq]"] = kind
    if status:
        filters["filters[status][$eq]"] = status
    if tag:
        filters["filters[tags][slug][$eq]"] = tag

    sort = ["featured:desc", "featured_order:asc", "year:desc"] if featured else ["year:desc", "updatedAt:desc"]

    raw = await fetch(
        "projects",
        locale=locale,
        populate=POPULATE,
        filters=filters,
        sort=sort,
        pagination={"page": page, "pageSize": page_size},
    )
    return Paginated[Project](
        data=[to_project(p) for p in (raw.get("data") or [])],
        pagination=Pagination.model_validate(raw.get("meta", {}).get("pagination", {})),
    )


@router.get("/{slug}", response_model=Project)
async def get_project_by_slug(slug: str, locale: str = Query(default=settings.default_locale)):
    raw = await fetch(
        "projects",
        locale=locale,
        populate=POPULATE,
        filters={"filters[slug][$eq]": slug},
        pagination={"page": 1, "pageSize": 1},
    )
    items = raw.get("data") or []
    if not items:
        raise HTTPException(status_code=404, detail="project not found")
    return to_project(items[0])
