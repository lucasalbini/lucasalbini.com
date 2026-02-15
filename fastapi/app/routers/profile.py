from fastapi import APIRouter, Query
from app.services.strapi_client import fetch

router = APIRouter()


@router.get("/profile")
async def get_profile(locale: str = Query("pt-BR")):
    params = {
        "locale": locale,
        "populate": "photo,background,resume,social_links,soft_skills",
    }
    data = await fetch("profile", params)
    return data
