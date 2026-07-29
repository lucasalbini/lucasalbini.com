// Handwritten DTO types that mirror the FastAPI schemas.
// When `npm run gen:api` runs against a live FastAPI, it generates `api-types.ts`
// from the live OpenAPI. We keep this file for the block editor shapes and small
// convenience types.

export type ApiLocale = "pt-BR" | "en";

export interface Media {
  url: string;
  alternative_text?: string | null;
  width?: number | null;
  height?: number | null;
  mime?: string | null;
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
  locale: string;
}

export interface Skill {
  document_id: string;
  name: string;
  icon_name?: string | null;
  summary?: string | null;
  category: string;
  url?: string | null;
  icon?: Media | null;
  locale: string;
}

export interface Post {
  document_id: string;
  title: string;
  slug: string;
  summary: string;
  body: Block[];
  cover: Media | null;
  tags: Tag[];
  featured: boolean;
  featured_order: number;
  reading_time_minutes: number | null;
  published_at: string | null;
  locale: string;
  available_locales: string[];
}

export type ProjectStatus = "active" | "paused" | "archived" | "experiment";
export type ProjectKind = "game" | "ai" | "tool" | "tutorial";

export interface Project {
  document_id: string;
  title: string;
  slug: string;
  summary: string;
  body: Block[];
  cover: Media | null;
  status: ProjectStatus;
  kind: ProjectKind;
  stack: Skill[];
  tags: Tag[];
  repo_url: string | null;
  demo_url: string | null;
  itch_embed_url: string | null;
  year: number | null;
  featured: boolean;
  featured_order: number;
  locale: string;
  available_locales: string[];
}

export interface Lab {
  document_id: string;
  title: string;
  slug: string;
  date: string;
  body: Block[];
  external_link: string | null;
  language: "pt" | "en";
  tags: Tag[];
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
  avatar: Media | null;
  cv_pdf: Media | null;
  social_links: SocialLink[];
  locale: string;
  available_locales: string[];
}

export interface Publication {
  document_id: string;
  title: string;
  journal: string | null;
  authors: string | null;
  date: string | null;
  url: string | null;
  doi: string | null;
  abstract: string | null;
  locale: string;
  available_locales: string[];
}

export interface Responsibility { description: string }
export interface Position {
  designation: string;
  start_date: string;
  end_date: string | null;
  is_current: boolean;
  responsibilities: Responsibility[];
}
export interface Experience {
  document_id: string;
  company_name: string;
  company_url: string | null;
  company_location: string | null;
  company_logo: Media | null;
  order: number | null;
  positions: Position[];
  locale: string;
}

export interface Education {
  document_id: string;
  institution: string;
  degree: string | null;
  field_of_study: string | null;
  start_date: string | null;
  end_date: string | null;
  description: string | null;
  logo: Media | null;
  locale: string;
}

export interface Certification {
  document_id: string;
  name: string;
  issuer: string | null;
  issue_date: string | null;
  credential_url: string | null;
  badge_image: Media | null;
}

export interface CV {
  profile: Profile | null;
  experiences: Experience[];
  education: Education[];
  certifications: Certification[];
  skills: Skill[];
}

export interface Paginated<T> {
  data: T[];
  pagination: { page: number; page_size: number; page_count: number; total: number };
}

export interface TranslationEntry { locale: string; slug: string }
export interface TranslationLookup {
  type: string;
  source_locale: string;
  source_slug: string;
  translations: TranslationEntry[];
}

export interface TagAggregation {
  tag: Tag;
  posts: Post[];
  projects: Project[];
  lab: Lab[];
}
