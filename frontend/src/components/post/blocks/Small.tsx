import { useTranslations } from "next-intl";
import clsx from "clsx";
import { FaArrowDown, FaArrowUpRightFromSquare } from "react-icons/fa6";
import type { CalloutBlock, DownloadBlock, LinkBlock } from "@/lib/types";
import { mediaUrl } from "@/lib/format";
import { fileInfo } from "@/lib/embeds";

function hostname(url: string): string {
  try {
    return new URL(url).hostname.replace(/^www\./, "");
  } catch {
    return url;
  }
}

/** Download and link blocks share one shape: a quiet row, no box, accent on hover. */
function ActionRow({ href, icon, title, detail, description, download }: {
  href: string;
  icon: React.ReactNode;
  title: string;
  detail: string;
  description: string | null;
  download?: boolean;
}) {
  return (
    <a
      href={href}
      {...(download ? { download: "" } : { target: "_blank", rel: "noopener noreferrer" })}
      className="group my-6 flex items-start gap-4 border-y border-[color:var(--color-border)] py-4 no-underline hover:no-underline"
    >
      <span className="mt-1 text-[color:var(--color-accent)]" aria-hidden>{icon}</span>
      <span className="min-w-0">
        <span className="block font-semibold text-[color:var(--color-fg)] group-hover:text-[color:var(--color-accent)]">{title}</span>
        {description && <span className="block text-sm text-[color:var(--color-muted)]">{description}</span>}
        <span className="mt-1 block font-mono text-[11px] text-[color:var(--color-muted)]">{detail}</span>
      </span>
    </a>
  );
}

export function Download({ block }: { block: DownloadBlock }) {
  const t = useTranslations("post");
  const info = fileInfo(block.file.ext, block.file.size);
  return (
    <ActionRow
      href={mediaUrl(block.file.url)}
      icon={<FaArrowDown />}
      title={block.label}
      description={block.description}
      detail={info ? `${t("download")} · ${info}` : t("download")}
      download
    />
  );
}

export function LinkCard({ block }: { block: LinkBlock }) {
  return (
    <ActionRow
      href={block.url}
      icon={<FaArrowUpRightFromSquare />}
      title={block.title}
      description={block.description}
      detail={hostname(block.url)}
    />
  );
}

export function Callout({ block }: { block: CalloutBlock }) {
  const t = useTranslations("post.callout");
  return (
    <aside
      className={clsx(
        "my-8 border-l-2 pl-4",
        block.tone === "warning" ? "border-[color:var(--color-accent)]" : "border-[color:var(--color-primary)]",
      )}
    >
      <p className="label-mono mb-1">{t(block.tone)}</p>
      <p className="m-0 text-[color:var(--color-fg)]">{block.body}</p>
    </aside>
  );
}
