"""Slug equivalence between locales. Powers the LocaleSwitcher on the frontend:
given the URL you're on, look up the slug in the other locale so you can build
the equivalent URL — or know it doesn't exist and disable the switch.
"""

from __future__ import annotations
from fastapi import APIRouter, HTTPException, Query
from app.services.strapi_client import fetch
from app.schemas.common import BaseDTO
from app.config import settings

router = APIRouter(prefix="/translations", tags=["translations"])

SUPPORTED_TYPES = {"post": "posts", "project": "projects"}


class TranslationEntry(BaseDTO):
    locale: str
    slug: str


class TranslationLookup(BaseDTO):
    type: str
    source_locale: str
    source_slug: str
    translations: list[TranslationEntry]


@router.get("/{type}/{slug}", response_model=TranslationLookup)
async def translations(
    type: str,
    slug: str,
    locale: str = Query(default=settings.default_locale, description="Locale of the given slug"),
):
    if type not in SUPPORTED_TYPES:
        raise HTTPException(status_code=400, detail=f"unsupported type: {type}")
    endpoint = SUPPORTED_TYPES[type]

    raw = await fetch(
        endpoint,
        locale=locale,
        filters={"filters[slug][$eq]": slug},
        populate={"localizations": {"fields": ["locale", "slug"]}},
        fields=["slug", "locale"],
        pagination={"page": 1, "pageSize": 1},
    )
    items = raw.get("data") or []
    if not items:
        raise HTTPException(status_code=404, detail=f"{type} not found in {locale}")
    entry = items[0]
    translations: list[TranslationEntry] = [
        TranslationEntry(locale=entry.get("locale", locale), slug=entry.get("slug", slug))
    ]
    for loc in (entry.get("localizations") or []):
        if loc.get("locale") and loc.get("slug"):
            translations.append(TranslationEntry(locale=loc["locale"], slug=loc["slug"]))

    return TranslationLookup(
        type=type,
        source_locale=locale,
        source_slug=slug,
        translations=translations,
    )
