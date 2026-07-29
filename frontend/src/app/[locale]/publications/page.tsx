import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { listPublications } from "@/lib/api";
import { formatDate } from "@/lib/format";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "publications" });
  return pageMetadata({ locale, title: t("title"), href: { pathname: "/publications" } });
}

export default async function PublicationsPage({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const [publications, t] = await Promise.all([
    listPublications(locale),
    getTranslations({ locale, namespace: "publications" }),
  ]);

  return (
    <Container size="wide" className="py-12">
      <header className="mb-10">
        <h1 className="text-3xl font-semibold text-[color:var(--color-fg)]">{t("title")}</h1>
        <p className="mt-2 text-sm text-[color:var(--color-muted)]">
          {publications.length} {publications.length === 1 ? "publication" : "publications"}
        </p>
      </header>
      {publications.length === 0 ? (
        <p className="text-[color:var(--color-muted)]">{t("empty")}</p>
      ) : (
        <ul className="grid gap-6 md:grid-cols-2">
          {publications.map((p) => (
            <li
              key={p.document_id}
              className="flex flex-col rounded-xl border border-[color:var(--color-border)] bg-[color:var(--color-surface)]/40 p-6 transition-colors hover:border-[color:var(--color-primary)]"
            >
              <h2 className="text-lg font-semibold leading-tight text-[color:var(--color-fg)]">
                {p.url ? <a href={p.url}>{p.title}</a> : p.title}
              </h2>
              {(p.journal || p.date) && (
                <p className="mt-2 text-sm text-[color:var(--color-muted)]">
                  {p.journal}
                  {p.date ? ` · ${formatDate(p.date, locale, { year: "numeric" })}` : ""}
                </p>
              )}
              {p.authors && (
                <p className="mt-1 text-xs italic text-[color:var(--color-muted)]">{p.authors}</p>
              )}
              {p.abstract && <p className="mt-4 flex-1 text-sm text-[color:var(--color-fg)]/90">{p.abstract}</p>}
              {p.doi && (
                <p className="mt-4 font-mono text-[11px] text-[color:var(--color-muted)]">DOI: {p.doi}</p>
              )}
            </li>
          ))}
        </ul>
      )}
    </Container>
  );
}
