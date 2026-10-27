import httpx
import respx

from app.config import settings
from tests.conftest import strapi_list, strapi_post

STRAPI = f"{settings.strapi_base_url}/api"
VIAGENS = {"documentId": "c1", "title": "Viagens", "slug": "viagens", "description": "Lugares onde estive."}


@respx.mock
async def test_collection_lists_its_public_posts_oldest_first(api: httpx.AsyncClient) -> None:
    respx.get(f"{STRAPI}/collections").mock(return_value=httpx.Response(200, json=strapi_list(VIAGENS)))
    posts = respx.get(f"{STRAPI}/posts").mock(return_value=httpx.Response(200, json=strapi_list(strapi_post())))

    response = await api.get("/collections/viagens")

    params = posts.calls.last.request.url.params
    assert params["filters[collection][slug][$eq]"] == "viagens"
    assert params.get_list("filters[visibility][$in][0]") == ["public"]
    assert params["sort[0]"] == "date:asc"
    assert [p["slug"] for p in response.json()["posts"]] == ["cinco-dias-em-belem"]


@respx.mock
async def test_unknown_collection_is_not_found(api: httpx.AsyncClient) -> None:
    respx.get(f"{STRAPI}/collections").mock(return_value=httpx.Response(200, json=strapi_list()))

    response = await api.get("/collections/receitas")

    assert response.status_code == 404


@respx.mock
async def test_collections_index_lists_title_and_slug(api: httpx.AsyncClient) -> None:
    respx.get(f"{STRAPI}/collections").mock(return_value=httpx.Response(200, json=strapi_list(VIAGENS)))

    response = await api.get("/collections")

    assert [(c["title"], c["slug"]) for c in response.json()] == [("Viagens", "viagens")]
