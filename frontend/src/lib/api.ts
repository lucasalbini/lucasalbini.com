const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:8000";

// eslint-disable-next-line @typescript-eslint/no-explicit-any
async function fetchAPI<T = any>(endpoint: string, params?: Record<string, string>): Promise<T> {
  const url = new URL(`${API_URL}/${endpoint}`);
  if (params) {
    Object.entries(params).forEach(([key, value]) => {
      url.searchParams.set(key, value);
    });
  }

  const res = await fetch(url.toString(), { next: { revalidate: 300 } });
  if (!res.ok) {
    throw new Error(`API error: ${res.status} ${res.statusText}`);
  }
  return res.json();
}

export async function getProfile(locale = "pt-BR") {
  return fetchAPI("profile", { locale });
}

export async function getExperiences(locale = "pt-BR") {
  return fetchAPI("experiences", { locale });
}

export async function getEducation(locale = "pt-BR") {
  return fetchAPI("education", { locale });
}

export async function getSkills(locale = "pt-BR", category?: string) {
  const params: Record<string, string> = { locale };
  if (category) params.category = category;
  return fetchAPI("skills", params);
}

export async function getCertifications() {
  return fetchAPI("certifications");
}

export async function getProjects(locale = "pt-BR", category?: string) {
  const params: Record<string, string> = { locale };
  if (category) params.category = category;
  return fetchAPI("projects", params);
}

export async function getPosts(locale = "pt-BR", page = 1, pageSize = 10, featured?: boolean) {
  const params: Record<string, string> = { locale, page: String(page), pageSize: String(pageSize) };
  if (featured !== undefined) params.featured = String(featured);
  return fetchAPI("posts", params);
}

export async function getPostBySlug(slug: string, locale = "pt-BR") {
  return fetchAPI(`posts/${slug}`, { locale });
}

export async function getPublications(locale = "pt-BR") {
  return fetchAPI("publications", { locale });
}
