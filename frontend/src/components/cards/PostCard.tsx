import Image from "next/image";
import { useTranslations } from "next-intl";
import { Link } from "@/lib/i18n/routing";
import type { PostSummary } from "@/lib/types";
import { formatShortDate, mediaUrl } from "@/lib/format";

/** Cover with a subtle tint fallback when the post has no image. Shared by both
 *  card shapes so a missing cover never leaves a raw empty block. */
function Cover({ post, aspect, sizes }: { post: PostSummary; aspect: string; sizes: string }) {
  return (
    <div
      className={`relative w-full overflow-hidden rounded-lg bg-[color:var(--color-surface)] ${aspect}`}
    >
      {post.cover?.url ? (
        <Image
          src={mediaUrl(post.cover.url)}
          alt={post.cover.alternativeText ?? post.title}
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

/** Category · date, the line every card shares. */
function Meta({ post }: { post: PostSummary }) {
  const t = useTranslations("categories");
  return (
    <p className="flex items-center gap-2 font-mono text-[11px] text-[color:var(--color-muted)]">
      <span>{t(post.category)}</span>
      {post.date && (
        <>
          <span aria-hidden>·</span>
          <time dateTime={post.date}>{formatShortDate(post.date, "pt")}</time>
        </>
      )}
    </p>
  );
}

const postHref = (post: PostSummary) => ({ pathname: "/[slug]" as const, params: { slug: post.slug } });

/** Compact list row (title left, date right). */
export function PostRow({ post }: { post: PostSummary }) {
  return (
    <li>
      <Link href={postHref(post)} className="group flex items-baseline justify-between gap-6 py-3.5 no-underline">
        <span className="min-w-0 text-[color:var(--color-fg)] transition-colors group-hover:text-[color:var(--color-accent)]">
          {post.title}
        </span>
        <time dateTime={post.date ?? undefined} className="shrink-0 font-mono text-xs text-[color:var(--color-muted)]">
          {formatShortDate(post.date, "pt")}
        </time>
      </Link>
    </li>
  );
}

/** Horizontal hero card for the single most important post on a page. */
export function FeaturedPostCard({ post }: { post: PostSummary }) {
  return (
    <Link
      href={postHref(post)}
      className="group grid gap-6 no-underline md:grid-cols-[minmax(0,340px)_1fr] md:items-center md:gap-8"
    >
      <Cover post={post} aspect="aspect-[4/3]" sizes="(max-width: 768px) 100vw, 340px" />
      <div>
        <Meta post={post} />
        <h3 className="mt-3 text-2xl font-semibold leading-tight text-[color:var(--color-fg)] transition-colors group-hover:text-[color:var(--color-accent)] sm:text-3xl">
          {post.title}
        </h3>
        <p className="mt-3 max-w-[58ch] leading-relaxed text-[color:var(--color-muted)]">{post.summary}</p>
      </div>
    </Link>
  );
}

/** Vertical card for grids. No border, no shadow — the cover and the whitespace
 *  do the separating. */
export function PostCard({ post }: { post: PostSummary }) {
  return (
    <Link href={postHref(post)} className="group flex h-full flex-col no-underline">
      <Cover post={post} aspect="aspect-[16/9]" sizes="(max-width: 768px) 100vw, 45vw" />
      <div className="flex flex-1 flex-col pt-4">
        <Meta post={post} />
        <h3 className="mt-2 text-lg font-semibold leading-snug text-[color:var(--color-fg)] transition-colors group-hover:text-[color:var(--color-accent)]">
          {post.title}
        </h3>
        <p className="mt-2 flex-1 text-sm leading-relaxed text-[color:var(--color-muted)]">{post.summary}</p>
      </div>
    </Link>
  );
}
