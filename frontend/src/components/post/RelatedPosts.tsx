import { getTranslations } from "next-intl/server";
import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import type { Post } from "@/lib/types";
import { formatShortDate } from "@/lib/format";

/**
 * Naive related-posts selection: same tags, then falls back to recency.
 * The spec calls for prioritizing the current locale, which is already true
 * because the API always filters by locale. We'll swap this for pgvector
 * similarity once embeddings are wired up.
 */
export async function RelatedPosts({
  current,
  candidates,
  locale,
}: {
  current: Post;
  candidates: Post[];
  locale: Locale;
}) {
  const t = await getTranslations({ locale, namespace: "blog" });
  const sharedTagSlugs = new Set(current.tags.map((t) => t.slug));

  const scored = candidates
    .filter((p) => p.document_id !== current.document_id)
    .map((p) => {
      const shared = p.tags.filter((t) => sharedTagSlugs.has(t.slug)).length;
      return { p, shared };
    })
    .sort((a, b) => (b.shared - a.shared) || (b.p.published_at ?? "").localeCompare(a.p.published_at ?? ""))
    .slice(0, 3);

  if (scored.length === 0) return null;

  return (
    <section className="mt-16 border-t border-[color:var(--color-border)] pt-8">
      <h2 className="mb-4 text-sm font-semibold uppercase tracking-widest text-[color:var(--color-muted)]">
        {t("related")}
      </h2>
      <ul className="space-y-3">
        {scored.map(({ p }) => (
          <li key={p.document_id} className="flex items-baseline justify-between gap-4">
            <Link
              href={{ pathname: "/blog/[slug]", params: { slug: p.slug } }}
              className="truncate text-[color:var(--color-fg)] no-underline hover:text-[color:var(--color-accent)]"
            >
              {p.title}
            </Link>
            <time className="shrink-0 font-mono text-xs text-[color:var(--color-muted)]">
              {formatShortDate(p.published_at, locale)}
            </time>
          </li>
        ))}
      </ul>
    </section>
  );
}
