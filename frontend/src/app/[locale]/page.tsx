import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { Hero } from "@/components/home/Hero";
import { FeaturedPostCard, PostRow } from "@/components/cards/PostCard";
import { ProjectCard } from "@/components/cards/ProjectCard";
import { LabRow } from "@/components/cards/LabItem";
import { getProfile, listPosts, listProjects, listLab } from "@/lib/api";
import { pageMetadata } from "@/lib/metadata";
import { CONTACT_EMAIL } from "@/lib/social";

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

  const [profile, featuredPosts, featuredProjects, lab, tHome] = await Promise.all([
    getProfile(locale),
    listPosts(locale, { featured: true, pageSize: 6 }),
    listProjects(locale, { featured: true, pageSize: 3 }),
    listLab(locale, { pageSize: 4 }),
    getTranslations({ locale, namespace: "home" }),
  ]);

  const posts = featuredPosts.data.length > 0 ? featuredPosts : await listPosts(locale, { pageSize: 6 });
  const projects =
    featuredProjects.data.length > 0 ? featuredProjects : await listProjects(locale, { pageSize: 3 });

  const [leadPost, ...restPosts] = posts.data;
  const [leadProject, ...restProjects] = projects.data;

  return (
    <Container size="wide">
      <Hero profile={profile} locale={locale} />

      {leadPost && (
        <section className="pb-20 sm:pb-24">
          <SectionHeading title={tHome("writing")} linkHref="/blog" linkLabel={tHome("writing_all")} />
          <FeaturedPostCard post={leadPost} locale={locale} />
          {restPosts.length > 0 && (
            <ul className="mt-10 divide-y divide-[color:var(--color-border)] border-t border-[color:var(--color-border)]">
              {restPosts.slice(0, 5).map((p) => (
                <PostRow key={p.document_id} post={p} locale={locale} />
              ))}
            </ul>
          )}
        </section>
      )}

      {leadProject && (
        <section className="pb-20 sm:pb-24">
          <SectionHeading title={tHome("building")} linkHref="/projects" linkLabel={tHome("building_all")} />
          {/* Lead project spans the full width; the rest sit side by side under
              it. Side-by-side columns of unequal card counts left a dead gap. */}
          <ProjectCard project={leadProject} locale={locale} size="lg" />
          {restProjects.length > 0 && (
            <div className="mt-12 grid gap-12 sm:grid-cols-2 sm:gap-x-10">
              {restProjects.slice(0, 2).map((p) => (
                <ProjectCard key={p.document_id} project={p} locale={locale} />
              ))}
            </div>
          )}
        </section>
      )}

      {/* Rendered only when the lab has notes — an empty section used to leave a
          large gap above the footer. */}
      {lab.data.length > 0 && (
        <section className="pb-20 sm:pb-24">
          <SectionHeading title={tHome("testing")} linkHref="/lab" linkLabel={tHome("testing_all")} />
          <ul className="divide-y divide-[color:var(--color-border)] border-t border-[color:var(--color-border)]">
            {lab.data.map((n) => (
              <LabRow key={n.document_id} item={n} locale={locale} />
            ))}
          </ul>
        </section>
      )}

      <section className="border-t border-[color:var(--color-border)] py-16 sm:py-20">
        <h2 className="max-w-[24ch] text-2xl font-semibold leading-tight text-[color:var(--color-fg)] sm:text-3xl">
          {tHome("contact_headline")}
        </h2>
        <p className="mt-4 max-w-[56ch] text-[color:var(--color-muted)]">{tHome("contact_body")}</p>
        <a
          href={`mailto:${CONTACT_EMAIL}`}
          className="mt-6 inline-block font-mono text-sm underline underline-offset-4"
        >
          {CONTACT_EMAIL}
        </a>
      </section>
    </Container>
  );
}

export const revalidate = 300;
