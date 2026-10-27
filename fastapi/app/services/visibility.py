"""Who gets to see a post (ADR-0002 §4.4).

The FastAPI is the only public door to Strapi, so every read that touches posts goes
through one of these filters. A new endpoint that lists posts without `LISTED` leaks
unlisted and private posts.
"""

from __future__ import annotations

from typing import Literal

Visibility = Literal["public", "unlisted", "private"]

# Shows up in lists, home, search, tags, collections, sitemap and feed.
LISTED: tuple[Visibility, ...] = ("public",)
# Reachable by direct link.
REACHABLE: tuple[Visibility, ...] = ("public", "unlisted")


def visibility_filter(allowed: tuple[Visibility, ...], path: str = "filters[visibility]") -> dict[str, str]:
    """Strapi `$in` filter. `path` lets callers filter through a relation,
    e.g. `filters[posts][visibility]`."""
    return {f"{path}[$in][{i}]": v for i, v in enumerate(allowed)}
