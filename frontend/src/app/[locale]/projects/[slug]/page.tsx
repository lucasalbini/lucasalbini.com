import Image from "next/image";
import { notFound } from "next/navigation";
import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostBody } from "@/components/post/PostBody";
import { ItchEmbed } from "@/components/embeds/ItchEmbed";
import { TranslationNotice } from "@/components/post/TranslationNotice";
import { getProject } from "@/lib/api";
import { mediaUrl, absoluteUrl } from "@/lib/format";
import { alternates } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale; slug: string }> }) {
  const { locale, slug } = await params;
  const project = await getProject(locale, slug);
  if (!project) return {};
  return {
    title: project.title,
    description: project.summary,
    alternates: alternates({ href: { pathname: "/projects/[slug]", params: { slug } } }),
    openGraph: {
      title: project.title,
      description: project.summary,
      images: [absoluteUrl(`/api/og/${locale}/project/${slug}`)],
    },
  };
}

export default async function ProjectPage({ params }: { params: Promise<{ locale: Locale; slug: string }> }) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const [project, tProjects] = await Promise.all([
    getProject(locale, slug),
    getTranslations({ locale, namespace: "projects" }),
  ]);
  if (!project) notFound();

  const apiLocaleCode = locale === "pt" ? "pt-BR" : "en";
  const isFallback = project.locale !== apiLocaleCode;

  return (
    <Container size="reading" className="py-12">
      {isFallback && <TranslationNotice locale={locale} />}

      <header className="mb-8">
        <h1 className="text-3xl font-semibold tracking-tight">{project.title}</h1>
        <div className="mt-3 flex flex-wrap items-center gap-3 font-mono text-xs text-[color:var(--color-muted)]">
          <span>{tProjects(`kind.${project.kind}`)}</span>
          <span>· {tProjects(`status.${project.status}`)}</span>
          {project.year && <span>· {project.year}</span>}
        </div>
        <p className="mt-4 text-[color:var(--color-muted)]">{project.summary}</p>
      </header>

      {project.cover?.url && (
        <div className="relative mb-8 aspect-[16/9] w-full overflow-hidden rounded border border-[color:var(--color-border)]">
          <Image
            src={mediaUrl(project.cover.url)}
            alt={project.cover.alternative_text ?? project.title}
            fill
            unoptimized
            className="object-cover"
            sizes="(max-width: 900px) 100vw, 900px"
          />
        </div>
      )}

      <article className="prose-reading">
        <PostBody blocks={project.body} />
      </article>

      {project.itch_embed_url && <ItchEmbed url={project.itch_embed_url} title={project.title} />}

      <div className="mt-8 flex flex-wrap gap-4 font-mono text-sm">
        {project.repo_url && <a href={project.repo_url}>{tProjects("code")} ↗</a>}
        {project.demo_url && <a href={project.demo_url}>{tProjects("demo")} ↗</a>}
      </div>

      {project.stack.length > 0 && (
        <div className="mt-6 text-sm text-[color:var(--color-muted)]">
          <span className="font-mono text-xs uppercase tracking-wide">{tProjects("stack")}: </span>
          {project.stack.map((s) => s.name).join(" · ")}
        </div>
      )}

      <p className="mt-16 font-mono text-xs">
        <a href={`/${locale}/${locale === "pt" ? "projetos" : "projects"}`}>{tProjects("back")}</a>
      </p>
    </Container>
  );
}
