"""Base DTOs shared across content types.

Strapi v5 already flattens attributes to the top level of each entry, so most fields
map 1:1. We only reshape when the frontend contract calls for it (e.g. renaming
`alternativeText` → `alternative_text`, exposing `available_locales`).
"""

from __future__ import annotations

from typing import Any, Generic, Optional, TypeVar
from pydantic import BaseModel, ConfigDict, Field

T = TypeVar("T")


class BaseDTO(BaseModel):
    model_config = ConfigDict(populate_by_name=True, extra="ignore")


class Media(BaseDTO):
    url: str
    alternative_text: Optional[str] = Field(default=None, alias="alternativeText")
    width: Optional[int] = None
    height: Optional[int] = None
    mime: Optional[str] = None


class Pagination(BaseDTO):
    page: int
    page_size: int = Field(alias="pageSize")
    page_count: int = Field(alias="pageCount")
    total: int


class Paginated(BaseModel, Generic[T]):
    data: list[T]
    pagination: Pagination


def extract_available_locales(entry: dict[str, Any], current_locale: str) -> list[str]:
    """Given a Strapi v5 entry with `localizations` populated, return the full set of
    locale codes in which this document exists (published or not, per publicationState=live).
    Always includes the current locale.
    """
    codes: set[str] = {current_locale}
    for loc in entry.get("localizations", []) or []:
        code = loc.get("locale")
        if code:
            codes.add(code)
    return sorted(codes)


def normalize_media(raw: Any) -> Optional[Media]:
    if not raw:
        return None
    if isinstance(raw, list):
        raw = raw[0] if raw else None
        if not raw:
            return None
    return Media.model_validate(raw)
