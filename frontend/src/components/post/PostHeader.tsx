import { useTranslations } from "next-intl";
import { FaInstagram, FaYoutube } from "react-icons/fa6";
import { Link } from "@/lib/i18n/routing";
import type { Post } from "@/lib/types";
import { formatDate } from "@/lib/format";
import { categorySegment } from "@/lib/categories";

/** Category, title, date and the post's counterparts on the networks (ADR-0002 §3.1).
 *  On desktop the category line and the facts row move to PostMeta, beside the post. */
export function PostHeader({ post }: { post: Post }) {
  const t = useTranslations("post");
  const tCategories = useTranslations("categories");
  const social = [
    post.instagram_url && { href: post.instagram_url, icon: <FaInstagram aria-hidden />, label: t("view_on_instagram") },
    post.youtube_url && { href: post.youtube_url, icon: <FaYoutube aria-hidden />, label: t("watch_on_youtube") },
  ].filter((s): s is { href: string; icon: React.ReactElement; label: string } => Boolean(s));

  return (
    <header className="mb-10">
      <p className="label-mono lg:hidden">
        <Link
          href={{ pathname: "/archive/[category]", params: { category: categorySegment(post.category) } }}
          className="no-underline"
        >
          {tCategories(post.category)}
        </Link>
        {post.collection && (
          <>
            {" · "}
            <Link href={{ pathname: "/collections/[slug]", params: { slug: post.collection.slug } }} className="no-underline">
              {post.collection.title}
            </Link>
          </>
        )}
      </p>
      <h1 className="font-editorial mt-2 text-3xl font-semibold tracking-tight text-[color:var(--color-fg)] sm:text-4xl lg:mt-0 lg:text-5xl">{post.title}</h1>
      <p className="mt-4 text-lg text-[color:var(--color-muted)] lg:text-xl">{post.summary}</p>
      <div className="mt-4 flex flex-wrap items-center gap-x-5 gap-y-2 font-mono text-xs text-[color:var(--color-muted)] lg:hidden">
        {post.date && <time dateTime={post.date}>{formatDate(post.date, "pt")}</time>}
        {post.reading_time_minutes && <span>{t("reading_time", { minutes: post.reading_time_minutes })}</span>}
        {social.map((s) => (
          <a key={s.href} href={s.href} target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-1.5">
            {s.icon}
            {s.label}
          </a>
        ))}
      </div>
    </header>
  );
}
