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
    <Container size="wide" className="py-12">
      <h1 className="mb-8 text-2xl font-semibold">{t("title")}</h1>
      {projects.data.length === 0 ? (
        <p className="text-[color:var(--color-muted)]">{t("empty")}</p>
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
