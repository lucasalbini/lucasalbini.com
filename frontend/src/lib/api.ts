import type { Category } from "@/lib/categories";
import type {
  CollectionDetail,
  Collection,
  Paginated,
  Post,
  PostSummary,
  Profile,
  Tag,
  TagAggregation,
  YoutubeVideo,
} from "@/lib/types";

const API_URL = process.env.API_URL || process.env.NEXT_PUBLIC_API_URL || "http://fastapi:8000";

/**
 * Cache tags revalidated by the FastAPI webhook (fastapi/app/routers/webhooks.py).
 * Single locale, so no suffix. Keep both sides in sync.
 */
export const CACHE_TAGS = {
  posts: "posts",
  home: "home",
  profile: "profile",
  collections: "collections",
  tags: "tags",
  youtube: "youtube",
} as const;

export class NotFoundError extends Error {
  constructor(path: string) {
    super(`not found: ${path}`);
    this.name = "NotFoundError";
  }
}

async function get<T>(path: string, opts: { tags?: string[]; revalidate?: number } = {}): Promise<T> {
  const res = await fetch(`${API_URL}${path}`, {
    next: {
      revalidate: opts.revalidate ?? 300,
      tags: opts.tags,
    },
  });
  if (!res.ok) {
    if (res.status === 404) throw new NotFoundError(path);
    throw new Error(`GET ${path} -> ${res.status} ${res.statusText}`);
  }
  return res.json() as Promise<T>;
}

async function getOrNull<T>(path: string, opts: Parameters<typeof get>[1] = {}): Promise<T | null> {
  try {
    return await get<T>(path, opts);
  } catch (e) {
    if (e instanceof NotFoundError) return null;
    throw e;
  }
}

export function qs(params: Record<string, string | number | boolean | undefined | null>): string {
  const entries = Object.entries(params).filter(([, v]) => v !== undefined && v !== null);
  if (entries.length === 0) return "";
  const s = new URLSearchParams();
  for (const [k, v] of entries) s.set(k, String(v));
  return `?${s.toString()}`;
}

// --- Profile ---
export function getProfile(): Promise<Profile | null> {
  return getOrNull<Profile>("/profile", { tags: [CACHE_TAGS.profile] });
}

// --- Posts ---
export interface ListPostsOptions {
  page?: number;
  pageSize?: number;
  category?: Category;
  tag?: string;
  collection?: string;
  featured?: boolean;
}

export function listPosts(opts: ListPostsOptions = {}): Promise<Paginated<PostSummary>> {
  const query = qs({
    page: opts.page,
    pageSize: opts.pageSize,
    category: opts.category,
    tag: opts.tag,
    collection: opts.collection,
    featured: opts.featured,
  });
  return get(`/posts${query}`, { tags: [CACHE_TAGS.posts, CACHE_TAGS.home] });
}

export function getPost(slug: string): Promise<Post | null> {
  return getOrNull<Post>(`/posts/${encodeURIComponent(slug)}`, { tags: [CACHE_TAGS.posts] });
}

// --- Collections ---
export function listCollections(): Promise<Collection[]> {
  return get("/collections", { tags: [CACHE_TAGS.collections] });
}

export function getCollection(slug: string): Promise<CollectionDetail | null> {
  return getOrNull<CollectionDetail>(`/collections/${encodeURIComponent(slug)}`, {
    tags: [CACHE_TAGS.collections, CACHE_TAGS.posts],
  });
}

// --- Tags ---
export function listTags(): Promise<Tag[]> {
  return get("/tags", { tags: [CACHE_TAGS.tags] });
}

export function getTagAggregation(slug: string): Promise<TagAggregation | null> {
  return getOrNull<TagAggregation>(`/tags/${encodeURIComponent(slug)}`, {
    tags: [CACHE_TAGS.tags, CACHE_TAGS.posts],
  });
}

// --- YouTube (empty list when no channel is configured or the feed is down) ---
export async function getLatestVideos(limit = 6): Promise<YoutubeVideo[]> {
  const videos = await getOrNull<YoutubeVideo[]>(`/youtube/latest${qs({ limit })}`, {
    tags: [CACHE_TAGS.youtube],
    revalidate: 900,
  });
  return videos ?? [];
}
