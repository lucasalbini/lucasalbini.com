from fastapi import APIRouter, Query
from app.services.strapi_client import fetch

router = APIRouter()


@router.get("/posts")
async def get_posts(
    locale: str = Query("pt-BR"),
    page: int = Query(1),
    pageSize: int = Query(10),
    featured: bool | None = None,
):
    params: dict = {
        "locale": locale,
        "populate": "featured_image",
        "sort": "createdAt:desc",
        "pagination[page]": page,
        "pagination[pageSize]": pageSize,
    }
    if featured is not None:
        params["filters[featured][$eq]"] = str(featured).lower()
    data = await fetch("posts", params)
    return data


@router.get("/posts/{slug}")
async def get_post_by_slug(slug: str, locale: str = Query("pt-BR")):
    params = {
        "locale": locale,
        "filters[slug][$eq]": slug,
        "populate": "featured_image",
    }
    data = await fetch("posts", params)
    return data
