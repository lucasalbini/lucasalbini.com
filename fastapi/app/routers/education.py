from fastapi import APIRouter, Query
from app.services.strapi_client import fetch

router = APIRouter()


@router.get("/education")
async def get_education(locale: str = Query("pt-BR")):
    params = {
        "locale": locale,
        "populate": "logo",
        "sort": "start_date:desc",
    }
    data = await fetch("educations", params)
    return data
