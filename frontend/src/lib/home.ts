import type { PostSummary, SocialLink } from "@/lib/types";

/**
 * Home selection: featured posts lead (in their manual order), then the most recent
 * ones fill in. A post never shows twice. With nothing featured, the newest leads.
 */
export function pickHomePosts(
  featured: PostSummary[],
  recent: PostSummary[],
  limit = 7,
): { lead: PostSummary | null; rest: PostSummary[] } {
  const seen = new Set<string>();
  const ordered = [...featured, ...recent].filter((p) => {
    if (seen.has(p.document_id)) return false;
    seen.add(p.document_id);
    return true;
  });
  const [lead = null, ...rest] = ordered.slice(0, limit);
  return { lead, rest };
}

/** Networks the home puts first, in this order: the site exists to extend them. */
const PRIMARY_NETWORKS = ["instagram", "youtube"];

export function splitSocialLinks(links: SocialLink[]): { primary: SocialLink[]; secondary: SocialLink[] } {
  const isPrimary = (l: SocialLink) => PRIMARY_NETWORKS.includes(l.platform.toLowerCase());
  const primary = links
    .filter(isPrimary)
    .sort((a, b) => PRIMARY_NETWORKS.indexOf(a.platform.toLowerCase()) - PRIMARY_NETWORKS.indexOf(b.platform.toLowerCase()));
  return { primary, secondary: links.filter((l) => !isPrimary(l)) };
}

export function findSocialLink(links: SocialLink[], platform: string): SocialLink | null {
  return links.find((l) => l.platform.toLowerCase() === platform) ?? null;
}
