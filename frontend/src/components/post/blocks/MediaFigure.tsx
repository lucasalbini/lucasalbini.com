import Image from "next/image";
import clsx from "clsx";
import type { Media } from "@/lib/types";
import { mediaUrl } from "@/lib/format";

/** One image with its caption, as wide as the text column. `full` runs edge to edge on phones. */
export function MediaFigure({
  media,
  caption,
  layout = "column",
  sizes = "(max-width: 768px) 100vw, 70ch",
}: {
  media: Media;
  caption?: string | null;
  layout?: "column" | "wide" | "full";
  sizes?: string;
}) {
  return (
    <figure className={clsx("my-8", layout === "full" && "bleed-full")}>
      <Image
        src={mediaUrl(media.url)}
        alt={media.alternativeText ?? caption ?? ""}
        width={media.width ?? 1600}
        height={media.height ?? 1067}
        sizes={sizes}
        unoptimized
        className={clsx("h-auto w-full rounded", layout === "full" && "max-lg:rounded-none")}
      />
      {caption && <figcaption className="mt-2 font-mono text-xs text-[color:var(--color-muted)]">{caption}</figcaption>}
    </figure>
  );
}
