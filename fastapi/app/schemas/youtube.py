from __future__ import annotations

from datetime import datetime

from app.schemas.common import BaseDTO


class YoutubeVideo(BaseDTO):
    video_id: str
    title: str
    url: str
    published_at: datetime
    thumbnail_url: str | None = None
