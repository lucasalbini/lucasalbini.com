from fastapi import APIRouter, Query
from app.services.strapi_client import fetch

router = APIRouter()


@router.get("/skills")
async def get_skills(locale: str = Query("pt-BR"), category: str | None = None):
    params: dict = {
        "locale": locale,
        "populate": "icon",
        "sort": "name:asc",
    }
    if category:
        params["filters[category][$eq]"] = category
    data = await fetch("skills", params)
    return data
