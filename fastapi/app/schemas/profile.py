from __future__ import annotations

from typing import Any

from app.schemas.common import BaseDTO, Media, extract_available_locales, normalize_media


class SocialLink(BaseDTO):
    platform: str
    url: str
    icon_name: str | None = None


class Profile(BaseDTO):
    name: str
    role: str | None = None
    company: str | None = None
    location: str | None = None
    short_bio: str | None = None
    long_bio: list = []
    avatar: Media | None = None
    cv_pdf: Media | None = None
    social_links: list[SocialLink] = []
    locale: str
    available_locales: list[str] = []


def to_profile(raw: dict[str, Any]) -> Profile:
    return Profile(
        name=raw.get("name", ""),
        role=raw.get("role"),
        company=raw.get("company"),
        location=raw.get("location"),
        short_bio=raw.get("short_bio"),
        long_bio=raw.get("long_bio") or [],
        avatar=normalize_media(raw.get("avatar")),
        cv_pdf=normalize_media(raw.get("cv_pdf")),
        social_links=[SocialLink.model_validate(s) for s in (raw.get("social_links") or [])],
        locale=raw.get("locale", ""),
        available_locales=extract_available_locales(raw, raw.get("locale", "")),
    )
