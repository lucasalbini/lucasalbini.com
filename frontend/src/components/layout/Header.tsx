import { getTranslations } from "next-intl/server";
import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import { LocaleSwitcher } from "./LocaleSwitcher";
import { ThemeToggle } from "./ThemeToggle";
import { Container } from "./Container";

const NAV = [
  { href: "/about", key: "about" },
  { href: "/blog", key: "blog" },
  { href: "/projects", key: "projects" },
  { href: "/lab", key: "lab" },
] as const;

export async function Header({ locale }: { locale: Locale }) {
  const t = await getTranslations({ locale, namespace: "nav" });

  return (
    <header className="sticky top-0 z-20 border-b border-[color:var(--color-border)]/60 bg-[color:var(--color-bg)]/80 backdrop-blur-md">
      <Container size="wide" className="flex items-center justify-between py-4">
        <Link
          href="/"
          className="font-mono text-sm font-semibold text-[color:var(--color-fg)] no-underline hover:no-underline"
        >
          lucasalbini<span className="text-[color:var(--color-muted)]">.com</span>
        </Link>
        <nav className="hidden gap-7 text-sm text-[color:var(--color-muted)] sm:flex">
          {NAV.map((item) => (
            <Link
              key={item.key}
              href={item.href}
              className="no-underline transition-colors hover:text-[color:var(--color-fg)] hover:no-underline"
            >
              {t(item.key)}
            </Link>
          ))}
        </nav>
        <div className="flex items-center gap-3">
          <LocaleSwitcher />
          <ThemeToggle />
        </div>
      </Container>
    </header>
  );
}
