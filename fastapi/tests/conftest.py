from collections.abc import AsyncIterator, Iterator
from typing import Any

import httpx
import pytest

from app.main import app
from app.services import strapi_client, youtube


@pytest.fixture(autouse=True)
def empty_strapi_cache() -> Iterator[None]:
    """The Strapi cache is module-global; isolate every test from the others."""
    strapi_client.invalidate()
    yield
    strapi_client.invalidate()


@pytest.fixture(autouse=True)
def empty_youtube_cache() -> Iterator[None]:
    """Same as above for the per-channel YouTube feed cache."""
    youtube.clear_cache()
    yield
    youtube.clear_cache()


@pytest.fixture
async def api() -> AsyncIterator[httpx.AsyncClient]:
    """HTTP client against the app in-process. Strapi calls are mocked per test with respx."""
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as client:
        yield client


def strapi_list(*items: dict[str, Any]) -> dict[str, Any]:
    """Strapi v5 collection response with the given entries."""
    return {
        "data": list(items),
        "meta": {"pagination": {"page": 1, "pageSize": 25, "pageCount": 1, "total": len(items)}},
    }


def strapi_post(**overrides: Any) -> dict[str, Any]:
    post: dict[str, Any] = {
        "documentId": "doc-belem",
        "title": "Cinco dias em Belém",
        "slug": "cinco-dias-em-belem",
        "summary": "Açaí, chuva das 15h e o Ver-o-Peso às 6h.",
        "category": "travel",
        "visibility": "public",
        "date": "2026-10-10",
        "publishedAt": "2026-10-20T12:00:00.000Z",
        "cover": {"url": "/uploads/capa.jpg", "width": 1200, "height": 800},
        "tags": [],
        "collection": {"title": "Viagens", "slug": "viagens"},
        "body": [],
    }
    post.update(overrides)
    return post
