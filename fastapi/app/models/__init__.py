from pydantic import BaseModel


class StrapiResponse(BaseModel):
    data: dict | list | None = None
    meta: dict | None = None
