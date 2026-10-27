from datetime import UTC, datetime
from pathlib import Path

import httpx
import pytest
import respx

from app.config import settings
from app.main import app
from app.services.youtube import FEED_URL, FeedParseError, fetch_latest, parse_feed

FEED_XML = (Path(__file__).parent / "fixtures" / "youtube_feed.xml").read_bytes()
CHANNEL_ID = "UCabcdefghijklmnopqrstuv"
STRAPI_PROFILE = f"{settings.strapi_base_url}/api/profile"


def _profile(channel_id: str | None) -> httpx.Response:
    return httpx.Response(200, json={"data": {"documentId": "p1", "youtube_channel_id": channel_id}, "meta": {}})


async def _get(path: str) -> httpx.Response:
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as client:
        return await client.get(path)


class TestParseFeed:
    def test_maps_entries_to_videos_in_feed_order(self) -> None:
        videos = parse_feed(FEED_XML)

        assert [v.video_id for v in videos] == ["vid00000001", "vid00000002", "vid00000003"]

    def test_extracts_title_url_date_and_thumbnail(self) -> None:
        first = parse_feed(FEED_XML)[0]

        assert first.model_dump() == {
            "video_id": "vid00000001",
            "title": "Agentes com LLM na prática",
            "url": "https://www.youtube.com/watch?v=vid00000001",
            "published_at": datetime(2026, 10, 20, 15, 0, tzinfo=UTC),
            "thumbnail_url": "https://i1.ytimg.com/vi/vid00000001/hqdefault.jpg",
        }

    def test_entry_without_link_falls_back_to_watch_url_and_no_thumbnail(self) -> None:
        third = parse_feed(FEED_XML)[2]

        assert (third.url, third.thumbnail_url) == ("https://www.youtube.com/watch?v=vid00000003", None)

    def test_entry_with_unparseable_date_is_skipped(self) -> None:
        xml = FEED_XML.replace(b"2026-10-20T15:00:00+00:00", b"ontem")

        assert [v.video_id for v in parse_feed(xml)] == ["vid00000002", "vid00000003"]

    def test_malformed_xml_raises_feed_parse_error(self) -> None:
        with pytest.raises(FeedParseError):
            parse_feed(b"<feed><entry>")

    def test_xml_entity_expansion_is_rejected(self) -> None:
        bomb = b'<?xml version="1.0"?><!DOCTYPE f [<!ENTITY a "aaaa">]><feed>&a;</feed>'

        with pytest.raises(FeedParseError):
            parse_feed(bomb)

    def test_non_atom_document_raises_feed_parse_error(self) -> None:
        with pytest.raises(FeedParseError):
            parse_feed(b"<html><body>consent page</body></html>")


class TestFetchLatest:
    @respx.mock
    async def test_second_call_is_served_from_cache(self) -> None:
        route = respx.get(FEED_URL).mock(return_value=httpx.Response(200, content=FEED_XML))

        await fetch_latest(CHANNEL_ID)
        videos = await fetch_latest(CHANNEL_ID)

        assert route.call_count == 1
        assert len(videos) == 3

    @respx.mock
    async def test_requests_feed_for_the_given_channel(self) -> None:
        route = respx.get(FEED_URL).mock(return_value=httpx.Response(200, content=FEED_XML))

        await fetch_latest(CHANNEL_ID)

        assert route.calls.last.request.url.params["channel_id"] == CHANNEL_ID

    @respx.mock
    async def test_failure_is_not_cached_so_next_call_retries(self) -> None:
        route = respx.get(FEED_URL).mock(
            side_effect=[httpx.Response(500), httpx.Response(200, content=FEED_XML)],
        )

        assert await fetch_latest(CHANNEL_ID) == []
        assert len(await fetch_latest(CHANNEL_ID)) == 3
        assert route.call_count == 2

    @respx.mock
    async def test_invalid_channel_id_never_hits_youtube(self) -> None:
        route = respx.get(FEED_URL)

        assert await fetch_latest("../../etc") == []
        assert not route.called


