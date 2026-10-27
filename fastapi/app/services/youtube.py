"""Latest videos of a YouTube channel, read from its public Atom feed.

The feed needs no API key and lists the channel's 15 most recent uploads. Parsing is
kept pure (`parse_feed`) so it can be tested against a fixed XML; `fetch_latest`
adds HTTP + a TTL cache keyed by channel id and turns every failure into `[]`,
because the home simply hides the section when there is nothing to show.
"""

from __future__ import annotations

import logging
import re
from xml.etree.ElementTree import Element, ParseError

import httpx
from cachetools import TTLCache
from defusedxml import ElementTree
from defusedxml.common import DefusedXmlException
from pydantic import ValidationError

from app.config import settings
from app.schemas.youtube import YoutubeVideo

log = logging.getLogger(__name__)

FEED_URL = "https://www.youtube.com/feeds/videos.xml"
NS = {
    "atom": "http://www.w3.org/2005/Atom",
    "yt": "http://www.youtube.com/xml/schemas/2015",
    "media": "http://search.yahoo.com/mrss/",
}
# Same rule Strapi enforces on profile.youtube_channel_id.
CHANNEL_ID_RE = re.compile(r"^UC[\w-]{22}$")

_cache: TTLCache[str, list[YoutubeVideo]] = TTLCache(maxsize=16, ttl=settings.youtube_cache_ttl)


class FeedParseError(ValueError):
    """The payload is not a usable YouTube Atom feed."""


def _text(entry: Element, path: str) -> str | None:
    found = entry.find(path, NS)
    if found is None or found.text is None:
        return None
    return found.text.strip() or None


def _to_video(entry: Element) -> YoutubeVideo | None:
    video_id = _text(entry, "yt:videoId")
    title = _text(entry, "atom:title")
    published = _text(entry, "atom:published")
    if not (video_id and title and published):
        return None
    link = entry.find("atom:link[@rel='alternate']", NS)
    thumb = entry.find("media:group/media:thumbnail", NS)
    url = (link.get("href") if link is not None else None) or f"https://www.youtube.com/watch?v={video_id}"
    try:
        return YoutubeVideo.model_validate(
            {
                "video_id": video_id,
                "title": title,
                "url": url,
                "published_at": published,
                "thumbnail_url": thumb.get("url") if thumb is not None else None,
            }
        )
    except ValidationError:
        return None


def parse_feed(xml: str | bytes) -> list[YoutubeVideo]:
    """Parse a YouTube channel Atom feed, keeping YouTube's order (newest first).

    Entries missing id, title or a valid date are skipped. Raises FeedParseError when the
    payload is not XML, is an XML attack (entities, DTDs) or is not an Atom feed.
    """
    try:
        root = ElementTree.fromstring(xml)
    except (ParseError, DefusedXmlException) as exc:
        raise FeedParseError(str(exc)) from exc
    if root.tag != f"{{{NS['atom']}}}feed":
        raise FeedParseError(f"unexpected root element {root.tag}")
    videos = (_to_video(e) for e in root.findall("atom:entry", NS))
    return [v for v in videos if v is not None]


async def fetch_latest(channel_id: str) -> list[YoutubeVideo]:
    """Latest videos of `channel_id`, cached for `youtube_cache_ttl` seconds.

    Failures (invalid id, HTTP error, timeout, bad XML) log a warning and return `[]`
    without being cached, so the next request tries again.
    """
    if not CHANNEL_ID_RE.match(channel_id):
        log.warning("youtube: invalid channel id %r", channel_id)
        return []
    if channel_id in _cache:
        return _cache[channel_id]

    try:
        async with httpx.AsyncClient(timeout=settings.youtube_timeout) as client:
            r = await client.get(FEED_URL, params={"channel_id": channel_id})
            r.raise_for_status()
        videos = parse_feed(r.content)
    except httpx.HTTPError as exc:
        log.warning("youtube: feed request failed for %s: %r", channel_id, exc)
        return []
    except FeedParseError as exc:
        log.warning("youtube: invalid feed for %s: %s", channel_id, exc)
        return []

    _cache[channel_id] = videos
    return videos


def clear_cache() -> None:
    _cache.clear()
