import httpx
import respx

from app.config import settings
from tests.conftest import strapi_list, strapi_post

STRAPI = f"{settings.strapi_base_url}/api"


@respx.mock
async def test_search_cannot_match_its_way_past_visibility(api: httpx.AsyncClient) -> None:
    route = respx.get(f"{STRAPI}/posts").mock(return_value=httpx.Response(200, json=strapi_list(strapi_post())))

    response = await api.get("/search", params={"q": "belém"})

    params = route.calls.last.request.url.params
    assert params["filters[$and][0][$or][0][title][$containsi]"] == "belém"
    assert params["filters[$and][1][visibility][$in][0]"] == "public"
    assert [h["slug"] for h in response.json()["hits"]] == ["cinco-dias-em-belem"]


@respx.mock
async def test_tag_page_lists_only_public_posts(api: httpx.AsyncClient) -> None:
    respx.get(f"{STRAPI}/tags").mock(
        return_value=httpx.Response(
            200, json=strapi_list({"documentId": "t1", "label": "Amazônia", "slug": "amazonia"})
        )
    )
    posts = respx.get(f"{STRAPI}/posts").mock(return_value=httpx.Response(200, json=strapi_list(strapi_post())))

    response = await api.get("/tags/amazonia")

    assert posts.calls.last.request.url.params["filters[visibility][$in][0]"] == "public"
    assert response.json()["tag"]["label"] == "Amazônia"


@respx.mock
async def test_unknown_tag_is_not_found(api: httpx.AsyncClient) -> None:
    respx.get(f"{STRAPI}/tags").mock(return_value=httpx.Response(200, json=strapi_list()))

    assert (await api.get("/tags/nada")).status_code == 404
