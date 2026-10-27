import httpx
import respx

from app.config import settings
from tests.conftest import strapi_list

STRAPI = f"{settings.strapi_base_url}/api"


@respx.mock
async def test_cv_reads_profile_without_locale_but_cv_entries_with_it(api: httpx.AsyncClient) -> None:
    profile = respx.get(f"{STRAPI}/profile").mock(return_value=httpx.Response(200, json={"data": {"name": "Lucas"}}))
    experiences = respx.get(f"{STRAPI}/experiences").mock(return_value=httpx.Response(200, json=strapi_list()))
    for endpoint in ("educations", "certifications", "skills"):
        respx.get(f"{STRAPI}/{endpoint}").mock(return_value=httpx.Response(200, json=strapi_list()))

    response = await api.get("/cv", params={"locale": "pt-BR"})

    assert response.status_code == 200
    assert response.json()["profile"]["name"] == "Lucas"
    profile_params = profile.calls.last.request.url.params
    assert "locale" not in profile_params
    assert not any(k.startswith("populate[localizations]") for k in profile_params)
    assert experiences.calls.last.request.url.params["locale"] == "pt-BR"
