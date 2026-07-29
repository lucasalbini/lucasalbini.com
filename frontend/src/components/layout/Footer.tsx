import { getTranslations } from "next-intl/server";
import { FaRss } from "react-icons/fa6";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "./Container";
import { SocialLinks } from "@/components/ui/SocialLinks";
import { FALLBACK_SOCIAL_LINKS } from "@/lib/social";

export async function Footer({ locale }: { locale: Locale }) {
  const t = await getTranslations({ locale, namespace: "footer" });
  const year = new Date().getFullYear();
  const feedHref = `/${locale}/feed.xml`;

  return (
    <footer className="mt-8 border-t border-[color:var(--color-border)] py-10 text-sm text-[color:var(--color-muted)]">
      <Container size="wide" className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <p>© {year} · {t("rights")}</p>
        <div className="flex items-center gap-4">
          <SocialLinks links={FALLBACK_SOCIAL_LINKS} size="md" />
          <a
            href={feedHref}
            aria-label="RSS"
            className="text-lg text-[color:var(--color-muted)] no-underline transition-colors hover:text-[color:var(--color-accent)]"
          >
            <FaRss />
          </a>
        </div>
      </Container>
    </footer>
  );
}
