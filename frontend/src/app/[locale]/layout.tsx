import { notFound } from "next/navigation";
import { hasLocale, NextIntlClientProvider } from "next-intl";
import { setRequestLocale, getTranslations } from "next-intl/server";
import { routing } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Providers } from "@/providers/Providers";
import type { Metadata } from "next";

export function generateStaticParams() {
  return routing.locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  if (!hasLocale(routing.locales, locale)) return {};
  const t = await getTranslations({ locale, namespace: "meta" });
  return {
    title: { default: t("site_title"), template: `%s · ${t("site_title")}` },
    description: t("site_description"),
  };
}

export default async function LocaleLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  if (!hasLocale(routing.locales, locale)) notFound();
  setRequestLocale(locale);
  const htmlLang = locale === "pt" ? "pt-BR" : "en";

  return (
    <>
      {/* Root layout gives us <html> + <body>. We only manage locale-scoped chrome here. */}
      <script
        dangerouslySetInnerHTML={{
          __html: `document.documentElement.setAttribute('lang','${htmlLang}');document.documentElement.setAttribute('dir','ltr');`,
        }}
      />
      <NextIntlClientProvider>
        <Providers>
          <Header locale={locale as Locale} />
          <main className="min-h-[60vh] pb-16">{children}</main>
          <Footer locale={locale as Locale} />
        </Providers>
      </NextIntlClientProvider>
    </>
  );
}
