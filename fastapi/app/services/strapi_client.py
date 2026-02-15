import httpx
from cachetools import TTLCache
from app.config import settings

_cache = TTLCache(maxsize=128, ttl=settings.cache_ttl)


def _headers() -> dict:
    return {"Authorization": f"Bearer {settings.strapi_api_token}"}


def _build_populate_params(populate_value: str) -> dict:
    """Convert a comma-separated populate string into Strapi v5 indexed format.

    Flat fields like "photo,logo" become:
        {"populate[0]": "photo", "populate[1]": "logo"}

    Nested fields like "positions.responsibilities" become:
        {"populate[positions][populate][0]": "responsibilities"}

    Mixed values like "company_logo,positions.responsibilities" are handled
    by combining both strategies with a shared top-level index counter.
    """
    fields = [f.strip() for f in populate_value.split(",") if f.strip()]
    result: dict[str, str] = {}
    flat_index = 0
    # Track nested children grouped by their top-level relation
    nested: dict[str, list[str]] = {}

    for field in fields:
        if "." in field:
            parts = field.split(".", 1)
            parent = parts[0]
            child = parts[1]
            nested.setdefault(parent, []).append(child)
        else:
            result[f"populate[{flat_index}]"] = field
            flat_index += 1

    for parent, children in nested.items():
        # Ensure the parent relation itself is populated
        result[f"populate[{flat_index}]"] = parent
        flat_index += 1
        for child_idx, child in enumerate(children):
            if "." in child:
                # Handle deeper nesting recursively by flattening one more level
                sub_parts = child.split(".", 1)
                sub_parent = sub_parts[0]
                sub_child = sub_parts[1]
                result[
                    f"populate[{parent}][populate][{sub_parent}]"
                    f"[populate][0]"
                ] = sub_child
                result[
                    f"populate[{parent}][populate][{child_idx}]"
                ] = sub_parent
            else:
                result[
                    f"populate[{parent}][populate][{child_idx}]"
                ] = child

    return result


def _process_params(params: dict | None) -> dict | None:
    """Pre-process params to convert populate strings into Strapi v5 format."""
    if params is None or "populate" not in params:
        return params

    populate_value = params["populate"]

    # Already in v5 format (e.g. populate=*) or not a string — leave as-is
    if not isinstance(populate_value, str) or populate_value == "*":
        return params

    # Build new params dict without the original populate key
    new_params = {k: v for k, v in params.items() if k != "populate"}
    new_params.update(_build_populate_params(populate_value))
    return new_params


def _cache_key(endpoint: str, params: dict | None) -> str:
    sorted_params = sorted((params or {}).items())
    return f"{endpoint}:{sorted_params}"


async def fetch(endpoint: str, params: dict | None = None) -> dict:
    params = _process_params(params)
    key = _cache_key(endpoint, params)
    if key in _cache:
        return _cache[key]

    url = f"{settings.strapi_base_url}/api/{endpoint}"
    async with httpx.AsyncClient(timeout=30) as client:
        resp = await client.get(url, headers=_headers(), params=params)
        resp.raise_for_status()
        data = resp.json()

    _cache[key] = data
    return data
