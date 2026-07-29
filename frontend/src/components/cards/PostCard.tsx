import Image from "next/image";
import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import type { Post } from "@/lib/types";
import { formatShortDate, mediaUrl } from "@/lib/format";
import clsx from "clsx";

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

/** Card with cover image. Two sizes:
 *  - compact: 16/10 cover, tight paddings, 2-line summary — for home/dense grids.
 *  - default: 16/9 cover, room for tags — for /blog listing. */
export function PostCard({
  post,
  locale,
  variant = "default",
}: {
  post: Post;
  locale: Locale;
  variant?: "default" | "compact";
}) {
  const hasCover = !!post.cover?.url;
  const compact = variant === "compact";
  return (
    <Link
      href={{ pathname: "/blog/[slug]", params: { slug: post.slug } }}
      className="group flex h-full flex-col overflow-hidden rounded-xl border border-[color:var(--color-border)] bg-[color:var(--color-bg)]/85 no-underline backdrop-blur-sm transition-all hover:-translate-y-0.5 hover:border-[color:var(--color-primary)] hover:shadow-md"
    >
      <div className={clsx("relative w-full overflow-hidden bg-[color:var(--color-surface)]", compact ? "aspect-[16/10]" : "aspect-[16/9]")}>
        {hasCover ? (
          <Image
            src={mediaUrl(post.cover!.url)}
            alt={post.cover!.alternative_text ?? post.title}
            fill
            unoptimized
            sizes="(max-width: 768px) 100vw, 25vw"
            className="object-cover transition-transform duration-500 group-hover:scale-105"
          />
        ) : (
          <div className="flex h-full items-center justify-center p-3 text-center">
            <span className="font-mono text-sm font-semibold leading-tight text-[color:var(--color-fg)]">{post.title}</span>
          </div>
        )}
      </div>
      <div className={clsx("flex flex-1 flex-col", compact ? "p-3" : "p-4")}>
        <h3
          className={clsx(
            "font-semibold leading-snug text-[color:var(--color-fg)] group-hover:text-[color:var(--color-accent)]",
            compact ? "text-sm line-clamp-2" : "text-base line-clamp-2",
          )}
        >
          {post.title}
        </h3>
        <p className={clsx("mt-1.5 flex-1 text-[color:var(--color-muted)]", compact ? "text-xs line-clamp-2" : "text-sm line-clamp-3")}>
          {post.summary}
        </p>
        <div className="mt-2.5 flex items-center gap-2 font-mono text-[11px] text-[color:var(--color-muted)]">
          <time dateTime={post.published_at ?? undefined}>{formatShortDate(post.published_at, locale)}</time>
          {post.reading_time_minutes && <span>· {post.reading_time_minutes} min</span>}
        </div>
        {!compact && post.tags.length > 0 && (
          <div className="mt-2.5 flex flex-wrap gap-1.5">
            {post.tags.slice(0, 3).map((t) => (
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