class TestLatestEndpoint:
    @respx.mock
    async def test_returns_videos_of_profile_channel(self) -> None:
        respx.get(STRAPI_PROFILE).mock(return_value=_profile(CHANNEL_ID))
        respx.get(FEED_URL).mock(return_value=httpx.Response(200, content=FEED_XML))

        response = await _get("/youtube/latest")

        assert response.status_code == 200
        assert response.json()[0] == {
            "video_id": "vid00000001",
            "title": "Agentes com LLM na prática",
            "url": "https://www.youtube.com/watch?v=vid00000001",
            "published_at": "2026-10-20T15:00:00Z",
            "thumbnail_url": "https://i1.ytimg.com/vi/vid00000001/hqdefault.jpg",
        }

    @respx.mock
    async def test_limit_caps_number_of_videos(self) -> None:
        respx.get(STRAPI_PROFILE).mock(return_value=_profile(CHANNEL_ID))
        respx.get(FEED_URL).mock(return_value=httpx.Response(200, content=FEED_XML))

        response = await _get("/youtube/latest?limit=2")

        assert [v["video_id"] for v in response.json()] == ["vid00000001", "vid00000002"]

    @pytest.mark.parametrize("limit", [0, 16])
    async def test_limit_outside_1_to_15_is_rejected(self, limit: int) -> None:
        response = await _get(f"/youtube/latest?limit={limit}")

        assert response.status_code == 422

    @respx.mock
    async def test_profile_reads_only_channel_field_without_locale(self) -> None:
        route = respx.get(STRAPI_PROFILE).mock(return_value=_profile(None))

        await _get("/youtube/latest")

        params = route.calls.last.request.url.params
        assert (params.get("fields[0]"), "locale" in params) == ("youtube_channel_id", False)

    @respx.mock
    async def test_without_channel_returns_empty_list_and_skips_youtube(self) -> None:
        respx.get(STRAPI_PROFILE).mock(return_value=_profile(None))
        feed = respx.get(FEED_URL)

        response = await _get("/youtube/latest")

        assert (response.status_code, response.json(), feed.called) == (200, [], False)

    @respx.mock
    async def test_missing_profile_returns_empty_list(self) -> None:
        respx.get(STRAPI_PROFILE).mock(return_value=httpx.Response(404))

        response = await _get("/youtube/latest")

        assert (response.status_code, response.json()) == (200, [])

    @respx.mock
    async def test_strapi_failure_returns_empty_list(self) -> None:
        respx.get(STRAPI_PROFILE).mock(return_value=httpx.Response(500))

        response = await _get("/youtube/latest")

        assert (response.status_code, response.json()) == (200, [])

    @respx.mock
    async def test_youtube_http_error_returns_empty_list(self) -> None:
        respx.get(STRAPI_PROFILE).mock(return_value=_profile(CHANNEL_ID))
        respx.get(FEED_URL).mock(return_value=httpx.Response(404))

        response = await _get("/youtube/latest")

        assert (response.status_code, response.json()) == (200, [])

    @respx.mock
    async def test_youtube_timeout_returns_empty_list(self) -> None:
        respx.get(STRAPI_PROFILE).mock(return_value=_profile(CHANNEL_ID))
        respx.get(FEED_URL).mock(side_effect=httpx.ReadTimeout("timed out"))

        response = await _get("/youtube/latest")

        assert (response.status_code, response.json()) == (200, [])

    @respx.mock
    async def test_invalid_xml_from_youtube_returns_empty_list(self) -> None:
        respx.get(STRAPI_PROFILE).mock(return_value=_profile(CHANNEL_ID))
        respx.get(FEED_URL).mock(return_value=httpx.Response(200, content=b"<not-xml"))

        response = await _get("/youtube/latest")

        assert (response.status_code, response.json()) == (200, [])
