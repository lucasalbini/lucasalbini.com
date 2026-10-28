"""Base DTOs shared across content types.

Strapi v5 already flattens attributes to the top level of each entry, so most fields
map 1:1. We only reshape when the frontend contract calls for it (e.g. renaming
`alternativeText` → `alternative_text`, exposing `available_locales`).
"""

from __future__ import annotations

from typing import Any, Generic, TypeVar

from pydantic import BaseModel, ConfigDict, Field

T = TypeVar("T")


class BaseDTO(BaseModel):
    model_config = ConfigDict(populate_by_name=True, extra="ignore")


class Media(BaseDTO):
    url: str
    alternative_text: str | None = Field(default=None, alias="alternativeText")
    width: int | None = None
    height: int | None = None
    mime: str | None = None
    name: str | None = None
    ext: str | None = None
    size: float | None = None  # kilobytes, as Strapi reports it


class Pagination(BaseDTO):
    page: int
    page_size: int = Field(alias="pageSize")
    page_count: int = Field(alias="pageCount")
    total: int


class Paginated(BaseModel, Generic[T]):
    data: list[T]
    pagination: Pagination


def normalize_media(raw: Any) -> Media | None:
    if not raw:
        return None
    if isinstance(raw, list):
        raw = raw[0] if raw else None
        if not raw:
            return None
    return Media.model_validate(raw)


def normalize_media_list(raw: Any) -> list[Media]:
    """Multiple-media fields (galleries). Entries without a URL are dropped."""
    if not isinstance(raw, list):
        return []
    return [Media.model_validate(m) for m in raw if isinstance(m, dict) and m.get("url")]
