import httpx
import pytest
import respx

from app.config import settings
from app.services.strapi_client import _build_query, _flatten_populate, fetch, invalidate

STRAPI_POSTS = f"{settings.strapi_base_url}/api/posts"


class TestFlattenPopulate:
    def test_true_populates_everything(self) -> None:
        assert _flatten_populate(True) == {"populate": "*"}

    def test_list_becomes_indexed_params(self) -> None:
        assert _flatten_populate(["cover", "tags"]) == {"populate[0]": "cover", "populate[1]": "tags"}

    def test_relation_set_to_true_populates_its_own_relations(self) -> None:
        assert _flatten_populate({"cover": True, "tags": True}) == {
            "populate[cover][populate]": "*",
            "populate[tags][populate]": "*",
        }

    def test_nested_fields_become_strapi_v5_bracket_params(self) -> None:
        assert _flatten_populate({"tags": {"fields": ["label", "slug"]}}) == {
            "populate[tags][fields][0]": "label",
            "populate[tags][fields][1]": "slug",
        }

    def test_deeply_nested_populate_keeps_full_path(self) -> None:
        populate = {"projects": {"populate": {"cover": {"fields": ["url"]}}}}

        assert _flatten_populate(populate) == {"populate[projects][populate][cover][fields][0]": "url"}

    def test_scalar_values_are_stringified(self) -> None:
        assert _flatten_populate({"tags": {"count": 3}}) == {"populate[tags][count]": "3"}

    def test_unsupported_input_yields_no_params(self) -> None:
        assert _flatten_populate(None) == {}


class TestBuildQuery:
    def test_defaults_to_live_publication_state(self) -> None:
        assert _build_query(locale=None) == {"publicationState": "live"}

    def test_locale_is_always_forwarded(self) -> None:
        assert _build_query(locale="pt-BR")["locale"] == "pt-BR"

    def test_combines_populate_filters_sort_pagination_and_fields(self) -> None:
        params = _build_query(
            locale="en",
            populate={"cover": True},
            filters={"filters[slug][$eq]": "hello"},
            sort=["date:desc", "title:asc"],
            pagination={"page": 2, "pageSize": 10},
            fields=["title", "slug"],
        )

        assert params == {
            "locale": "en",
            "publicationState": "live",
            "populate[cover][populate]": "*",
            "filters[slug][$eq]": "hello",
            "sort[0]": "date:desc",
            "sort[1]": "title:asc",
            "pagination[page]": "2",
            "pagination[pageSize]": "10",
            "fields[0]": "title",
            "fields[1]": "slug",
        }

    def test_string_sort_is_passed_through(self) -> None:
        assert _build_query(locale=None, sort="date:desc")["sort"] == "date:desc"

    def test_populate_true_becomes_wildcard(self) -> None:
        assert _build_query(locale=None, populate=True)["populate"] == "*"


class TestFetchCache:
    @respx.mock
    async def test_same_query_hits_strapi_once(self) -> None:
        route = respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json={"data": []}))

        await fetch("posts", locale="pt-BR")
        await fetch("posts", locale="pt-BR")

        assert route.call_count == 1

    @respx.mock
    async def test_cache_is_separated_by_locale(self) -> None:
        route = respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json={"data": []}))

        await fetch("posts", locale="pt-BR")
        await fetch("posts", locale="en")

        assert route.call_count == 2

    @respx.mock
    async def test_missing_single_type_returns_empty_data_when_allowed(self) -> None:
        respx.get(f"{settings.strapi_base_url}/api/profile").mock(return_value=httpx.Response(404))

        assert await fetch("profile", allow_missing=True) == {"data": None, "meta": {}}

    @respx.mock
    async def test_missing_resource_raises_by_default(self) -> None:
        respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(404))

        with pytest.raises(httpx.HTTPStatusError):
            await fetch("posts")


class TestInvalidate:
    @respx.mock
    async def test_prefix_drops_only_matching_endpoint(self) -> None:
        posts = respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json={"data": []}))
        projects = respx.get(f"{settings.strapi_base_url}/api/projects").mock(
            return_value=httpx.Response(200, json={"data": []})
        )
        await fetch("posts", locale="pt-BR")
        await fetch("projects", locale="pt-BR")

        dropped = invalidate("posts")
        await fetch("posts", locale="pt-BR")
        await fetch("projects", locale="pt-BR")

        assert dropped == 1
        assert (posts.call_count, projects.call_count) == (2, 1)

    @respx.mock
    async def test_prefix_does_not_match_longer_endpoint_names(self) -> None:
        respx.get(f"{settings.strapi_base_url}/api/posts-archive").mock(
            return_value=httpx.Response(200, json={"data": []})
        )
        await fetch("posts-archive")

        assert invalidate("posts") == 0

    @respx.mock
    async def test_no_prefix_drops_everything(self) -> None:
        respx.get(STRAPI_POSTS).mock(return_value=httpx.Response(200, json={"data": []}))
        await fetch("posts", locale="pt-BR")
        await fetch("posts", locale="en")

        assert invalidate() == 2
