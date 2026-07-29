import Image from "next/image";
import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { PostCard } from "@/components/cards/PostCard";
import { ProjectCard } from "@/components/cards/ProjectCard";
import { LabItem } from "@/components/cards/LabItem";
import { SocialLinks } from "@/components/ui/SocialLinks";
import { getProfile, listPosts, listProjects, listLab } from "@/lib/api";
import { mediaUrl } from "@/lib/format";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "meta" });
  return pageMetadata({
    locale,
    title: t("site_title"),
    description: t("site_description"),
    href: { pathname: "/" },
  });
}

export default async function HomePage({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);

  const [profile, featuredPosts, featuredProjects, lab, tHome, tMeta] = await Promise.all([
    getProfile(locale),
    listPosts(locale, { featured: true, pageSize: 6 }),
    listProjects(locale, { featured: true, pageSize: 3 }),
    listLab(locale, { pageSize: 3 }),
    getTranslations({ locale, namespace: "home" }),
    getTranslations({ locale, namespace: "meta" }),
  ]);

  const posts = featuredPosts.data.length > 0 ? featuredPosts : await listPosts(locale, { pageSize: 6 });
  const projects = featuredProjects.data.length > 0 ? featuredProjects : await listProjects(locale, { pageSize: 3 });

  return (
    <Container size="full" className="py-16">
      {/* Hero — sits on the page-wide neural bg. Compact card so text stays readable. */}
      <section className="mb-16 rounded-2xl border border-[color:var(--color-border)] bg-[color:var(--color-bg)]/85 p-6 backdrop-blur-sm sm:p-10">
        <div className="grid gap-6 md:grid-cols-[auto_1fr] md:items-center">
          {profile?.avatar?.url ? (
            <div className="relative h-24 w-24 shrink-0 overflow-hidden rounded-full border-4 border-[color:var(--color-primary)] shadow sm:h-32 sm:w-32">
              <Image
                src={mediaUrl(profile.avatar.url)}
                alt={profile?.name ?? ""}
                fill
                unoptimized
                sizes="128px"
                className="object-cover"
                priority
              />
            </div>
          ) : (
            <div className="relative h-24 w-24 shrink-0 rounded-full border-4 border-[color:var(--color-primary)] bg-[color:var(--color-surface)] sm:h-32 sm:w-32" />
          )}
          <div>
            <p className="font-mono text-[11px] uppercase tracking-[0.25em] text-[color:var(--color-primary-dark)]">
              {tMeta("site_title")}
            </p>
            <h1 className="mt-1 text-3xl font-bold leading-tight text-[color:var(--color-fg)] sm:text-4xl">
              {profile?.name ?? "Lucas Albini"}
            </h1>
            {profile?.role && (
              <p className="mt-2 text-base text-[color:var(--color-fg)]/85 sm:text-lg">
                {profile.role}
                {profile.company ? <span className="text-[color:var(--color-muted)]"> · {profile.company}</span> : null}
              </p>
            )}
            {profile?.short_bio && (
              <p className="mt-3 max-w-2xl text-sm leading-relaxed text-[color:var(--color-fg)]/80">
                {profile.short_bio}
              </p>
            )}
            <div className="mt-4 flex flex-wrap items-center gap-4 text-sm">
              {profile?.location && (
                <span className="text-[color:var(--color-muted)]">📍 {profile.location}</span>
              )}
              {profile?.social_links && profile.social_links.length > 0 && (
                <SocialLinks links={profile.social_links} size="md" />
              )}
            </div>
          </div>
        </div>
      </section>

      {/* Writing */}
      <section className="mb-16">
        <SectionHeading title={tHome("writing")} linkHref="/blog" linkLabel={tHome("writing_all")} />
        {posts.data.length > 0 ? (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {posts.data.map((p) => (
              <PostCard key={p.document_id} post={p} locale={locale} variant="compact" />
            ))}
          </div>
        ) : (
          <EmptyHint />
        )}
      </section>

      {/* Building */}
      <section className="mb-16">
        <SectionHeading title={tHome("building")} linkHref="/projects" linkLabel={tHome("building_all")} />
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {projects.data.length > 0
            ? projects.data.map((p) => <ProjectCard key={p.document_id} project={p} locale={locale} variant="compact" />)
            : null}
        </div>
      </section>

      {/* Currently testing */}
      <section>
        <SectionHeading title={tHome("testing")} linkHref="/lab" linkLabel={tHome("testing_all")} />
        {lab.data.length > 0 ? (
          <div className="grid gap-4 md:grid-cols-2">
            {lab.data.map((n) => (
              <div
                key={n.document_id}
                className="rounded-xl border border-[color:var(--color-border)] bg-[color:var(--color-bg)]/85 p-5 backdrop-blur-sm"
              >
                <LabItem item={n} locale={locale} />
              </div>
            ))}
          </div>
        ) : (
          <EmptyHint />
        )}
      </section>
    </Container>
  );
}

function EmptyHint() {
  return <p className="text-sm text-[color:var(--color-muted)]">—</p>;
}

export const revalidate = 300;
