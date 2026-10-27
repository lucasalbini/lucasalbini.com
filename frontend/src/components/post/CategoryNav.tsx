import { useTranslations } from "next-intl";
import clsx from "clsx";
import { Link } from "@/lib/i18n/routing";
import { CATEGORIES, categorySegment, type Category } from "@/lib/categories";

/** "Tudo · Viagens · Projetos · ..." on top of the archive. The active entry uses the accent color. */
export function CategoryNav({ active }: { active: Category | null }) {
  const t = useTranslations("categories_plural");
  const tArchive = useTranslations("archive");
  const item = (isActive: boolean) =>
    clsx(
      "no-underline hover:no-underline",
      isActive ? "text-[color:var(--color-accent)]" : "text-[color:var(--color-muted)] hover:text-[color:var(--color-fg)]",
    );

  return (
    <nav aria-label={tArchive("categories")} className="flex flex-wrap gap-x-5 gap-y-2 font-mono text-xs uppercase tracking-[0.12em]">
      <Link href="/archive" className={item(active === null)} aria-current={active === null ? "page" : undefined}>
        {tArchive("all")}
      </Link>
      {CATEGORIES.map((c) => (
        <Link
          key={c}
          href={{ pathname: "/archive/[category]", params: { category: categorySegment(c) } }}
          className={item(active === c)}
          aria-current={active === c ? "page" : undefined}
        >
          {t(c)}
        </Link>
      ))}
    </nav>
  );
}
