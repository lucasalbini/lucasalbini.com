import type { SocialLink } from "@/lib/types";

/**
 * Fallback social links. The profile in Strapi owns these, but `social_links`
 * is often empty — without a fallback the hero renders no way to reach Lucas
 * at all, which is the one thing a recruiter landing on the home needs.
 */
export const FALLBACK_SOCIAL_LINKS: SocialLink[] = [
  { platform: "github", url: "https://github.com/lucasalbini" },
  { platform: "linkedin", url: "https://www.linkedin.com/in/lucasalbini" },
  { platform: "itch", url: "https://lucasalbini.itch.io/" },
];

export const CONTACT_EMAIL = "lucasalbini@gmail.com";

export function socialLinksOf(links: SocialLink[] | undefined | null): SocialLink[] {
  return links && links.length > 0 ? links : FALLBACK_SOCIAL_LINKS;
}
