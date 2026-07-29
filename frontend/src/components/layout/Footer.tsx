import { getTranslations } from "next-intl/server";
import { FaGithub, FaLinkedin, FaItchIo, FaRss } from "react-icons/fa6";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "./Container";

export async function Footer({ locale }: { locale: Locale }) {
  const t = await getTranslations({ locale, namespace: "footer" });
  const year = new Date().getFullYear();
  const feedHref = `/${locale}/feed.xml`;

  return (
    <footer className="mt-24 border-t border-[color:var(--color-border)] py-8 text-sm text-[color:var(--color-muted)]">
      <Container size="full" className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <p>© {year} · {t("rights")}</p>
        <div className="flex items-center gap-4">
          <a href="https://github.com/lucasalbini" aria-label="GitHub" className="text-[color:var(--color-muted)] hover:text-[color:var(--color-fg)]"><FaGithub /></a>
          <a href="https://www.linkedin.com/in/lucasalbini" aria-label="LinkedIn" className="text-[color:var(--color-muted)] hover:text-[color:var(--color-fg)]"><FaLinkedin /></a>
          <a href="https://lucasalbini.itch.io/" aria-label="itch.io" className="text-[color:var(--color-muted)] hover:text-[color:var(--color-fg)]"><FaItchIo /></a>
          <a href={feedHref} aria-label="RSS" className="text-[color:var(--color-muted)] hover:text-[color:var(--color-fg)]"><FaRss /></a>
        </div>
      </Container>
    </footer>
  );
}
