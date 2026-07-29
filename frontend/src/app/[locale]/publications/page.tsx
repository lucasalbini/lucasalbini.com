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
    <Container size="reading" className="py-12">
      <h1 className="mb-8 text-2xl font-semibold">{t("title")}</h1>
      {publications.length === 0 ? (
        <p className="text-[color:var(--color-muted)]">{t("empty")}</p>
      ) : (
        <ul className="space-y-6">
          {publications.map((p) => (
            <li key={p.document_id} className="border-b border-[color:var(--color-border)] pb-6 last:border-b-0">
              <h2 className="font-semibold">
                {p.url ? <a href={p.url}>{p.title}</a> : p.title}
              </h2>
              {(p.journal || p.date) && (
                <p className="mt-1 text-sm text-[color:var(--color-muted)]">
                  {p.journal}
                  {p.date ? ` · ${formatDate(p.date, locale, { year: "numeric" })}` : ""}
                </p>
              )}
              {p.authors && <p className="mt-1 text-xs text-[color:var(--color-muted)]">{p.authors}</p>}
              {p.abstract && <p className="mt-3 text-sm">{p.abstract}</p>}
              {p.doi && <p className="mt-2 font-mono text-xs text-[color:var(--color-muted)]">DOI: {p.doi}</p>}
            </li>
          ))}
        </ul>
      )}
    </Container>
  );
}
