import Image from "next/image";
import { Link } from "@/lib/i18n/routing";
import { getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import type { Project } from "@/lib/types";
import { mediaUrl } from "@/lib/format";
import clsx from "clsx";

const KIND_ACCENT: Record<string, string> = {
  game: "var(--color-accent)",
  ai: "var(--color-primary)",
  tool: "var(--color-primary-dark)",
  tutorial: "var(--color-accent-hover)",
};

export async function ProjectCard({
  project,
  locale,
  variant = "default",
}: {
  project: Project;
  locale: Locale;
  variant?: "default" | "compact";
}) {
  const tKind = await getTranslations({ locale, namespace: "projects.kind" });
  const tStatus = await getTranslations({ locale, namespace: "projects.status" });
  const hasCover = !!project.cover?.url;
  const kindColor = KIND_ACCENT[project.kind] ?? "var(--color-primary)";
  const compact = variant === "compact";

  return (
    <Link
      href={{ pathname: "/projects/[slug]", params: { slug: project.slug } }}
      className="group flex h-full flex-col overflow-hidden rounded-xl border border-[color:var(--color-border)] bg-[color:var(--color-bg)]/85 no-underline backdrop-blur-sm transition-all hover:-translate-y-0.5 hover:border-[color:var(--color-primary)] hover:shadow-md"
    >
      <div className={clsx("relative w-full overflow-hidden bg-[color:var(--color-surface)]", compact ? "aspect-[16/10]" : "aspect-[16/9]")}>
        {hasCover ? (
          <Image
            src={mediaUrl(project.cover!.url)}
            alt={project.cover!.alternative_text ?? project.title}
            fill
            unoptimized
            sizes="(max-width: 768px) 100vw, 33vw"
            className="object-cover transition-transform duration-500 group-hover:scale-105"
          />
        ) : (
          <div className="flex h-full items-center justify-center p-4 text-center">
            <span className="font-mono text-lg font-bold leading-tight text-[color:var(--color-fg)]">{project.title}</span>
          </div>
        )}
        <span
          className="absolute left-2.5 top-2.5 rounded-full px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wider text-white shadow"
          style={{ background: kindColor }}
        >
          {tKind(project.kind)}
        </span>
      </div>
      <div className={clsx("flex flex-1 flex-col", compact ? "p-3" : "p-4")}>
        <div className="flex items-baseline justify-between gap-2">
          <h3 className={clsx("font-semibold leading-snug text-[color:var(--color-fg)] group-hover:text-[color:var(--color-accent)]", compact ? "text-sm" : "text-base")}>
            {project.title}
          </h3>
          {project.year && (
            <span className="shrink-0 font-mono text-[11px] text-[color:var(--color-muted)]">{project.year}</span>
          )}
        </div>
        <p className={clsx("mt-1.5 flex-1 text-[color:var(--color-muted)]", compact ? "text-xs line-clamp-2" : "text-sm line-clamp-2")}>
          {project.summary}
        </p>
        <div className="mt-2 flex items-center gap-2 font-mono text-[11px] text-[color:var(--color-muted)]">
          <span
            className="inline-block h-1.5 w-1.5 rounded-full"
            style={{ background: project.status === "active" ? "var(--color-primary)" : "var(--color-muted)" }}
          />
          <span>{tStatus(project.status)}</span>
          {project.stack.length > 0 && (
            <span className="truncate">· {project.stack.slice(0, 3).map((s) => s.name).join(", ")}</span>
          )}
        </div>
      </div>
    </Link>
  );
}
