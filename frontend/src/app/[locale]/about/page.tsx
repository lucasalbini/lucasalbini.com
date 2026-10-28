import Image from "next/image";
import { setRequestLocale, getTranslations } from "next-intl/server";
import { FaLocationDot } from "react-icons/fa6";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostBody } from "@/components/post/PostBody";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { SocialLinks } from "@/components/ui/SocialLinks";
import { getProfile } from "@/lib/api";
import { mediaUrl } from "@/lib/format";
import { pageMetadata } from "@/lib/metadata";
import { socialLinksOf } from "@/lib/social";

export async function generateMetadata() {
  const t = await getTranslations("about");
  return pageMetadata({ title: t("title"), href: "/about" });
}

export default async function AboutPage({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const [profile, t, tHome] = await Promise.all([
    getProfile(),
    getTranslations("about"),
    getTranslations("home"),
  ]);
  const links = socialLinksOf(profile?.social_links);

  return (
    <Container size="wide" className="py-12 lg:py-16">
      {profile && (
        <header className="mb-14 grid gap-8 md:grid-cols-[auto_1fr] md:items-start">
          {profile.avatar?.url && (
            <div className="relative h-28 w-28 shrink-0 overflow-hidden rounded-full ring-2 ring-[color:var(--color-primary)] sm:h-36 sm:w-36">
              <Image
                src={mediaUrl(profile.avatar.url)}
                alt={profile.name}
                fill
                unoptimized
                className="object-cover"
                sizes="144px"
              />
            </div>
          )}
          <div>
            <h1 className="text-3xl font-bold text-[color:var(--color-fg)] sm:text-4xl">{profile.name}</h1>
            {profile.role && (
              <p className="mt-2 text-lg text-[color:var(--color-muted)]">
                {profile.role}
                {profile.company ? ` · ${profile.company}` : ""}
              </p>
            )}
            {profile.location && (
              <p className="mt-2 inline-flex items-center gap-1.5 font-mono text-xs text-[color:var(--color-muted)]">
                <FaLocationDot aria-hidden />
                {profile.location}
              </p>
            )}
            <div className="mt-6 flex flex-wrap items-center gap-4">
              {links.length > 0 && <SocialLinks links={links} size="md" />}
              {profile.cv_pdf?.url && (
                <a
                  href={mediaUrl(profile.cv_pdf.url)}
                  download
                  className="inline-flex items-center gap-1.5 rounded-lg border border-[color:var(--color-primary)] px-3 py-1.5 font-mono text-xs text-[color:var(--color-primary)] no-underline transition-colors hover:bg-[color:var(--color-primary)] hover:text-white"
                >
                  {t("download_cv")} (PDF) ↓
                </a>
              )}
            </div>
          </div>
        </header>
      )}

      {profile?.now && (
        <section className="mb-14">
          <SectionHeading title={tHome("now")} />
          <p className="max-w-[65ch] text-lg leading-relaxed text-[color:var(--color-fg)]">{profile.now}</p>
        </section>
      )}

      {profile?.long_bio && profile.long_bio.length > 0 && (
        <section className="prose-reading max-w-[65ch]">
          <PostBody blocks={profile.long_bio} />
        </section>
      )}
    </Container>
  );
}
