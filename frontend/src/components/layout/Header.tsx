import { getTranslations } from "next-intl/server";
import { Link } from "@/lib/i18n/routing";
import { ThemeToggle } from "./ThemeToggle";
import { Container } from "./Container";

const NAV = [
  { href: "/archive", key: "archive" },
  { href: { pathname: "/archive/[category]", params: { category: "viagens" } }, key: "travel" },
  { href: { pathname: "/archive/[category]", params: { category: "projetos" } }, key: "projects" },
  { href: "/about", key: "about" },
] as const;

export async function Header() {
  const t = await getTranslations("nav");

  return (
    <header className="sticky top-0 z-20 border-b border-[color:var(--color-border)]/60 bg-[color:var(--color-bg)]/80 backdrop-blur-md">
      <Container size="wide" className="flex flex-wrap items-center justify-between gap-x-4 gap-y-2 py-4">
        <Link
          href="/"
          className="font-mono text-sm font-semibold text-[color:var(--color-fg)] no-underline hover:no-underline"
        >
          lucasalbini<span className="text-[color:var(--color-muted)]">.com</span>
        </Link>
        {/* Second row on phones: four links plus the logo do not fit in 390px. */}
        <nav className="order-last flex w-full gap-5 text-sm text-[color:var(--color-muted)] sm:order-none sm:w-auto sm:gap-7">
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
        <ThemeToggle />
      </Container>
    </header>
  );
}
