import httpx
import pytest
import respx

from app.config import settings
from app.routers import webhooks
from app.services import strapi_client

STRAPI = f"{settings.strapi_base_url}/api"


@respx.mock
async def test_profile_exposes_what_lucas_is_living_now(api: httpx.AsyncClient) -> None:
    respx.get(f"{STRAPI}/profile").mock(
        return_value=httpx.Response(200, json={"data": {"name": "Lucas Albini", "now": "Editando o vídeo de Belém"}})
    )

    response = await api.get("/profile")

    assert response.json()["now"] == "Editando o vídeo de Belém"


@respx.mock
async def test_profile_request_has_no_locale(api: httpx.AsyncClient) -> None:
    route = respx.get(f"{STRAPI}/profile").mock(return_value=httpx.Response(200, json={"data": {"name": "Lucas"}}))

    await api.get("/profile")

    assert "locale" not in route.calls.last.request.url.params


@respx.mock
async def test_missing_profile_is_not_found(api: httpx.AsyncClient) -> None:
    respx.get(f"{STRAPI}/profile").mock(return_value=httpx.Response(404))

    assert (await api.get("/profile")).status_code == 404


@pytest.fixture
def revalidated(monkeypatch: pytest.MonkeyPatch) -> list[str]:
    calls: list[str] = []

    async def fake_revalidate(tags: list[str]) -> None:
        calls.extend(tags)

    monkeypatch.setattr(webhooks, "call_next_revalidate", fake_revalidate)
    return calls


async def test_editing_a_place_refreshes_cached_posts(api: httpx.AsyncClient, revalidated: list[str]) -> None:
    strapi_client._cache["posts::()"] = {"data": []}

    response = await api.post("/hooks/strapi", json={"event": "entry.update", "model": "api::place.place"})

    assert response.status_code == 204
    assert "posts::()" not in strapi_client._cache
    assert revalidated == ["posts"]


async def test_publishing_a_post_refreshes_posts_and_home(api: httpx.AsyncClient, revalidated: list[str]) -> None:
    await api.post("/hooks/strapi", json={"event": "entry.publish", "model": "api::post.post"})

    assert revalidated == ["posts", "home"]


async def test_unknown_model_triggers_nothing(api: httpx.AsyncClient, revalidated: list[str]) -> None:
    await api.post("/hooks/strapi", json={"event": "entry.update", "model": "plugin::upload.file"})

    assert revalidated == []


async def test_webhook_with_wrong_secret_is_rejected(api: httpx.AsyncClient, monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(settings, "strapi_webhook_secret", "certo")

    response = await api.post("/hooks/strapi", json={}, headers={"X-Webhook-Secret": "errado"})

    assert response.status_code == 401
