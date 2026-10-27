import httpx
import respx

from app.config import settings
from tests.conftest import strapi_list, strapi_post

STRAPI_POSTS = f"{settings.strapi_base_url}/api/posts"


@respx.mock
async def test_list_asks_strapi_for_public_posts_only(api: httpx.AsyncClient) -> None:
    route = respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json=strapi_list(strapi_post())))

    await api.get("/posts")

    params = route.calls.last.request.url.params
    assert params.get_list("filters[visibility][$in][0]") == ["public"]
    assert "filters[visibility][$in][1]" not in params


@respx.mock
async def test_list_returns_cards_without_body(api: httpx.AsyncClient) -> None:
    respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json=strapi_list(strapi_post())))

    response = await api.get("/posts")

    (card,) = response.json()["data"]
    assert card["slug"] == "cinco-dias-em-belem"
    assert card["collection"] == {"title": "Viagens", "slug": "viagens"}
    assert "body" not in card


@respx.mock
async def test_list_sorts_by_date_of_the_experience(api: httpx.AsyncClient) -> None:
    route = respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json=strapi_list()))

    await api.get("/posts")

    assert route.calls.last.request.url.params["sort[0]"] == "date:desc"


@respx.mock
async def test_list_filters_by_category_tag_and_collection(api: httpx.AsyncClient) -> None:
    route = respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json=strapi_list()))

    await api.get("/posts", params={"category": "travel", "tag": "amazonia", "collection": "viagens"})

    params = route.calls.last.request.url.params
    assert params["filters[category][$eq]"] == "travel"
    assert params["filters[tags][slug][$eq]"] == "amazonia"
    assert params["filters[collection][slug][$eq]"] == "viagens"


@respx.mock
async def test_featured_list_follows_manual_order_first(api: httpx.AsyncClient) -> None:
    route = respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json=strapi_list()))

    await api.get("/posts", params={"featured": "true"})

    assert route.calls.last.request.url.params["sort[0]"] == "featured_order:asc"


async def test_unknown_category_is_rejected(api: httpx.AsyncClient) -> None:
    response = await api.get("/posts", params={"category": "receitas"})

    assert response.status_code == 422


@respx.mock
async def test_detail_reaches_public_and_unlisted(api: httpx.AsyncClient) -> None:
    route = respx.get(STRAPI_POSTS).mock(
        return_value=httpx.Response(200, json=strapi_list(strapi_post(visibility="unlisted")))
    )

    response = await api.get("/posts/cinco-dias-em-belem")

    params = route.calls.last.request.url.params
    assert {params["filters[visibility][$in][0]"], params["filters[visibility][$in][1]"]} == {"public", "unlisted"}
    assert response.json()["visibility"] == "unlisted"


@respx.mock
async def test_private_post_is_not_found(api: httpx.AsyncClient) -> None:
    # Strapi applies the visibility filter, so a private post comes back as an empty list.
    respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json=strapi_list()))

    response = await api.get("/posts/belem-diario")

    assert response.status_code == 404


@respx.mock
async def test_detail_exposes_blocks_social_links_and_reading_time(api: httpx.AsyncClient) -> None:
    words = " ".join(["palavra"] * 400)
    post = strapi_post(
        instagram_url="https://www.instagram.com/reel/ABC/",
        youtube_url="",
        body=[
            {
                "__component": "blocks.text",
                "body": [{"type": "paragraph", "children": [{"type": "text", "text": words}]}],
            }
        ],
    )
    respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json=strapi_list(post)))

    body = (await api.get("/posts/cinco-dias-em-belem")).json()

    assert [b["type"] for b in body["body"]] == ["text"]
    assert body["instagram_url"] == "https://www.instagram.com/reel/ABC/"
    assert body["youtube_url"] is None
    assert body["reading_time_minutes"] == 2
