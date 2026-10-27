"""Placeholder for semantic search / related posts / RAG.

The Postgres side is ready (extension `vector`, table `embeddings` with an HNSW index).
Nothing consumes it yet. When we plug an embedding provider in, this module will:

- chunk content (post/project/lab body) and compute embeddings per chunk
- write to `embeddings(kind, content_id, locale, chunk_index, content, embedding, metadata)`
- expose a `similar_to(kind, content_id, locale, top_k)` query used by:
    - "posts relacionados" on blog/[slug]
    - /search when the query is not a good tsvector match
    - /chat (RAG grounding)

Keep this file so imports don't break when we start wiring things up.
"""

from __future__ import annotations


async def similar_to(*_args, **_kwargs):
    raise NotImplementedError("embeddings service not implemented yet")


async def index_content(*_args, **_kwargs):
    raise NotImplementedError("embeddings service not implemented yet")
