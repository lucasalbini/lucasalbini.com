import { notFound } from "next/navigation";
import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostCard } from "@/components/cards/PostCard";
import { ProjectCard } from "@/components/cards/ProjectCard";
import { LabItem } from "@/components/cards/LabItem";
import { getTagAggregation } from "@/lib/api";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale; tag: string }> }) {
  const { locale, tag } = await params;
  const agg = await getTagAggregation(locale, tag);
  if (!agg) return {};
  return pageMetadata({
    locale,
    title: `#${agg.tag.label}`,
    href: { pathname: "/tags/[tag]", params: { tag } },
  });
}

export default async function TagPage({ params }: { params: Promise<{ locale: Locale; tag: string }> }) {
  const { locale, tag } = await params;
  setRequestLocale(locale);
  const [agg, tTags] = await Promise.all([
    getTagAggregation(locale, tag),
    getTranslations({ locale, namespace: "tags" }),
  ]);
  if (!agg) notFound();

  const nothing = agg.posts.length === 0 && agg.projects.length === 0 && agg.lab.length === 0;

  return (
    <Container size="reading" className="py-12">
      <p className="font-mono text-xs uppercase tracking-widest text-[color:var(--color-muted)]">
        {tTags("title")}
      </p>
      <h1 className="mt-2 text-2xl font-semibold">#{agg.tag.label}</h1>

      {nothing && <p className="mt-8 text-[color:var(--color-muted)]">{tTags("empty")}</p>}

      {agg.posts.length > 0 && (
        <section className="mt-10">
          <h2 className="mb-4 text-sm font-semibold uppercase tracking-widest text-[color:var(--color-muted)]">
            {tTags("posts")}
          </h2>
          {agg.posts.map((p) => (
            <PostCard key={p.document_id} post={p} locale={locale} />
          ))}
        </section>
      )}

      {agg.projects.length > 0 && (
        <section className="mt-10">
          <h2 className="mb-4 text-sm font-semibold uppercase tracking-widest text-[color:var(--color-muted)]">
            {tTags("projects")}
          </h2>
          <div className="grid gap-6 sm:grid-cols-2">
            {agg.projects.map((p) => (
              <ProjectCard key={p.document_id} project={p} locale={locale} />
            ))}
          </div>
        </section>
      )}

      {agg.lab.length > 0 && (
        <section className="mt-10">
          <h2 className="mb-4 text-sm font-semibold uppercase tracking-widest text-[color:var(--color-muted)]">
            {tTags("lab")}
          </h2>
          {agg.lab.map((n) => (
            <LabItem key={n.document_id} item={n} locale={locale} />
          ))}
        </section>
      )}
    </Container>
  );
}
