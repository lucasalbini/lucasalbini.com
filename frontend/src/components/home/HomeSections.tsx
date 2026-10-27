import Image from "next/image";
import { useTranslations } from "next-intl";
import { Link } from "@/lib/i18n/routing";
import type { Collection, YoutubeVideo } from "@/lib/types";
import { formatShortDate, mediaUrl } from "@/lib/format";
import { SectionHeading } from "@/components/ui/SectionHeading";

/** "Agora": a few lines about what Lucas is living right now, edited in the profile. */
export function NowSection({ text }: { text: string | null }) {
  const t = useTranslations("home");
  if (!text) return null;
  return (
    <section className="pb-16 sm:pb-20">
      <SectionHeading title={t("now")} />
      <p className="max-w-[60ch] whitespace-pre-line text-lg leading-relaxed text-[color:var(--color-fg)]">{text}</p>
    </section>
  );
}

/** Latest videos from the channel's RSS. Hidden when the feed is empty or unconfigured. */
export function VideoGrid({ videos, channelUrl }: { videos: YoutubeVideo[]; channelUrl: string | null }) {
  const t = useTranslations("home");
  if (videos.length === 0) return null;
  return (
    <section className="pb-20 sm:pb-24">
      <div className="mb-8 flex items-center gap-4">
        <h2 className="label-mono shrink-0">{t("videos")}</h2>
        <span className="rule flex-1" aria-hidden />
        {channelUrl && (
          <a
            href={channelUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="shrink-0 font-mono text-[11px] uppercase tracking-[0.12em] no-underline hover:underline"
          >
            {t("videos_all")} →
          </a>
        )}
      </div>
      <ul className="grid gap-8 sm:grid-cols-2 lg:grid-cols-3">
        {videos.map((v) => (
          <li key={v.video_id}>
            <a href={v.url} target="_blank" rel="noopener noreferrer" className="group block no-underline">
              <div className="relative aspect-video overflow-hidden rounded-lg bg-[color:var(--color-surface)]">
                {v.thumbnail_url && (
                  <Image src={v.thumbnail_url} alt="" fill unoptimized sizes="(max-width: 640px) 100vw, 33vw" className="object-cover" />
                )}
              </div>
              <p className="mt-3 font-semibold leading-snug text-[color:var(--color-fg)] group-hover:text-[color:var(--color-accent)]">
                {v.title}
              </p>
              <time dateTime={v.published_at} className="font-mono text-[11px] text-[color:var(--color-muted)]">
                {formatShortDate(v.published_at, "pt")}
              </time>
            </a>
          </li>
        ))}
      </ul>
    </section>
  );
}

export function CollectionsList({ collections }: { collections: Collection[] }) {
  const t = useTranslations("home");
  if (collections.length === 0) return null;
  return (
    <section className="pb-20 sm:pb-24">
      <SectionHeading title={t("collections")} />
      <ul className="grid gap-8 sm:grid-cols-2 lg:grid-cols-3">
        {collections.map((c) => (
          <li key={c.document_id}>
            <Link
              href={{ pathname: "/collections/[slug]", params: { slug: c.slug } }}
              className="group block no-underline"
            >
              {c.cover?.url && (
                <div className="relative mb-3 aspect-[3/2] overflow-hidden rounded-lg bg-[color:var(--color-surface)]">
                  <Image src={mediaUrl(c.cover.url)} alt="" fill unoptimized sizes="(max-width: 640px) 100vw, 33vw" className="object-cover" />
                </div>
              )}
              <p className="font-semibold text-[color:var(--color-fg)] group-hover:text-[color:var(--color-accent)]">{c.title}</p>
              {c.description && <p className="mt-1 text-sm text-[color:var(--color-muted)]">{c.description}</p>}
            </Link>
          </li>
        ))}
      </ul>
    </section>
  );
}
