import Script from "next/script";
import { useTranslations } from "next-intl";
import type { InstagramBlock, YoutubeBlock } from "@/lib/types";
import { instagramPermalink, youtubeEmbedUrl, youtubeId } from "@/lib/embeds";

function Caption({ text }: { text: string | null }) {
  return text ? <figcaption className="mt-2 font-mono text-xs text-[color:var(--color-muted)]">{text}</figcaption> : null;
}

export function YouTube({ block }: { block: YoutubeBlock }) {
  const t = useTranslations("post");
  const id = youtubeId(block.url);
  // An unrecognized URL still leaves the reader a way to the video.
  if (!id) {
    return (
      <p>
        <a href={block.url} target="_blank" rel="noopener noreferrer">{t("watch_on_youtube")}</a>
      </p>
    );
  }
  return (
    <figure className="bleed-wide my-10">
      <div className="relative aspect-video overflow-hidden rounded bg-black">
        <iframe
          src={youtubeEmbedUrl(id)}
          title={block.caption ?? t("youtube_video")}
          loading="lazy"
          allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
          allowFullScreen
          referrerPolicy="strict-origin-when-cross-origin"
          className="absolute inset-0 h-full w-full"
        />
      </div>
      <Caption text={block.caption} />
    </figure>
  );
}

/**
 * Official Instagram embed: a blockquote that embed.js upgrades into the post. Until
 * (or unless) the script runs, the blockquote is a plain link to the post.
 */
export function Instagram({ block }: { block: InstagramBlock }) {
  const t = useTranslations("post");
  const permalink = instagramPermalink(block.url) ?? block.url;
  return (
    <figure className="my-10 flex flex-col items-center">
      <blockquote
        className="instagram-media !m-0 w-full max-w-[540px] !border-0 !p-0 !not-italic"
        data-instgrm-permalink={permalink}
        data-instgrm-version="14"
      >
        <a href={permalink} target="_blank" rel="noopener noreferrer">{t("view_on_instagram")}</a>
      </blockquote>
      <Caption text={block.caption} />
      <Script src="https://www.instagram.com/embed.js" strategy="lazyOnload" />
    </figure>
  );
}
