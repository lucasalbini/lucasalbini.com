/**
 * Post categories. The enum lives in Strapi/API in English (CLAUDE.md naming rule);
 * URLs use the Portuguese plural: /arquivo/viagens. Labels come from messages/pt.json.
 */
export const CATEGORIES = ["travel", "project", "idea", "life", "work"] as const;
export type Category = (typeof CATEGORIES)[number];

const SEGMENTS: Record<Category, string> = {
  travel: "viagens",
  project: "projetos",
  idea: "ideias",
  life: "vida",
  work: "trabalho",
};

export function categorySegment(category: Category): string {
  return SEGMENTS[category];
}

export function categoryFromSegment(segment: string): Category | null {
  const match = CATEGORIES.find((c) => SEGMENTS[c] === segment);
  return match ?? null;
}
