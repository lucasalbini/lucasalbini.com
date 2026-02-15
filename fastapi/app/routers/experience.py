from fastapi import APIRouter, Query
from app.services.strapi_client import fetch

router = APIRouter()


@router.get("/experiences")
async def get_experiences(locale: str = Query("pt")):
    params = {
        "locale": locale,
        "populate": "company_logo,positions.responsibilities",
        "sort": "order:asc",
    }
    data = await fetch("experiences", params)
    return data
