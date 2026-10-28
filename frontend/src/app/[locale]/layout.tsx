import { notFound } from "next/navigation";
import { hasLocale, NextIntlClientProvider } from "next-intl";
import { setRequestLocale, getTranslations } from "next-intl/server";
import { routing } from "@/lib/i18n/routing";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Providers } from "@/providers/Providers";
import type { Metadata } from "next";
import { getProfile } from "@/lib/api";
import { socialLinksOf } from "@/lib/social";

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
  const profile = await getProfile();

  return (
    <NextIntlClientProvider>
      <Providers>
        <div className="relative z-10 flex min-h-screen flex-col">
          <Header />
          {/* Pages own their own vertical padding — a blanket pb here stacked
              on top of it and left dead space above the footer. */}
          <main className="flex-1 overflow-x-clip">{children}</main>
          <Footer links={socialLinksOf(profile?.social_links)} year={new Date().getFullYear()} />
        </div>
      </Providers>
    </NextIntlClientProvider>
  );
}
