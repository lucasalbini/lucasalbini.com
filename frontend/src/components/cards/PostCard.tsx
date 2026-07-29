import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import type { Post } from "@/lib/types";
import { formatShortDate } from "@/lib/format";

/**
 * Compact list format used on the home hub: title left, date right.
 * (Not a grid card — the spec asks for "formato lista".)
 */
export function PostRow({ post, locale }: { post: Post; locale: Locale }) {
  return (
    <li className="flex items-baseline justify-between gap-4 py-2">
      <Link
        href={{ pathname: "/blog/[slug]", params: { slug: post.slug } }}
        className="truncate text-[color:var(--color-fg)] no-underline hover:text-[color:var(--color-accent)]"
      >
        {post.title}
      </Link>
      <time
        dateTime={post.published_at ?? undefined}
        className="shrink-0 font-mono text-xs text-[color:var(--color-muted)]"
      >
        {formatShortDate(post.published_at, locale)}
      </time>
    </li>
  );
}

/** Fuller card used on /blog and tag pages. */
export function PostCard({ post, locale }: { post: Post; locale: Locale }) {
  return (
    <article className="border-b border-[color:var(--color-border)] py-6 first:pt-0 last:border-b-0">
      <Link
        href={{ pathname: "/blog/[slug]", params: { slug: post.slug } }}
        className="block no-underline"
      >
        <h3 className="text-lg font-semibold text-[color:var(--color-fg)] hover:text-[color:var(--color-accent)]">
          {post.title}
        </h3>
        <p className="mt-2 text-sm text-[color:var(--color-muted)]">{post.summary}</p>
        <div className="mt-3 flex items-center gap-3 font-mono text-xs text-[color:var(--color-muted)]">
          <time dateTime={post.published_at ?? undefined}>{formatShortDate(post.published_at, locale)}</time>
          {post.reading_time_minutes && <span>· {post.reading_time_minutes} min</span>}
          {post.tags.length > 0 && (
            <span className="truncate">· {post.tags.map((t) => t.label).join(", ")}</span>
          )}
        </div>
      </Link>
    </article>
  );
}
