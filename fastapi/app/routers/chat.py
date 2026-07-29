"""Stub for the future RAG endpoint. The pgvector table is ready but nothing
computes or consumes embeddings yet.
"""

from __future__ import annotations
from fastapi import APIRouter, HTTPException

router = APIRouter(prefix="/chat", tags=["chat"])


@router.post("", status_code=501)
async def chat():
    raise HTTPException(status_code=501, detail="chat/RAG not implemented yet")
