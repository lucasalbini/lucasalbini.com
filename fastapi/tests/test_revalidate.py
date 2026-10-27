import httpx
import pytest
import respx

from app.config import settings
from app.services.revalidate import call_next_revalidate

NEXT = "http://next.test"


@pytest.fixture
def configured(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(settings, "next_url", NEXT + "/")
    monkeypatch.setattr(settings, "revalidate_secret", "s3cret")


@respx.mock
async def test_each_tag_is_revalidated_with_the_shared_secret(configured: None) -> None:
    route = respx.post(f"{NEXT}/api/revalidate").mock(return_value=httpx.Response(200))

    await call_next_revalidate(["posts", "home"])

    assert [dict(c.request.url.params) for c in route.calls] == [
        {"tag": "posts", "secret": "s3cret"},
        {"tag": "home", "secret": "s3cret"},
    ]


@respx.mock
async def test_nothing_is_sent_without_a_secret(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(settings, "revalidate_secret", "")
    route = respx.post(url__regex=r".*").mock(return_value=httpx.Response(200))

    await call_next_revalidate(["posts"])

    assert route.call_count == 0


@respx.mock
async def test_a_rejected_tag_does_not_stop_the_others(configured: None) -> None:
    route = respx.post(f"{NEXT}/api/revalidate").mock(
        side_effect=[httpx.Response(500, text="boom"), httpx.Response(200)]
    )

    await call_next_revalidate(["posts", "home"])

    assert route.call_count == 2


@respx.mock
async def test_an_unreachable_frontend_is_logged_not_raised(configured: None) -> None:
    respx.post(f"{NEXT}/api/revalidate").mock(side_effect=httpx.ConnectError("down"))

    await call_next_revalidate(["posts"])
