import httpx
from cachetools import TTLCache
from app.config import settings

_cache = TTLCache(maxsize=128, ttl=settings.cache_ttl)


def _headers() -> dict:
    return {"Authorization": f"Bearer {settings.strapi_api_token}"}


def _cache_key(endpoint: str, params: dict | None) -> str:
    sorted_params = sorted((params or {}).items())
    return f"{endpoint}:{sorted_params}"


async def fetch(endpoint: str, params: dict | None = None) -> dict:
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
