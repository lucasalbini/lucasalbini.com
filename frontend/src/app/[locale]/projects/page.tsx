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

  return (
    <Container size="full" className="py-12">
      <header className="mb-10">
        <h1 className="text-3xl font-semibold text-[color:var(--color-fg)]">{t("title")}</h1>
        <p className="mt-2 text-sm text-[color:var(--color-muted)]">
          {projects.pagination?.total ?? projects.data.length}{" "}
          {(projects.pagination?.total ?? projects.data.length) === 1 ? "project" : "projects"}
        </p>
      </header>
      {projects.data.length === 0 ? (
        <div className="rounded-xl border border-dashed border-[color:var(--color-border)] p-12 text-center text-[color:var(--color-muted)]">
          {t("empty")}
        </div>
      ) : (
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {projects.data.map((p) => (
            <ProjectCard key={p.document_id} project={p} locale={locale} />
          ))}
        </div>
      )}
    </Container>
  );
}
