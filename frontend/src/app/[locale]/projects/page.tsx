import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { ProjectCard } from "@/components/cards/ProjectCard";
import { listProjects } from "@/lib/api";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "projects" });
  return pageMetadata({ locale, title: t("title"), href: { pathname: "/projects" } });
}

export default async function ProjectsIndex({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const [projects, t] = await Promise.all([
    listProjects(locale, { pageSize: 60 }),
    getTranslations({ locale, namespace: "projects" }),
  ]);

  const total = projects.pagination?.total ?? projects.data.length;

  return (
    <Container size="wide" className="py-16 sm:py-20">
      <header className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-[color:var(--color-fg)] sm:text-5xl">
          {t("title")}
        </h1>
        <p className="label-mono mt-3">
          {total} {total === 1 ? "project" : "projects"}
        </p>
      </header>
      {projects.data.length === 0 ? (
        <p className="text-[color:var(--color-muted)]">{t("empty")}</p>
      ) : (
        <div className="grid gap-12 sm:grid-cols-2 sm:gap-x-10">
          {projects.data.map((p) => (
            <ProjectCard key={p.document_id} project={p} locale={locale} />
          ))}
        </div>
      )}
    </Container>
  );
}
