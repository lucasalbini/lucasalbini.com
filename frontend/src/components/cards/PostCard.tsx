import Image from "next/image";
import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import type { Post } from "@/lib/types";
import { formatShortDate, mediaUrl } from "@/lib/format";

/** Cover with a subtle tint fallback when the post has no image. Shared by both
 *  card shapes so a missing cover never leaves a raw empty block. */
function Cover({ post, aspect, sizes }: { post: Post; aspect: string; sizes: string }) {
  return (
    <div
      className={`relative w-full overflow-hidden rounded-lg bg-[color:var(--color-surface)] ${aspect}`}
    >
      {post.cover?.url ? (
        <Image
          src={mediaUrl(post.cover.url)}
          alt={post.cover.alternative_text ?? post.title}
          fill
          unoptimized
          sizes={sizes}
          className="object-cover transition-transform duration-500 group-hover:scale-[1.03]"
        />
      ) : (
        <div className="flex h-full items-center justify-center p-4 text-center">
          <span className="font-mono text-sm leading-snug text-[color:var(--color-muted)]">
            {post.title}
          </span>
        </div>
      )}
    </div>
  );
}

function Meta({ post, locale }: { post: Post; locale: Locale }) {
  return (
    <div className="flex items-center gap-2 font-mono text-[11px] text-[color:var(--color-muted)]">
      <time dateTime={post.published_at ?? undefined}>{formatShortDate(post.published_at, locale)}</time>
      {post.reading_time_minutes && <span>· {post.reading_time_minutes} min</span>}
    </div>
  );
}

/** Compact list row (title left, date right). The home's secondary posts. */
export function PostRow({ post, locale }: { post: Post; locale: Locale }) {
  return (
    <li>
      <Link
        href={{ pathname: "/blog/[slug]", params: { slug: post.slug } }}
        className="group flex items-baseline justify-between gap-6 py-3.5 no-underline"
      >
        <span className="min-w-0 text-[color:var(--color-fg)] transition-colors group-hover:text-[color:var(--color-accent)]">
          {post.title}
        </span>
        <time
          dateTime={post.published_at ?? undefined}
          className="shrink-0 font-mono text-xs text-[color:var(--color-muted)]"
        >
          {formatShortDate(post.published_at, locale)}
        </time>
      </Link>
    </li>
  );
}

/** Horizontal hero card for the single most important post on a page. */
export function FeaturedPostCard({ post, locale }: { post: Post; locale: Locale }) {
  return (
    <Link
      href={{ pathname: "/blog/[slug]", params: { slug: post.slug } }}
      className="group grid gap-6 no-underline md:grid-cols-[minmax(0,340px)_1fr] md:items-center md:gap-8"
    >
      <Cover post={post} aspect="aspect-[4/3]" sizes="(max-width: 768px) 100vw, 340px" />
      <div>
        {post.tags.length > 0 && (
          <p className="label-mono mb-3">{post.tags[0].label}</p>
        )}
        <h3 className="text-2xl font-semibold leading-tight text-[color:var(--color-fg)] transition-colors group-hover:text-[color:var(--color-accent)] sm:text-3xl">
          {post.title}
        </h3>
        <p className="mt-3 max-w-[58ch] leading-relaxed text-[color:var(--color-muted)]">
          {post.summary}
        </p>
        <div className="mt-4">
          <Meta post={post} locale={locale} />
        </div>
      </div>
    </Link>
  );
}

/** Vertical card for grids. No border, no shadow — the cover and the whitespace
 *  do the separating. */
export function PostCard({ post, locale }: { post: Post; locale: Locale }) {
  return (
    <Link
      href={{ pathname: "/blog/[slug]", params: { slug: post.slug } }}
      className="group flex h-full flex-col no-underline"
    >
      <Cover post={post} aspect="aspect-[16/9]" sizes="(max-width: 768px) 100vw, 45vw" />
      <div className="flex flex-1 flex-col pt-4">
        <h3 className="text-lg font-semibold leading-snug text-[color:var(--color-fg)] transition-colors group-hover:text-[color:var(--color-accent)]">
          {post.title}
        </h3>
        <p className="mt-2 flex-1 text-sm leading-relaxed text-[color:var(--color-muted)]">
          {post.summary}
        </p>
        <div className="mt-3">
          <Meta post={post} locale={locale} />
        </div>
      </div>
    </Link>
  );
}
