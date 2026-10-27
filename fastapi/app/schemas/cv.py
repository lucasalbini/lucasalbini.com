from __future__ import annotations

from app.schemas.certification import Certification
from app.schemas.common import BaseDTO
from app.schemas.education import Education
from app.schemas.experience import Experience
from app.schemas.profile import Profile
from app.schemas.skill import Skill


class CV(BaseDTO):
    profile: Profile | None = None
    experiences: list[Experience] = []
    education: list[Education] = []
    certifications: list[Certification] = []
    skills: list[Skill] = []
