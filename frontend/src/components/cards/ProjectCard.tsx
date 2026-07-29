import Image from "next/image";
import { Link } from "@/lib/i18n/routing";
import { getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import type { Project } from "@/lib/types";
import { mediaUrl } from "@/lib/format";

const KIND_ACCENT: Record<string, string> = {
  game: "var(--color-accent)",
  ai: "var(--color-primary)",
  tool: "var(--color-primary-dark)",
  tutorial: "var(--color-accent-hover)",
};

export async function ProjectCard({ project, locale }: { project: Project; locale: Locale }) {
  const tKind = await getTranslations({ locale, namespace: "projects.kind" });
  const tStatus = await getTranslations({ locale, namespace: "projects.status" });
  const hasCover = !!project.cover?.url;
  const kindColor = KIND_ACCENT[project.kind] ?? "var(--color-primary)";

  return (
    <Link
      href={{ pathname: "/projects/[slug]", params: { slug: project.slug } }}
      className="group flex h-full flex-col overflow-hidden rounded-xl border border-[color:var(--color-border)] bg-[color:var(--color-surface)]/40 no-underline transition-all hover:-translate-y-0.5 hover:border-[color:var(--color-primary)] hover:shadow-md"
    >
      <div className="relative aspect-[16/10] w-full overflow-hidden bg-[color:var(--color-surface)]">
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
          <div className="flex h-full items-center justify-center p-6 text-center">
            <span className="font-mono text-2xl font-bold leading-tight text-[color:var(--color-fg)]">
              {project.title}
            </span>
          </div>
        )}
        <span
          className="absolute left-3 top-3 rounded-full px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wider text-white shadow"
          style={{ background: kindColor }}
        >
          {tKind(project.kind)}
        </span>
      </div>
      <div className="flex flex-1 flex-col p-5">
        <div className="flex items-baseline justify-between gap-2">
          <h3 className="text-lg font-semibold leading-tight text-[color:var(--color-fg)] group-hover:text-[color:var(--color-accent)]">
            {project.title}
          </h3>
          {project.year && (
            <span className="shrink-0 font-mono text-xs text-[color:var(--color-muted)]">{project.year}</span>
          )}
        </div>
        <p className="mt-2 line-clamp-2 flex-1 text-sm text-[color:var(--color-muted)]">{project.summary}</p>
        <div className="mt-4 flex items-center gap-2 font-mono text-xs text-[color:var(--color-muted)]">
          <span
            className="inline-block h-1.5 w-1.5 rounded-full"
            style={{ background: project.status === "active" ? "var(--color-primary)" : "var(--color-muted)" }}
          />
          <span>{tStatus(project.status)}</span>
          {project.stack.length > 0 && (
            <span className="truncate">· {project.stack.slice(0, 4).map((s) => s.name).join(", ")}</span>
          )}
        </div>
      </div>
    </Link>
  );
}
