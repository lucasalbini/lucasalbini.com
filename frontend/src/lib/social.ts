import type { SocialLink } from "@/lib/types";

/**
 * Fallback social links. The profile in Strapi owns these, but `social_links`
 * can be empty — without a fallback the site renders no way to follow Lucas,
 * which is the point of the site being a hub for the networks. Instagram and
 * YouTube handles are not hardcoded: they come from `social_links` in Strapi.
 */
export const FALLBACK_SOCIAL_LINKS: SocialLink[] = [
  { platform: "github", url: "https://github.com/lucasalbini" },
  { platform: "linkedin", url: "https://www.linkedin.com/in/lucasalbini" },
];

export const CONTACT_EMAIL = "lucasalbini@gmail.com";

export function socialLinksOf(links: SocialLink[] | undefined | null): SocialLink[] {
  return links && links.length > 0 ? links : FALLBACK_SOCIAL_LINKS;
}
