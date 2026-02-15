from fastapi import APIRouter
from app.services.strapi_client import fetch

router = APIRouter()


@router.get("/certifications")
async def get_certifications():
    params = {
        "populate": "badge_image",
        "sort": "issue_date:desc",
    }
    data = await fetch("certifications", params)
    return data
