import { getTranslations } from "next-intl/server";
import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import { LocaleSwitcher } from "./LocaleSwitcher";
import { ThemeToggle } from "./ThemeToggle";
import { Container } from "./Container";

export async function Header({ locale }: { locale: Locale }) {
  const t = await getTranslations({ locale, namespace: "nav" });

  return (
    <header className="border-b border-[color:var(--color-border)]">
      <Container size="wide" className="flex items-center justify-between py-4">
        <Link href="/" className="text-[color:var(--color-fg)] font-semibold no-underline hover:no-underline">
          lucasalbini<span className="text-[color:var(--color-muted)]">.com</span>
        </Link>
        <nav className="hidden gap-6 text-sm text-[color:var(--color-muted)] sm:flex">
          <Link href="/about" className="no-underline hover:text-[color:var(--color-fg)]">{t("about")}</Link>
          <Link href="/blog" className="no-underline hover:text-[color:var(--color-fg)]">{t("blog")}</Link>
          <Link href="/projects" className="no-underline hover:text-[color:var(--color-fg)]">{t("projects")}</Link>
          <Link href="/lab" className="no-underline hover:text-[color:var(--color-fg)]">{t("lab")}</Link>
          <Link href="/publications" className="no-underline hover:text-[color:var(--color-fg)]">{t("publications")}</Link>
        </nav>
        <div className="flex items-center gap-4">
          <LocaleSwitcher />
          <ThemeToggle />
        </div>
      </Container>
    </header>
  );
}
