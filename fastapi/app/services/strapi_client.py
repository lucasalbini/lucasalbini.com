"""Low-level HTTP client for Strapi v5, with a locale-aware in-memory cache.

Design notes:
- Cache key includes every query param (so locale is always part of it).
- `invalidate(prefix=...)` lets webhooks drop just the affected slice.
- Populate is expressed as a Python dict following the Strapi v5 populate object syntax;
  it's flattened into `populate[field][populate][sub]` params on the fly. Callers should
  not craft populate strings — pass the dict shape and let the client flatten it.
"""

from __future__ import annotations

from typing import Any

import httpx
from cachetools import TTLCache

from app.config import settings

_cache: TTLCache[str, dict] = TTLCache(maxsize=512, ttl=settings.cache_ttl)


def _headers() -> dict[str, str]:
    if not settings.strapi_api_token:
        return {}
    return {"Authorization": f"Bearer {settings.strapi_api_token}"}


def _flatten_populate(populate: Any, prefix: str = "populate") -> dict[str, str]:
    """Turn a nested populate dict into flat Strapi v5 params.

    Examples:
        _flatten_populate(True) -> {"populate": "true"}  # populate=* usage
        _flatten_populate({"cover": True, "tags": True}) ->
            {"populate[cover]": "true", "populate[tags]": "true"}
        _flatten_populate({"tags": {"fields": ["label", "slug"]}}) ->
            {"populate[tags][fields][0]": "label",
             "populate[tags][fields][1]": "slug"}
    """
    out: dict[str, str] = {}
    if populate is True:
        out[prefix] = "*"
        return out
    if isinstance(populate, list):
        for i, v in enumerate(populate):
            out[f"{prefix}[{i}]"] = str(v)
        return out
    if isinstance(populate, dict):
        for k, v in populate.items():
            key = f"{prefix}[{k}]"
            if v is True:
                out[f"{key}[populate]"] = "*"
            elif isinstance(v, (dict, list)):
                nested = _flatten_populate(v, key)
                out.update(nested)
            else:
                out[key] = str(v)
        return out
    return out


def _build_query(
    locale: str | None,
    populate: Any = None,
    filters: dict[str, str] | None = None,
    sort: list[str] | str | None = None,
    pagination: dict[str, int] | None = None,
    fields: list[str] | None = None,
    publication_state: str = "live",
) -> dict[str, str]:
    params: dict[str, str] = {}
    if locale:
        params["locale"] = locale
    if publication_state:
        params["publicationState"] = publication_state
    if populate is not None:
        if populate is True:
            params["populate"] = "*"
        else:
            params.update(_flatten_populate(populate))
    if filters:
        params.update(filters)
    if sort:
        if isinstance(sort, str):
            params["sort"] = sort
        else:
            for i, s in enumerate(sort):
                params[f"sort[{i}]"] = s
    if pagination:
        for k, v in pagination.items():
            params[f"pagination[{k}]"] = str(v)
    if fields:
        for i, f in enumerate(fields):
            params[f"fields[{i}]"] = f
    return params


def _cache_key(endpoint: str, params: dict[str, str]) -> str:
    sorted_params = tuple(sorted(params.items()))
    return f"{endpoint}::{sorted_params}"


async def fetch(
    endpoint: str,
    *,
    locale: str | None = None,
    populate: Any = None,
    filters: dict[str, str] | None = None,
    sort: list[str] | str | None = None,
    pagination: dict[str, int] | None = None,
    fields: list[str] | None = None,
    publication_state: str = "live",
    use_cache: bool = True,
    allow_missing: bool = False,
) -> dict:
    """Fetch from Strapi. If allow_missing=True, a 404 returns {"data": None} instead of raising —
    useful for single types that may not have been created yet."""
    params = _build_query(
        locale=locale,
        populate=populate,
        filters=filters,
        sort=sort,
        pagination=pagination,
        fields=fields,
        publication_state=publication_state,
    )
    key = _cache_key(endpoint, params)
    if use_cache and key in _cache:
        return _cache[key]

    url = f"{settings.strapi_base_url}/api/{endpoint}"
    async with httpx.AsyncClient(timeout=30) as client:
        r = await client.get(url, headers=_headers(), params=params)
        if allow_missing and r.status_code == 404:
            data: dict = {"data": None, "meta": {}}
        else:
            r.raise_for_status()
            data = r.json()

    if use_cache:
        _cache[key] = data
    return data


def invalidate(prefix: str | None = None) -> int:
    """Drop cache entries whose key starts with `prefix::` (or all if None). Returns count dropped."""
    if prefix is None:
        n = len(_cache)
        _cache.clear()
        return n
    keys = [k for k in list(_cache.keys()) if k.startswith(f"{prefix}::")]
    for k in keys:
        del _cache[k]
    return len(keys)
