from __future__ import annotations

from fastapi import APIRouter, Query

from app.config import settings
from app.schemas.publication import Publication, to_publication
from app.services.strapi_client import fetch

router = APIRouter(prefix="/publications", tags=["publications"])


@router.get("", response_model=list[Publication])
async def list_publications(locale: str = Query(default=settings.default_locale)):
    raw = await fetch(
        "publications",
        locale=locale,
        populate={"localizations": {"fields": ["locale"]}},
        sort=["date:desc"],
        pagination={"page": 1, "pageSize": 100},
    )
    return [to_publication(p) for p in (raw.get("data") or [])]
