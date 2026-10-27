/**
 * Small markdown -> Strapi v5 block-editor JSON converter.
 *
 * Not a full CommonMark implementation — it covers exactly the constructs used
 * in the legacy posts (h1-h4, paragraphs, unordered/ordered lists, fenced code,
 * blockquotes, inline **bold**, *italic*, `code`, [link](url)). Anything else
 * degrades to a plain paragraph.
 */

type Child =
  | { type: "text"; text: string; bold?: boolean; italic?: boolean; code?: boolean }
  | { type: "link"; url: string; children: Child[] };

type Block =
  | { type: "paragraph"; children: Child[] }
  | { type: "heading"; level: number; children: Child[] }
  | { type: "list"; format: "ordered" | "unordered"; children: { type: "list-item"; children: Child[] }[] }
  | { type: "code"; children: [{ type: "text"; text: string }]; language?: string }
  | { type: "quote"; children: Child[] };

const INLINE_LINK = /\[([^\]]+)\]\(([^)]+)\)/g;
const INLINE_BOLD = /\*\*([^*]+)\*\*/g;
const INLINE_ITALIC = /(?<!\*)\*([^*]+)\*(?!\*)/g;
const INLINE_CODE = /`([^`]+)`/g;

function parseInline(text: string): Child[] {
  if (!text) return [];
  // Very simple pass: extract [text](url) first, then apply bold/italic/code text-only on remaining segments.
  const out: Child[] = [];
  let cursor = 0;
  const links: Array<{ start: number; end: number; label: string; url: string }> = [];
  for (const m of text.matchAll(INLINE_LINK)) {
    links.push({ start: m.index!, end: m.index! + m[0].length, label: m[1], url: m[2] });
  }
  for (const l of links) {
    if (cursor < l.start) out.push(...formatText(text.slice(cursor, l.start)));
    out.push({ type: "link", url: l.url, children: formatText(l.label) });
    cursor = l.end;
  }
  if (cursor < text.length) out.push(...formatText(text.slice(cursor)));
  return out.length ? out : [{ type: "text", text }];
}

function formatText(chunk: string): Child[] {
  if (!chunk) return [];
  // Walk the string and split into runs based on markers. Simple approach:
  // collapse to a single text run with flags via placeholders.
  // For simplicity, we split by bold first, then italic, then inline code.
  const nodes: Child[] = [{ type: "text", text: chunk }];
  return applyPass(applyPass(applyPass(nodes, INLINE_BOLD, "bold"), INLINE_ITALIC, "italic"), INLINE_CODE, "code");
}

function applyPass(nodes: Child[], re: RegExp, flag: "bold" | "italic" | "code"): Child[] {
  const out: Child[] = [];
  for (const n of nodes) {
    if (n.type !== "text") { out.push(n); continue; }
    let last = 0;
    for (const m of n.text.matchAll(re)) {
      if (m.index! > last) out.push({ type: "text", text: n.text.slice(last, m.index) });
      out.push({ type: "text", text: m[1], [flag]: true });
      last = m.index! + m[0].length;
    }
    if (last < n.text.length) out.push({ type: "text", text: n.text.slice(last) });
  }
  return out;
}

export function markdownToBlocks(md: string): Block[] {
  if (!md) return [];
  const lines = md.replace(/\r\n/g, "\n").split("\n");
  const blocks: Block[] = [];
  let i = 0;
  while (i < lines.length) {
    const line = lines[i];

    // Fenced code
    if (line.startsWith("```")) {
      const language = line.slice(3).trim() || undefined;
      const buf: string[] = [];
      i++;
      while (i < lines.length && !lines[i].startsWith("```")) { buf.push(lines[i]); i++; }
      i++; // skip closing
      blocks.push({ type: "code", language, children: [{ type: "text", text: buf.join("\n") }] });
      continue;
    }

    // Heading
    const heading = /^(#{1,6})\s+(.*)$/.exec(line);
    if (heading) {
      blocks.push({ type: "heading", level: heading[1].length, children: parseInline(heading[2]) });
      i++;
      continue;
    }

    // Blockquote
    if (/^>\s+/.test(line)) {
      const buf: string[] = [];
      while (i < lines.length && /^>\s+/.test(lines[i])) { buf.push(lines[i].replace(/^>\s+/, "")); i++; }
      blocks.push({ type: "quote", children: parseInline(buf.join(" ")) });
      continue;
    }

    // Unordered list
    if (/^[-*+]\s+/.test(line)) {
      const items: { type: "list-item"; children: Child[] }[] = [];
      while (i < lines.length && /^[-*+]\s+/.test(lines[i])) {
        items.push({ type: "list-item", children: parseInline(lines[i].replace(/^[-*+]\s+/, "")) });
        i++;
      }
      blocks.push({ type: "list", format: "unordered", children: items });
      continue;
    }

    // Ordered list
    if (/^\d+\.\s+/.test(line)) {
      const items: { type: "list-item"; children: Child[] }[] = [];
      while (i < lines.length && /^\d+\.\s+/.test(lines[i])) {
        items.push({ type: "list-item", children: parseInline(lines[i].replace(/^\d+\.\s+/, "")) });
        i++;
      }
      blocks.push({ type: "list", format: "ordered", children: items });
      continue;
    }

    // Blank line → paragraph separator
    if (line.trim() === "") { i++; continue; }

    // Paragraph: keep reading until blank line
    const buf: string[] = [];
    while (i < lines.length && lines[i].trim() !== "" && !/^(#|>|```|[-*+]\s|\d+\.\s)/.test(lines[i])) {
      buf.push(lines[i]);
      i++;
    }
    blocks.push({ type: "paragraph", children: parseInline(buf.join(" ")) });
  }
  return blocks;
}

/** Extract the first paragraph as plain text, capped at maxLen chars. Used for `summary`. */
export function firstParagraphAsText(md: string, maxLen = 200): string {
  const blocks = markdownToBlocks(md);
  const first = blocks.find((b) => b.type === "paragraph") as Extract<Block, { type: "paragraph" }> | undefined;
  if (!first) return "";
  const text = first.children
    .flatMap((c) => (c.type === "text" ? c.text : c.children.map((cc) => (cc.type === "text" ? cc.text : ""))))
    .join("")
    .trim();
  if (text.length <= maxLen) return text;
  return text.slice(0, maxLen - 1).replace(/\s+\S*$/, "") + "…";
}
