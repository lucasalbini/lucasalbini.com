import { useTranslations } from "next-intl";
import { FaInstagram, FaYoutube } from "react-icons/fa6";
import { Link } from "@/lib/i18n/routing";
import type { Post } from "@/lib/types";
import { formatDate } from "@/lib/format";
import { categorySegment } from "@/lib/categories";

function Row({ label, children }: { label: string; children: React.ReactNode }) {
  return (
    <div className="grid gap-1">
      <dt className="label-mono">{label}</dt>
      <dd className="m-0 text-sm text-[color:var(--color-fg)]">{children}</dd>
    </div>
  );
}

/**
 * Desktop-only column beside the post: everything about the post that isn't the story itself.
 * On phones the same facts sit under the title (PostHeader), so this column is hidden there.
 */
export function PostMeta({ post }: { post: Post }) {
  const t = useTranslations("post");
  const tMeta = useTranslations("post.meta");
  const tCategories = useTranslations("categories");

  return (
    <dl className="m-0 grid gap-6">
      <Row label={tMeta("category")}>
        <Link href={{ pathname: "/archive/[category]", params: { category: categorySegment(post.category) } }}>
          {tCategories(post.category)}
        </Link>
      </Row>
      {post.date && (
        <Row label={tMeta("date")}>
          <time dateTime={post.date}>{formatDate(post.date, "pt")}</time>
        </Row>
      )}
      {post.reading_time_minutes && <Row label={tMeta("reading")}>{t("reading_time", { minutes: post.reading_time_minutes })}</Row>}
      {post.collection && (
        <Row label={tMeta("collection")}>
          <Link href={{ pathname: "/collections/[slug]", params: { slug: post.collection.slug } }}>{post.collection.title}</Link>
        </Row>
      )}
      {(post.instagram_url || post.youtube_url) && (
        <Row label={tMeta("elsewhere")}>
          <span className="grid gap-1.5">
            {post.instagram_url && (
              <a href={post.instagram_url} target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-2">
                <FaInstagram aria-hidden /> Instagram
              </a>
            )}
            {post.youtube_url && (
              <a href={post.youtube_url} target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-2">
                <FaYoutube aria-hidden /> YouTube
              </a>
            )}
          </span>
        </Row>
      )}
      {post.tags.length > 0 && (
        <Row label={tMeta("tags")}>
          <span className="flex flex-wrap gap-x-3 gap-y-1">
            {post.tags.map((tag) => (
              <Link key={tag.slug} href={{ pathname: "/tags/[tag]", params: { tag: tag.slug } }}>
                #{tag.label}
              </Link>
            ))}
          </span>
        </Row>
      )}
    </dl>
  );
}
