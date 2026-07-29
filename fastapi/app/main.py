import logging
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routers import (
    profile,
    posts,
    projects,
    lab,
    tags,
    cv,
    translations,
    publications,
    search,
    contact,
    webhooks,
    chat,
)

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(name)s: %(message)s")

app = FastAPI(
    title="lucasalbini.com API",
    version="2.0.0",
    description=(
        "Aggregation and normalization layer between Strapi v5 and the Next frontend. "
        "All read endpoints accept ?locale=pt-BR|en. Cache keys always include the locale."
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
    projects.router,
    lab.router,
    tags.router,
    cv.router,
    translations.router,
    publications.router,
    search.router,
    contact.router,
    webhooks.router,
    chat.router,
):
    app.include_router(r)


@app.get("/health", tags=["meta"])
async def health():
    return {"status": "ok"}
