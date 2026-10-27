from __future__ import annotations

from pydantic import EmailStr, Field

from app.schemas.common import BaseDTO


class ContactMessage(BaseDTO):
    name: str = Field(min_length=1, max_length=100)
    email: EmailStr
    message: str = Field(min_length=10, max_length=5000)


class ContactAck(BaseDTO):
    ok: bool = True
