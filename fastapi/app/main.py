import logging

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routers import (
    chat,
    collections,
    contact,
    posts,
    profile,
    search,
    tags,
    webhooks,
    youtube,
)

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(name)s: %(message)s")

app = FastAPI(
    title="lucasalbini.com API",
    version="2.0.0",
    description=(
        "Aggregation and normalization layer between Strapi v5 and the Next frontend. "
        "Portuguese only (ADR-0002): posts, profile and tags take no locale. Post visibility is enforced here."
    ),
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

for r in (
    profile.router,
    posts.router,
    collections.router,
    tags.router,
    search.router,
    contact.router,
    webhooks.router,
    chat.router,
    youtube.router,
):
    app.include_router(r)


@app.get("/health", tags=["meta"])
async def health():
    return {"status": "ok"}
