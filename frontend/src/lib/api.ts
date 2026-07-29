import { apiLocale, type Locale } from "@/lib/i18n/routing";
import type {
  Post,
  Project,
  Lab,
  Profile,
  Publication,
  CV,
  Tag,
  TagAggregation,
  Paginated,
  TranslationLookup,
} from "@/lib/types";

const API_URL = process.env.API_URL || process.env.NEXT_PUBLIC_API_URL || "http://fastapi:8000";

async function get<T>(path: string, opts: { tags?: string[]; revalidate?: number } = {}): Promise<T> {
  const res = await fetch(`${API_URL}${path}`, {
    next: {
      revalidate: opts.revalidate ?? 300,
      tags: opts.tags,
    },
  });
  if (!res.ok) {
    if (res.status === 404) {
      throw new NotFoundError(path);
    }
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

export class NotFoundError extends Error {
  constructor(path: string) {
    super(`not found: ${path}`);
    this.name = "NotFoundError";
  }
}

function qs(params: Record<string, string | number | boolean | undefined | null>): string {
  const entries = Object.entries(params).filter(([, v]) => v !== undefined && v !== null);
  if (entries.length === 0) return "";
  const s = new URLSearchParams();
  for (const [k, v] of entries) s.set(k, String(v));
  return `?${s.toString()}`;
}

const tag = (kind: string, locale: Locale, extra?: string) =>
  extra ? `${kind}:${locale}:${extra}` : `${kind}:${locale}`;

// --- Profile / CV ---
export function getProfile(locale: Locale): Promise<Profile | null> {
  return getOrNull<Profile>(`/profile${qs({ locale: apiLocale(locale) })}`, {
    tags: [tag("profile", locale)],
  });
}

export function getCV(locale: Locale): Promise<CV> {
  return get<CV>(`/cv${qs({ locale: apiLocale(locale) })}`, { tags: [tag("cv", locale)] });
}

// --- Posts ---
export function listPosts(
  locale: Locale,
  opts: { page?: number; pageSize?: number; featured?: boolean; tag?: string } = {},
): Promise<Paginated<Post>> {
  return get(
    `/posts${qs({ locale: apiLocale(locale), page: opts.page, pageSize: opts.pageSize, featured: opts.featured, tag: opts.tag })}`,
    { tags: [tag("posts", locale), tag("home", locale)] },
  );
}

export function getPost(locale: Locale, slug: string): Promise<Post | null> {
  return getOrNull<Post>(`/posts/${encodeURIComponent(slug)}${qs({ locale: apiLocale(locale) })}`, {
    tags: [tag("posts", locale, slug)],
  });
}

// --- Projects ---
export function listProjects(
  locale: Locale,
  opts: { page?: number; pageSize?: number; featured?: boolean; kind?: string; status?: string; tag?: string } = {},
): Promise<Paginated<Project>> {
  return get(
    `/projects${qs({ locale: apiLocale(locale), page: opts.page, pageSize: opts.pageSize, featured: opts.featured, kind: opts.kind, status: opts.status, tag: opts.tag })}`,
    { tags: [tag("projects", locale), tag("home", locale)] },
  );
}

export function getProject(locale: Locale, slug: string): Promise<Project | null> {
  return getOrNull<Project>(`/projects/${encodeURIComponent(slug)}${qs({ locale: apiLocale(locale) })}`, {
    tags: [tag("projects", locale, slug)],
  });
}

// --- Lab (not localized on the CMS side; still tagged per-locale for cache) ---
export function listLab(
  locale: Locale,
  opts: { page?: number; pageSize?: number; language?: "pt" | "en"; tag?: string } = {},
): Promise<Paginated<Lab>> {
  return get(
    `/lab${qs({ page: opts.page, pageSize: opts.pageSize, language: opts.language, tag: opts.tag })}`,
    { tags: [tag("lab", locale), tag("home", locale)] },
  );
}

// --- Publications ---
export function listPublications(locale: Locale): Promise<Publication[]> {
  return get(`/publications${qs({ locale: apiLocale(locale) })}`, {
    tags: [tag("publications", locale)],
  });
}

// --- Tags ---
export function listTags(locale: Locale): Promise<Tag[]> {
  return get(`/tags${qs({ locale: apiLocale(locale) })}`, { tags: [tag("tags", locale)] });
}

export function getTagAggregation(locale: Locale, slug: string): Promise<TagAggregation | null> {
  return getOrNull<TagAggregation>(`/tags/${encodeURIComponent(slug)}${qs({ locale: apiLocale(locale) })}`, {
    tags: [tag("tags", locale, slug)],
  });
}

// --- Translations ---
export function getTranslations(
  type: "post" | "project",
  locale: Locale,
  slug: string,
): Promise<TranslationLookup | null> {
  return getOrNull<TranslationLookup>(
    `/translations/${type}/${encodeURIComponent(slug)}${qs({ locale: apiLocale(locale) })}`,
  );
}
