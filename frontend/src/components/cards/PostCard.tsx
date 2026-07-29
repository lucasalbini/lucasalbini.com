import Image from "next/image";
import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import type { Post } from "@/lib/types";
import { formatShortDate, mediaUrl } from "@/lib/format";

/** Compact list row (title left, date right). Used inside dense sections. */
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

/** Full card with cover image, used on /blog and the home "Writing" grid. */
export function PostCard({ post, locale }: { post: Post; locale: Locale }) {
  const hasCover = !!post.cover?.url;
  return (
    <Link
      href={{ pathname: "/blog/[slug]", params: { slug: post.slug } }}
      className="group flex h-full flex-col overflow-hidden rounded-xl border border-[color:var(--color-border)] bg-[color:var(--color-surface)]/40 no-underline transition-all hover:-translate-y-0.5 hover:border-[color:var(--color-primary)] hover:shadow-md"
    >
      <div className="relative aspect-[16/9] w-full overflow-hidden bg-[color:var(--color-surface)]">
        {hasCover ? (
          <Image
            src={mediaUrl(post.cover!.url)}
            alt={post.cover!.alternative_text ?? post.title}
            fill
            unoptimized
            sizes="(max-width: 768px) 100vw, 33vw"
            className="object-cover transition-transform duration-500 group-hover:scale-105"
          />
        ) : (
          <div className="flex h-full items-center justify-center p-4 text-center">
            <span className="font-mono text-lg font-semibold leading-tight text-[color:var(--color-fg)]">
              {post.title}
            </span>
          </div>
        )}
      </div>
      <div className="flex flex-1 flex-col p-5">
        <h3 className="text-lg font-semibold leading-tight text-[color:var(--color-fg)] group-hover:text-[color:var(--color-accent)]">
          {post.title}
        </h3>
        <p className="mt-2 line-clamp-3 flex-1 text-sm text-[color:var(--color-muted)]">
          {post.summary}
        </p>
        <div className="mt-4 flex items-center gap-3 font-mono text-xs text-[color:var(--color-muted)]">
          <time dateTime={post.published_at ?? undefined}>{formatShortDate(post.published_at, locale)}</time>
          {post.reading_time_minutes && <span>· {post.reading_time_minutes} min</span>}
        </div>
        {post.tags.length > 0 && (
          <div className="mt-3 flex flex-wrap gap-1.5">
            {post.tags.slice(0, 4).map((t) => (
              <span
                key={t.document_id}
                className="rounded-full border border-[color:var(--color-border)] px-2 py-0.5 text-[10px] font-medium uppercase tracking-wide text-[color:var(--color-muted)]"
              >
                {t.label}
              </span>
            ))}
          </div>
        )}
      </div>
    </Link>
  );
}
