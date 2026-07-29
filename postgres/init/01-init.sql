-- Runs once on first container start (only when postgres_data volume is empty).
-- Enables pgvector and prepares the embeddings table used by the future
-- semantic search / related posts / RAG features. No code consumes it yet.

CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS embeddings (
    id            BIGSERIAL PRIMARY KEY,
    kind          TEXT        NOT NULL,          -- 'post' | 'project' | 'lab'
    content_id    TEXT        NOT NULL,          -- Strapi documentId
    locale        TEXT,                          -- 'pt-BR' | 'en' | NULL for lab (not localized)
    chunk_index   INT         NOT NULL DEFAULT 0,
    content       TEXT        NOT NULL,
    embedding     vector(1536),                  -- OpenAI text-embedding-3-small dimension
    metadata      JSONB       NOT NULL DEFAULT '{}'::jsonb,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (kind, content_id, locale, chunk_index)
);

CREATE INDEX IF NOT EXISTS embeddings_kind_locale_idx
    ON embeddings (kind, locale);

CREATE INDEX IF NOT EXISTS embeddings_content_ref_idx
    ON embeddings (kind, content_id);

CREATE INDEX IF NOT EXISTS embeddings_vector_hnsw_idx
    ON embeddings USING hnsw (embedding vector_cosine_ops);
