from __future__ import annotations
from typing import Any, Optional
from app.schemas.common import BaseDTO, Media, extract_available_locales, normalize_media
from app.schemas.tag import Tag, to_tag
from app.schemas.skill import Skill, to_skill


class Project(BaseDTO):
    document_id: str
    title: str
    slug: str
    summary: str
    body: list = []
    cover: Optional[Media] = None
    status: str
    kind: str
    stack: list[Skill] = []
    tags: list[Tag] = []
    repo_url: Optional[str] = None
    demo_url: Optional[str] = None
    itch_embed_url: Optional[str] = None
    year: Optional[int] = None
    featured: bool = False
    featured_order: int = 0
    locale: str
    available_locales: list[str] = []


def to_project(raw: dict[str, Any]) -> Project:
    return Project(
        document_id=raw.get("documentId", ""),
        title=raw.get("title", ""),
        slug=raw.get("slug", ""),
        summary=raw.get("summary", ""),
        body=raw.get("body") or [],
        cover=normalize_media(raw.get("cover")),
        status=raw.get("status", "active"),
        kind=raw.get("kind", ""),
        stack=[to_skill(s) for s in (raw.get("stack") or [])],
        tags=[to_tag(t) for t in (raw.get("tags") or [])],
        repo_url=raw.get("repo_url"),
        demo_url=raw.get("demo_url"),
        itch_embed_url=raw.get("itch_embed_url"),
        year=raw.get("year"),
        featured=bool(raw.get("featured", False)),
        featured_order=int(raw.get("featured_order") or 0),
        locale=raw.get("locale", ""),
        available_locales=extract_available_locales(raw, raw.get("locale", "")),
    )
