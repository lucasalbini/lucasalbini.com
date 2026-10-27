import httpx
import pytest

from app.routers import contact
from app.services import rate_limit
from app.services.rate_limit import RateLimiter


@pytest.fixture
def clock(monkeypatch: pytest.MonkeyPatch) -> list[float]:
    now = [1_000_000.0]
    monkeypatch.setattr(rate_limit.time, "time", lambda: now[0])
    return now


def test_limiter_allows_up_to_the_hourly_max(clock: list[float]) -> None:
    limiter = RateLimiter(max_per_hour=2)

    assert [limiter.check("1.2.3.4") for _ in range(3)] == [True, True, False]


def test_limiter_counts_each_ip_separately(clock: list[float]) -> None:
    limiter = RateLimiter(max_per_hour=1)
    limiter.check("1.1.1.1")

    assert limiter.check("2.2.2.2") is True


def test_limiter_forgets_hits_older_than_an_hour(clock: list[float]) -> None:
    limiter = RateLimiter(max_per_hour=1)
    limiter.check("1.2.3.4")
    clock[0] += 3601

    assert limiter.check("1.2.3.4") is True


VALID = {"name": "Ana", "email": "ana@example.com", "message": "Adorei o post de Belém!"}


async def test_contact_accepts_a_valid_message(api: httpx.AsyncClient, monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(contact, "_limiter", RateLimiter(max_per_hour=5))

    response = await api.post("/contact", json=VALID)

    assert response.status_code == 202
    assert response.json() == {"ok": True}


async def test_contact_rejects_an_invalid_email(api: httpx.AsyncClient) -> None:
    response = await api.post("/contact", json={**VALID, "email": "não-é-email"})

    assert response.status_code == 422


async def test_contact_answers_429_once_the_ip_hits_the_limit(
    api: httpx.AsyncClient, monkeypatch: pytest.MonkeyPatch
) -> None:
    monkeypatch.setattr(contact, "_limiter", RateLimiter(max_per_hour=1))
    await api.post("/contact", json=VALID)

    response = await api.post("/contact", json=VALID)

    assert response.status_code == 429
