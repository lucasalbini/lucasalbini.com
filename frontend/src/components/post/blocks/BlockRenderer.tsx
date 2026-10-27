import type { PostBlock } from "@/lib/types";
import { PostBody } from "@/components/post/PostBody";
import { MediaFigure } from "./MediaFigure";
import { Gallery } from "./Gallery";
import { Instagram, YouTube } from "./Embeds";
import { Places } from "./Places";
import { Callout, Download, LinkCard } from "./Small";

/** One renderer per block type. Unknown types render nothing (CLAUDE.md: a block added
 *  in Strapi must never take down existing pages). */
export function BlockRenderer({ block }: { block: PostBlock }) {
  switch (block.type) {
    case "text":
      return <PostBody blocks={block.body} />;
    case "image":
      return <MediaFigure media={block.image} caption={block.caption} layout={block.layout} />;
    case "gallery":
      return <Gallery block={block} />;
    case "youtube":
      return <YouTube block={block} />;
    case "instagram":
      return <Instagram block={block} />;
    case "places":
      return <Places block={block} />;
    case "download":
      return <Download block={block} />;
    case "link":
      return <LinkCard block={block} />;
    case "callout":
      return <Callout block={block} />;
    default:
      return null;
  }
}

export function PostBlocks({ blocks }: { blocks: PostBlock[] }) {
  return (
    <>
      {blocks.map((block, i) => (
        <BlockRenderer key={i} block={block} />
      ))}
    </>
  );
}
