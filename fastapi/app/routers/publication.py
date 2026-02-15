from fastapi import APIRouter, Query
from app.services.strapi_client import fetch

router = APIRouter()


@router.get("/publications")
async def get_publications(locale: str = Query("pt")):
    params = {
        "locale": locale,
        "sort": "date:desc",
    }
    data = await fetch("publications", params)
    return data
