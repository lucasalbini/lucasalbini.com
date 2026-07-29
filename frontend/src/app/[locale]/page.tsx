import Image from "next/image";
import { setRequestLocale, getTranslations } from "next-intl/server";
import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { PostCard } from "@/components/cards/PostCard";
import { ProjectCard } from "@/components/cards/ProjectCard";
import { LabItem } from "@/components/cards/LabItem";
import { NeuralBackground } from "@/components/backgrounds/NeuralBackground";
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
    <>
      {/* --- HERO: full-width dark canvas with the neural-network backdrop --- */}
      <section className="relative overflow-hidden border-b border-[color:var(--color-border)] bg-[#0F1E17] text-[#EDE4D3]">
        <NeuralBackground className="absolute inset-0 z-0" />
        <Container
          size="full"
          className="relative z-10 grid gap-10 py-16 sm:py-24 md:grid-cols-[auto_1fr] md:items-center"
        >
          {profile?.avatar?.url ? (
            <div className="relative h-32 w-32 shrink-0 overflow-hidden rounded-full border-4 border-[#00D4AA] shadow-xl sm:h-40 sm:w-40">
              <Image
                src={mediaUrl(profile.avatar.url)}
                alt={profile?.name ?? ""}
                fill
                unoptimized
                sizes="160px"
                className="object-cover"
                priority
              />
            </div>
          ) : (
            <div className="relative h-32 w-32 shrink-0 rounded-full border-4 border-[#00D4AA] bg-[#162E24] sm:h-40 sm:w-40" />
          )}
          <div>
            <p className="font-mono text-xs uppercase tracking-[0.25em] text-[#00D4AA]">
              {tMeta("site_title")}
            </p>
            <h1 className="mt-2 text-4xl font-bold leading-tight sm:text-5xl">
              {profile?.name ?? "Lucas Albini"}
            </h1>
            {profile?.role && (
              <p className="mt-3 text-lg text-[#EDE4D3]/85 sm:text-xl">
                {profile.role}
                {profile.company ? <span className="text-[#EDE4D3]/60"> · {profile.company}</span> : null}
              </p>
            )}
            {profile?.short_bio && (
              <p className="mt-5 max-w-2xl text-base leading-relaxed text-[#EDE4D3]/85">
                {profile.short_bio}
              </p>
            )}
            <div className="mt-6 flex flex-wrap items-center gap-4 text-sm">
              {profile?.location && (
                <span className="text-[#EDE4D3]/60">📍 {profile.location}</span>
              )}
              {profile?.social_links && profile.social_links.length > 0 && (
                <SocialLinks
                  links={profile.social_links}
                  className="text-[#EDE4D3]/70 hover:text-[#D4734A]"
                />
              )}
            </div>
          </div>
        </Container>
      </section>

      <Container size="full" className="py-16">
        {/* Writing */}
        <section className="mb-20">
          <SectionHeading title={tHome("writing")} linkHref="/blog" linkLabel={tHome("writing_all")} />
          {posts.data.length > 0 ? (
            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
              {posts.data.map((p) => (
                <PostCard key={p.document_id} post={p} locale={locale} />
              ))}
            </div>
          ) : (
            <EmptyHint />
          )}
        </section>

        {/* Building */}
        <section className="mb-20">
          <SectionHeading title={tHome("building")} linkHref="/projects" linkLabel={tHome("building_all")} />
          {projects.data.length > 0 ? (
            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
              {projects.data.map((p) => (
                <ProjectCard key={p.document_id} project={p} locale={locale} />
              ))}
            </div>
          ) : (
            <EmptyProjectsHint locale={locale} />
          )}
        </section>

        {/* Currently testing */}
        <section>
          <SectionHeading title={tHome("testing")} linkHref="/lab" linkLabel={tHome("testing_all")} />
          {lab.data.length > 0 ? (
            <div className="grid gap-6 md:grid-cols-2">
              {lab.data.map((n) => (
                <div
                  key={n.document_id}
                  className="rounded-xl border border-[color:var(--color-border)] bg-[color:var(--color-surface)]/40 p-6"
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
    </>
  );
}

function EmptyHint() {
  return <p className="text-sm text-[color:var(--color-muted)]">—</p>;
}

async function EmptyProjectsHint({ locale }: { locale: Locale }) {
  const t = await getTranslations({ locale, namespace: "projects" });
  return (
    <div className="rounded-xl border border-dashed border-[color:var(--color-border)] p-8 text-center text-sm text-[color:var(--color-muted)]">
      {t("empty")}{" "}
      <Link href="/about" className="font-mono">
        → {t("title")}
      </Link>
    </div>
  );
}

export const revalidate = 300;
