import Image from "next/image";
import type { GalleryBlock } from "@/lib/types";
import { mediaUrl } from "@/lib/format";

/** Square-cropped grid; each photo links to the full image. */
export function Gallery({ block }: { block: GalleryBlock }) {
  const columns = block.images.length === 2 || block.images.length === 4 ? "sm:grid-cols-2" : "sm:grid-cols-3";
  return (
    <figure className="my-10">
      <ul className={`!m-0 grid !list-none grid-cols-2 gap-2 !p-0 ${columns}`}>
        {block.images.map((img) => (
          <li key={img.url} className="relative aspect-square overflow-hidden rounded bg-[color:var(--color-surface)]">
            <a href={mediaUrl(img.url)} target="_blank" rel="noopener noreferrer">
              <Image
                src={mediaUrl(img.url)}
                alt={img.alternativeText ?? block.caption ?? ""}
                fill
                unoptimized
                sizes="(max-width: 640px) 50vw, 33vw"
                className="object-cover"
              />
            </a>
          </li>
        ))}
      </ul>
      {block.caption && (
        <figcaption className="mt-2 font-mono text-xs text-[color:var(--color-muted)]">{block.caption}</figcaption>
      )}
    </figure>
  );
}
