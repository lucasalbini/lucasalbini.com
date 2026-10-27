import { useTranslations } from "next-intl";
import { Link } from "@/lib/i18n/routing";
import type { PostSummary } from "@/lib/types";
import { formatShortDate } from "@/lib/format";

/**
 * Same category first, then shared tags, then most recent. Swap for pgvector
 * similarity once embeddings are wired up.
 */
export function pickRelated(current: PostSummary, candidates: PostSummary[], limit = 3): PostSummary[] {
  const currentTags = new Set(current.tags.map((t) => t.slug));
  const score = (p: PostSummary) =>
    (p.category === current.category ? 10 : 0) + p.tags.filter((t) => currentTags.has(t.slug)).length;

  return candidates
    .filter((p) => p.document_id !== current.document_id)
    .map((p) => ({ p, s: score(p) }))
    .sort((a, b) => b.s - a.s || (b.p.date ?? "").localeCompare(a.p.date ?? ""))
    .slice(0, limit)
    .map(({ p }) => p);
}

export function RelatedPosts({ current, candidates }: { current: PostSummary; candidates: PostSummary[] }) {
  const t = useTranslations("post");
  const related = pickRelated(current, candidates);
  if (related.length === 0) return null;

  return (
    <section className="mt-16 border-t border-[color:var(--color-border)] pt-8">
      <h2 className="label-mono mb-4">{t("related")}</h2>
      <ul className="space-y-3">
        {related.map((p) => (
          <li key={p.document_id} className="flex items-baseline justify-between gap-4">
            <Link
              href={{ pathname: "/[slug]", params: { slug: p.slug } }}
              className="truncate text-[color:var(--color-fg)] no-underline hover:text-[color:var(--color-accent)]"
            >
              {p.title}
            </Link>
            <time className="shrink-0 font-mono text-xs text-[color:var(--color-muted)]">
              {formatShortDate(p.date, "pt")}
            </time>
          </li>
        ))}
      </ul>
    </section>
  );
}
