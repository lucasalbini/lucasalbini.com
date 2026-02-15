from fastapi import APIRouter, Query
from app.services.strapi_client import fetch

router = APIRouter()


@router.get("/projects")
async def get_projects(locale: str = Query("pt-BR"), category: str | None = None):
    params: dict = {
        "locale": locale,
        "populate": "logo",
        "sort": "createdAt:desc",
    }
    if category:
        params["filters[category][$eq]"] = category
    data = await fetch("projects", params)
    return data
