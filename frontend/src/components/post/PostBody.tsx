import Image from "next/image";
import type { Block, BlockChild } from "@/lib/types";
import { mediaUrl } from "@/lib/format";

/**
 * Minimal renderer for Strapi v5 block editor output. We don't depend on
 * `@strapi/blocks-react-renderer` because our surface area is small and we
 * want zero extra deps. Add block types here as they show up in content.
 */
export function PostBody({ blocks }: { blocks: Block[] }) {
  return (
    <>
      {blocks.map((block, i) => (
        <BlockRenderer key={i} block={block} />
      ))}
    </>
  );
}

function BlockRenderer({ block }: { block: Block }) {
  switch (block.type) {
    case "paragraph":
      return (
        <p>
          {(block.children ?? []).map((c, i) => (
            <InlineChild key={i} child={c} />
          ))}
        </p>
      );
    case "heading": {
      const level = Math.min(Math.max(block.level ?? 2, 2), 4);
      const children = (block.children ?? []).map((c, i) => <InlineChild key={i} child={c} />);
      if (level === 2) return <h2>{children}</h2>;
      if (level === 3) return <h3>{children}</h3>;
      return <h4>{children}</h4>;
    }
    case "list": {
      const items = (block.children ?? []).map((item, i) => {
        // Each list-item has its own children of inline nodes.
        const inline = ((item as unknown as { children?: BlockChild[] }).children ?? []) as BlockChild[];
        return (
          <li key={i}>
            {inline.map((c, j) => (
              <InlineChild key={j} child={c} />
            ))}
          </li>
        );
      });
      return block.format === "ordered" ? <ol>{items}</ol> : <ul>{items}</ul>;
    }
    case "quote":
      return (
        <blockquote>
          {(block.children ?? []).map((c, i) => (
            <InlineChild key={i} child={c} />
          ))}
        </blockquote>
      );
    case "code": {
      const text = (block.children ?? [])
        .map((c) => (c.type === "text" ? c.text : ""))
        .join("");
      return (
        <pre>
          <code>{text}</code>
        </pre>
      );
    }
    case "image": {
      const img = block.image;
      if (!img) return null;
      return (
        <div className="my-6">
          <Image
            src={mediaUrl(img.url)}
            alt={img.alternative_text ?? ""}
            width={img.width ?? 1200}
            height={img.height ?? 800}
            unoptimized
            className="rounded"
          />
        </div>
      );
    }
    default:
      return null;
  }
}

function InlineChild({ child }: { child: BlockChild }) {
  if (child.type === "link") {
    return (
      <a href={child.url}>
        {child.children.map((c, i) => (
          <InlineChild key={i} child={c} />
        ))}
      </a>
    );
  }
  let node: React.ReactNode = child.text;
  if (child.code) node = <code>{node}</code>;
  if (child.bold) node = <strong>{node}</strong>;
  if (child.italic) node = <em>{node}</em>;
  if (child.underline) node = <u>{node}</u>;
  if (child.strikethrough) node = <s>{node}</s>;
  return <>{node}</>;
}
