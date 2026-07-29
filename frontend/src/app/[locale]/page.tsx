import Image from "next/image";
import { setRequestLocale, getTranslations } from "next-intl/server";
import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { PostRow } from "@/components/cards/PostCard";
import { ProjectCard } from "@/components/cards/ProjectCard";
import { LabItem } from "@/components/cards/LabItem";
import { getProfile, listPosts, listProjects, listLab } from "@/lib/api";
import { mediaUrl } from "@/lib/format";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: Locale }>;
}) {
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

  // The home hub deliberately shows *featured* items, not most-recent. Curation
  // is a manual signal (featured + featured_order) set in Strapi admin.
  const [profile, posts, projects, lab, tHome, tNotFound] = await Promise.all([
    getProfile(locale),
    listPosts(locale, { featured: true, pageSize: 5 }),
    listProjects(locale, { featured: true, pageSize: 3 }),
    listLab(locale, { pageSize: 3 }),
    getTranslations({ locale, namespace: "home" }),
    getTranslations({ locale, namespace: "meta" }),
  ]);

  return (
    <Container size="wide" className="py-12">
      {/* Hero: avatar + name + role + short_bio. No carousel, no big hero, no generic tagline. */}
      <section className="mb-16 flex flex-col gap-6 sm:flex-row sm:items-start">
        {profile?.avatar?.url && (
          <div className="relative h-24 w-24 shrink-0 overflow-hidden rounded-full border border-[color:var(--color-border)]">
            <Image
              src={mediaUrl(profile.avatar.url)}
              alt={profile?.name ?? ""}
              fill
              unoptimized
              className="object-cover"
              sizes="96px"
            />
          </div>
        )}
        <div>
          <h1 className="text-2xl font-semibold text-[color:var(--color-fg)]">
            {profile?.name ?? tNotFound("site_title")}
          </h1>
          {profile?.role && (
            <p className="mt-1 text-sm text-[color:var(--color-muted)]">
              {profile.role}
              {profile.company ? ` · ${profile.company}` : ""}
              {profile.location ? ` · ${profile.location}` : ""}
            </p>
          )}
          {profile?.short_bio && (
            <p className="mt-4 max-w-[65ch] text-[color:var(--color-fg)]">{profile.short_bio}</p>
          )}
        </div>
      </section>

      {/* Writing (posts list) */}
      <section className="mb-16">
        <SectionHeading
          title={tHome("writing")}
          linkHref="/blog"
          linkLabel={tHome("writing_all")}
        />
        {posts.data.length > 0 ? (
          <ul className="divide-y divide-[color:var(--color-border)]">
            {posts.data.map((p) => (
              <PostRow key={p.document_id} post={p} locale={locale} />
            ))}
          </ul>
        ) : (
          <EmptyHint />
        )}
      </section>

      {/* Building (projects grid) */}
      <section className="mb-16">
        <SectionHeading
          title={tHome("building")}
          linkHref="/projects"
          linkLabel={tHome("building_all")}
        />
        {projects.data.length > 0 ? (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {projects.data.map((p) => (
              <ProjectCard key={p.document_id} project={p} locale={locale} />
            ))}
          </div>
        ) : (
          <EmptyHint />
        )}
      </section>

      {/* Currently testing (lab, plain text) */}
      <section>
        <SectionHeading
          title={tHome("testing")}
          linkHref="/lab"
          linkLabel={tHome("testing_all")}
        />
        {lab.data.length > 0 ? (
          <div className="prose-reading">
            {lab.data.map((n) => (
              <LabItem key={n.document_id} item={n} locale={locale} />
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
  return (
    <p className="text-sm text-[color:var(--color-muted)]">—</p>
  );
}

// Home content changes when featured posts/projects/lab change → tag it.
export const revalidate = 300;
