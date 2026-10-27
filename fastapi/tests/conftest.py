from collections.abc import Iterator

import pytest

from app.services import strapi_client


@pytest.fixture(autouse=True)
def empty_strapi_cache() -> Iterator[None]:
    """The Strapi cache is module-global; isolate every test from the others."""
    strapi_client.invalidate()
    yield
    strapi_client.invalidate()
