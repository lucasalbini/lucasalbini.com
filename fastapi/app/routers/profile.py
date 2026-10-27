from __future__ import annotations

from fastapi import APIRouter, HTTPException

from app.schemas.profile import Profile, to_profile
from app.services.strapi_client import fetch

router = APIRouter(prefix="/profile", tags=["profile"])

POPULATE = {
    "avatar": True,
    "cv_pdf": True,
    "social_links": True,
}


@router.get("", response_model=Profile)
async def get_profile():
    raw = await fetch("profile", populate=POPULATE, allow_missing=True)
    data = raw.get("data")
    if not data:
        raise HTTPException(status_code=404, detail="profile not yet configured in Strapi admin")
    return to_profile(data)
