from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import profile, experience, education, skill, certification, project, post, publication

app = FastAPI(title="Lucas Albini API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(profile.router)
app.include_router(experience.router)
app.include_router(education.router)
app.include_router(skill.router)
app.include_router(certification.router)
app.include_router(project.router)
app.include_router(post.router)
app.include_router(publication.router)


@app.get("/health")
async def health():
    return {"status": "ok"}
