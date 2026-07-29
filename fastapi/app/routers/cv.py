"""Aggregate endpoint for the /about page: single payload with everything needed."""

from __future__ import annotations
import asyncio
from fastapi import APIRouter, Query
from app.services.strapi_client import fetch
from app.schemas.cv import CV
from app.schemas.profile import to_profile
from app.schemas.experience import to_experience
from app.schemas.education import to_education
from app.schemas.certification import to_certification
from app.schemas.skill import to_skill
from app.config import settings

router = APIRouter(prefix="/cv", tags=["cv"])


@router.get("", response_model=CV)
async def get_cv(locale: str = Query(default=settings.default_locale)):
    profile_task = fetch(
        "profile",
        locale=locale,
        populate={
            "avatar": True,
            "cv_pdf": True,
            "social_links": True,
            "localizations": {"fields": ["locale"]},
        },
        allow_missing=True,
    )
    experiences_task = fetch(
        "experiences",
        locale=locale,
        populate={"company_logo": True, "positions": {"populate": "*"}},
        sort=["order:asc"],
        pagination={"page": 1, "pageSize": 100},
    )
    education_task = fetch(
        "educations",
        locale=locale,
        populate={"logo": True},
        sort=["start_date:desc"],
        pagination={"page": 1, "pageSize": 100},
    )
    certifications_task = fetch(
        "certifications",
        populate={"badge_image": True},
        sort=["issue_date:desc"],
        pagination={"page": 1, "pageSize": 100},
    )
    skills_task = fetch(
        "skills",
        locale=locale,
        populate={"icon": True},
        sort=["category:asc", "name:asc"],
        pagination={"page": 1, "pageSize": 200},
    )

    profile_raw, exp_raw, edu_raw, cert_raw, skills_raw = await asyncio.gather(
        profile_task, experiences_task, education_task, certifications_task, skills_task
    )

    profile_data = profile_raw.get("data")
    return CV(
        profile=to_profile(profile_data) if profile_data else None,
        experiences=[to_experience(e) for e in (exp_raw.get("data") or [])],
        education=[to_education(e) for e in (edu_raw.get("data") or [])],
        certifications=[to_certification(c) for c in (cert_raw.get("data") or [])],
        skills=[to_skill(s) for s in (skills_raw.get("data") or [])],
    )
