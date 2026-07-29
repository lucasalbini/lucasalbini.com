import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { LabItem } from "@/components/cards/LabItem";
import { listLab } from "@/lib/api";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "lab" });
  return pageMetadata({ locale, title: t("title"), description: t("description"), href: { pathname: "/lab" } });
}

export default async function LabIndex({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const [lab, t] = await Promise.all([
    listLab(locale, { pageSize: 100 }),
    getTranslations({ locale, namespace: "lab" }),
  ]);

  return (
    <Container size="reading" className="py-16 sm:py-20">
      <h1 className="text-4xl font-bold tracking-tight text-[color:var(--color-fg)] sm:text-5xl">
        {t("title")}
      </h1>
      <p className="mt-4 max-w-[60ch] leading-relaxed text-[color:var(--color-muted)]">
        {t("description")}
      </p>
      <div className="mt-12 border-t border-[color:var(--color-border)]">
        {lab.data.length === 0 ? (
          <p className="text-[color:var(--color-muted)]">{t("empty")}</p>
        ) : (
          lab.data.map((n) => <LabItem key={n.document_id} item={n} locale={locale} />)
        )}
      </div>
    </Container>
  );
}
