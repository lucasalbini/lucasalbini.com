from __future__ import annotations

from typing import Any, Literal

from app.schemas.common import BaseDTO, Media, normalize_media

PlaceKind = Literal["restaurant", "bar", "cafe", "lodging", "attraction", "nature", "city", "other"]


class Place(BaseDTO):
    document_id: str
    name: str
    slug: str
    kind: PlaceKind = "other"
    latitude: float
    longitude: float
    address: str | None = None
    city: str | None = None
    country: str | None = None
    url: str | None = None
    note: str | None = None
    photo: Media | None = None


def to_place(raw: dict[str, Any]) -> Place | None:
    """Places without coordinates can't be drawn on a map; they're dropped rather than
    sent as (0, 0), which would land in the Atlantic."""
    if raw.get("latitude") is None or raw.get("longitude") is None:
        return None
    return Place(
        document_id=raw.get("documentId", ""),
        name=raw.get("name", ""),
        slug=raw.get("slug", ""),
        kind=raw.get("kind") or "other",
        latitude=float(raw["latitude"]),
        longitude=float(raw["longitude"]),
        address=raw.get("address"),
        city=raw.get("city"),
        country=raw.get("country"),
        url=raw.get("url"),
        note=raw.get("note"),
        photo=normalize_media(raw.get("photo")),
    )
