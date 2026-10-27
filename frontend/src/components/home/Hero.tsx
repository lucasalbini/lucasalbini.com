import Image from "next/image";
import { getTranslations } from "next-intl/server";
import { FaInstagram, FaLocationDot, FaYoutube } from "react-icons/fa6";
import type { Profile, SocialLink } from "@/lib/types";
import { mediaUrl } from "@/lib/format";
import { SocialLinks } from "@/components/ui/SocialLinks";
import { socialLinksOf } from "@/lib/social";
import { splitSocialLinks } from "@/lib/home";

const NETWORK_ICON: Record<string, React.ReactElement> = {
  instagram: <FaInstagram aria-hidden />,
  youtube: <FaYoutube aria-hidden />,
};

function initials(name: string): string {
  return name
    .split(/\s+/)
    .filter(Boolean)
    .slice(0, 2)
    .map((w) => w[0]?.toUpperCase() ?? "")
    .join("");
}

function FollowButton({ link, label }: { link: SocialLink; label: string }) {
  return (
    <a href={link.url} target="_blank" rel="noopener noreferrer" className="btn-primary">
      {NETWORK_ICON[link.platform.toLowerCase()]}
      {label}
    </a>
  );
}

/**
 * Who Lucas is and where to follow him. Instagram and YouTube get real buttons; the
 * rest of the networks sit as icons. Professional details live on /sobre and LinkedIn.
 */
export async function Hero({ profile }: { profile: Profile | null }) {
  const t = await getTranslations("home");
  const name = profile?.name ?? "Lucas Albini";
  const { primary, secondary } = splitSocialLinks(socialLinksOf(profile?.social_links));

  return (
    <section className="pt-12 pb-16 sm:pt-20 sm:pb-20">
      <div className="flex flex-col gap-8 md:flex-row md:items-start md:justify-between md:gap-12">
        <div className="shrink-0 md:order-2">
          {profile?.avatar?.url ? (
            <div className="relative h-24 w-24 overflow-hidden rounded-full ring-2 ring-[color:var(--color-primary)] sm:h-28 sm:w-28">
              <Image src={mediaUrl(profile.avatar.url)} alt={name} fill unoptimized sizes="112px" className="object-cover" priority />
            </div>
          ) : (
            /* No avatar in Strapi yet — a monogram beats an empty ring. */
            <div className="flex h-24 w-24 items-center justify-center rounded-full bg-[color:var(--color-surface)] ring-2 ring-[color:var(--color-primary)] sm:h-28 sm:w-28">
              <span className="font-mono text-2xl font-semibold tracking-tight text-[color:var(--color-fg)]">{initials(name)}</span>
            </div>
          )}
        </div>

        <div className="min-w-0 md:order-1">
          <h1 className="text-display font-bold text-[color:var(--color-fg)]">{name}</h1>
          {profile?.short_bio && (
            <p className="mt-5 max-w-[60ch] text-lg leading-relaxed text-[color:var(--color-muted)]">{profile.short_bio}</p>
          )}

          <div className="mt-8 flex flex-wrap items-center gap-x-4 gap-y-4">
            {primary.map((link) => (
              <FollowButton
                key={link.url}
                link={link}
                label={t(link.platform.toLowerCase() === "youtube" ? "follow_youtube" : "follow_instagram")}
              />
            ))}
            {secondary.length > 0 && <SocialLinks links={secondary} size="md" />}
          </div>

          {profile?.location && (
            <p className="mt-6 inline-flex items-center gap-2 font-mono text-xs text-[color:var(--color-muted)]">
              <FaLocationDot aria-hidden />
              {profile.location}
            </p>
          )}
        </div>
      </div>
    </section>
  );
}
