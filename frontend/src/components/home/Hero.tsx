import Image from "next/image";
import { getTranslations } from "next-intl/server";
import { FaLocationDot, FaArrowDown } from "react-icons/fa6";
import { Link } from "@/lib/i18n/routing";
import type { Profile } from "@/lib/types";
import { mediaUrl } from "@/lib/format";
import { SocialLinks } from "@/components/ui/SocialLinks";
import { socialLinksOf, CONTACT_EMAIL } from "@/lib/social";

const PRIMARY_CTA = "btn-primary";

const SECONDARY_CTA =
  "text-sm font-medium text-[color:var(--color-fg)] underline decoration-[color:var(--color-primary)] decoration-2 underline-offset-4 hover:text-[color:var(--color-accent)]";

function initials(name: string): string {
  return name
    .split(/\s+/)
    .filter(Boolean)
    .slice(0, 2)
    .map((w) => w[0]?.toUpperCase() ?? "")
    .join("");
}

/**
 * Full-bleed hero — no card. Sits directly on the neural field, which the
 * layout's radial veil keeps readable. Leads with the name, closes with the
 * three actions a first-time visitor actually needs.
 */
export async function Hero({ profile }: { profile: Profile | null }) {
  const t = await getTranslations("home");
  const name = profile?.name ?? "Lucas Albini";
  const links = socialLinksOf(profile?.social_links);
  const cvUrl = profile?.cv_pdf?.url ? mediaUrl(profile.cv_pdf.url) : null;

  return (
    <section className="pt-12 pb-16 sm:pt-20 sm:pb-24">
      {/* Avatar sits on the right at desktop so the h1 keeps the same left edge
          as every section heading below it. */}
      <div className="flex flex-col gap-8 md:flex-row md:items-start md:justify-between md:gap-12">
        <div className="shrink-0 md:order-2">
          {profile?.avatar?.url ? (
            <div className="relative h-24 w-24 overflow-hidden rounded-full ring-2 ring-[color:var(--color-primary)] sm:h-28 sm:w-28">
              <Image
                src={mediaUrl(profile.avatar.url)}
                alt={name}
                fill
                unoptimized
                sizes="112px"
                className="object-cover"
                priority
              />
            </div>
          ) : (
            /* No avatar in Strapi yet — a monogram beats an empty ring. */
            <div className="flex h-24 w-24 items-center justify-center rounded-full bg-[color:var(--color-surface)] ring-2 ring-[color:var(--color-primary)] sm:h-28 sm:w-28">
              <span className="font-mono text-2xl font-semibold tracking-tight text-[color:var(--color-fg)]">
                {initials(name)}
              </span>
            </div>
          )}
        </div>

        <div className="min-w-0 md:order-1">
          <h1 className="text-display font-bold text-[color:var(--color-fg)]">{name}</h1>

          {profile?.role && (
            <p className="mt-4 text-lg text-[color:var(--color-fg)]/85 sm:text-xl">
              {profile.role}
              {profile.company && (
                <span className="text-[color:var(--color-muted)]"> · {profile.company}</span>
              )}
            </p>
          )}

          {profile?.short_bio && (
            <p className="mt-5 max-w-[60ch] text-base leading-relaxed text-[color:var(--color-muted)]">
              {profile.short_bio}
            </p>
          )}

          {/* The CV is the primary action when it exists; otherwise contact is,
              so the hero is never left without a solid call to action. */}
          <div className="mt-8 flex flex-wrap items-center gap-x-6 gap-y-4">
            {cvUrl ? (
              <>
                <a href={cvUrl} target="_blank" rel="noopener noreferrer" className={PRIMARY_CTA}>
                  <FaArrowDown className="text-xs" aria-hidden />
                  {t("cta_cv")}
                </a>
                <a href={`mailto:${CONTACT_EMAIL}`} className={SECONDARY_CTA}>
                  {t("cta_contact")}
                </a>
              </>
            ) : (
              <a href={`mailto:${CONTACT_EMAIL}`} className={PRIMARY_CTA}>
                {t("cta_contact")}
              </a>
            )}
            <Link href="/archive" className={SECONDARY_CTA}>
              {t("cta_archive")}
            </Link>
            <SocialLinks links={links} size="md" />
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
