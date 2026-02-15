export interface StrapiImage {
  url: string;
  alternativeText?: string;
  width?: number;
  height?: number;
}

export interface SocialLink {
  id: number;
  platform: string;
  url: string;
  icon_name?: string;
}

export interface SoftSkill {
  id: number;
  name: string;
  level: number;
}

export interface Profile {
  id: number;
  name: string;
  designation: string;
  company: string;
  location: string;
  summary: string;
  typing_titles: string[];
  photo?: StrapiImage;
  background?: StrapiImage;
  resume?: { url: string };
  social_links: SocialLink[];
  soft_skills: SoftSkill[];
}

export interface Responsibility {
  id: number;
  description: string;
}

export interface Position {
  id: number;
  designation: string;
  start_date: string;
  end_date?: string;
  is_current: boolean;
  responsibilities: Responsibility[];
}

export interface Experience {
  id: number;
  company_name: string;
  company_url?: string;
  company_location: string;
  company_logo?: StrapiImage;
  order: number;
  positions: Position[];
}

export interface Education {
  id: number;
  institution: string;
  degree: string;
  field_of_study: string;
  start_date: string;
  end_date?: string;
  description?: string;
  logo?: StrapiImage;
}

export interface Skill {
  id: number;
  name: string;
  icon_name?: string;
  summary?: string;
  category: "language" | "framework" | "cloud" | "ai_ml" | "devops" | "tools";
  url?: string;
  icon?: StrapiImage;
}

export interface Certification {
  id: number;
  name: string;
  issuer: string;
  issue_date?: string;
  credential_url?: string;
  badge_image?: StrapiImage;
}

export interface Project {
  id: number;
  name: string;
  slug: string;
  description: string;
  role?: string;
  timeline?: string;
  repo_url?: string;
  demo_url?: string;
  logo?: StrapiImage;
  tags: string[];
  category: "professional" | "academic" | "hobby";
  featured: boolean;
}

export interface Post {
  id: number;
  title: string;
  slug: string;
  content: string;
  excerpt: string;
  featured_image?: StrapiImage;
  author: string;
  categories: string[];
  tags: string[];
  featured: boolean;
  reading_time: number;
  createdAt: string;
}

export interface Publication {
  id: number;
  title: string;
  journal?: string;
  authors: string;
  date?: string;
  url?: string;
  doi?: string;
  abstract?: string;
}

export interface StrapiResponse<T> {
  data: T;
  meta?: {
    pagination?: {
      page: number;
      pageSize: number;
      pageCount: number;
      total: number;
    };
  };
}
