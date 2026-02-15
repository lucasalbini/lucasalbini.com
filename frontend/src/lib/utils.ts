import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

const MONTHS_PT = [
  "janeiro", "fevereiro", "março", "abril", "maio", "junho",
  "julho", "agosto", "setembro", "outubro", "novembro", "dezembro",
];

export function formatDate(dateString: string): string {
  const date = new Date(dateString);
  return `${MONTHS_PT[date.getUTCMonth()]} de ${date.getUTCFullYear()}`;
}

export function getStrapiMediaUrl(url?: string): string {
  if (!url) return "";
  if (url.startsWith("http")) return url;
  return `${process.env.NEXT_PUBLIC_SITE_URL || ""}${url}`;
}

export function getCategoryLabel(category: string): string {
  const labels: Record<string, string> = {
    language: "Linguagens",
    framework: "Frameworks",
    cloud: "Cloud",
    ai_ml: "IA/ML",
    devops: "DevOps",
    tools: "Ferramentas",
    professional: "Profissional",
    academic: "Acadêmico",
    hobby: "Hobby",
  };
  return labels[category] || category;
}
