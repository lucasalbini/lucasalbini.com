from __future__ import annotations
from fastapi import APIRouter, HTTPException, Query
from app.services.strapi_client import fetch
from app.schemas.profile import Profile, to_profile
from app.config import settings

router = APIRouter(prefix="/profile", tags=["profile"])

POPULATE = {
    "avatar": True,
    "cv_pdf": True,
    "social_links": True,
    "localizations": {"fields": ["locale"]},
}


@router.get("", response_model=Profile)
async def get_profile(locale: str = Query(default=settings.default_locale)):
    raw = await fetch("profile", locale=locale, populate=POPULATE, allow_missing=True)
    data = raw.get("data")
    if not data:
        raise HTTPException(status_code=404, detail="profile not yet configured in Strapi admin")
    return to_profile(data)
