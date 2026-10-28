import type { Category } from "@/lib/categories";

// Handwritten DTO types that mirror the FastAPI schemas.
// When `npm run gen:api` runs against a live FastAPI, it generates `api-types.ts`
// from the live OpenAPI. We keep this file for the block editor shapes and small
// convenience types.

export type ApiLocale = "pt-BR" | "en";

export interface Media {
  url: string;
  // The API serializes the Strapi name (pydantic alias), not snake_case.
  alternativeText?: string | null;
  width?: number | null;
  height?: number | null;
  mime?: string | null;
  name?: string | null;
  ext?: string | null;
  size?: number | null;
}

// --- Strapi block editor ---
export type BlockChild =
  | { type: "text"; text: string; bold?: boolean; italic?: boolean; underline?: boolean; strikethrough?: boolean; code?: boolean }
  | { type: "link"; url: string; children: BlockChild[] };

export interface Block {
  type: "paragraph" | "heading" | "list" | "quote" | "code" | "image" | string;
  level?: number;
  format?: "ordered" | "unordered";
  language?: string;
  image?: Media;
  children?: BlockChild[];
  [k: string]: unknown;
}

// --- Content DTOs ---
export interface Tag {
  document_id: string;
  label: string;
  slug: string;
}

export type Visibility = "public" | "unlisted" | "private";

export interface CollectionRef {
  title: string;
  slug: string;
}

export interface PostSummary {
  document_id: string;
  title: string;
  slug: string;
  summary: string;
  cover: Media | null;
  category: Category;
  visibility: Visibility;
  date: string | null;
  tags: Tag[];
  collection: CollectionRef | null;
  featured: boolean;
  featured_order: number;
  published_at: string | null;
}

export type PlaceKind = "restaurant" | "bar" | "cafe" | "lodging" | "attraction" | "nature" | "city" | "other";

export interface Place {
  document_id: string;
  name: string;
  slug: string;
  kind: PlaceKind;
  latitude: number;
  longitude: number;
  address: string | null;
  city: string | null;
  country: string | null;
  url: string | null;
  note: string | null;
  photo: Media | null;
}

// --- Post body blocks (mirror app/schemas/blocks.py) ---
export interface TextBlock { type: "text"; body: Block[] }
export interface ImageBlock { type: "image"; image: Media; caption: string | null; layout: "column" | "wide" | "full" }
export interface GalleryBlock { type: "gallery"; images: Media[]; caption: string | null }
export interface YoutubeBlock { type: "youtube"; url: string; caption: string | null }
export interface InstagramBlock { type: "instagram"; url: string; caption: string | null }
export interface PlacesBlock { type: "places"; title: string | null; places: Place[] }
export interface DownloadBlock { type: "download"; file: Media; label: string; description: string | null }
export interface LinkBlock { type: "link"; url: string; title: string; description: string | null }
export interface CalloutBlock { type: "callout"; body: string; tone: "note" | "tip" | "warning" }

export type PostBlock =
  | TextBlock
  | ImageBlock
  | GalleryBlock
  | YoutubeBlock
  | InstagramBlock
  | PlacesBlock
  | DownloadBlock
  | LinkBlock
  | CalloutBlock;

export interface Post extends PostSummary {
  body: PostBlock[];
  instagram_url: string | null;
  youtube_url: string | null;
  reading_time_minutes: number | null;
}

export interface Collection {
  document_id: string;
  title: string;
  slug: string;
  description: string | null;
  cover: Media | null;
}

export interface CollectionDetail extends Collection {
  posts: PostSummary[];
}

export interface YoutubeVideo {
  video_id: string;
  title: string;
  url: string;
  published_at: string;
  thumbnail_url: string | null;
}

export interface SocialLink {
  platform: string;
  url: string;
  icon_name?: string | null;
}

export interface Profile {
  name: string;
  role: string | null;
  company: string | null;
  location: string | null;
  short_bio: string | null;
  long_bio: Block[];
  now: string | null;
  avatar: Media | null;
  cv_pdf: Media | null;
  social_links: SocialLink[];
}

export interface Paginated<T> {
  data: T[];
  pagination: { page: number; page_size: number; page_count: number; total: number };
}

export interface TagAggregation {
  tag: Tag;
  posts: PostSummary[];
}
