import Image from "next/image";
import { Link } from "@/lib/i18n/routing";
import { getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import type { Project } from "@/lib/types";
import { mediaUrl } from "@/lib/format";

/**
 * The spec: "Todo card de projeto tem imagem. Projetos sem visual recebem card
 * gerado com tipografia grande sobre fundo sólido." We honor that by falling
 * back to a title-only card when `cover` is null.
 */
export async function ProjectCard({ project, locale }: { project: Project; locale: Locale }) {
  const tKind = await getTranslations({ locale, namespace: "projects.kind" });
  const hasCover = !!project.cover?.url;

  return (
    <Link
      href={{ pathname: "/projects/[slug]", params: { slug: project.slug } }}
      className="group block overflow-hidden rounded border border-[color:var(--color-border)] no-underline transition-colors hover:border-[color:var(--color-accent)]"
    >
      <div className="relative aspect-[16/10] w-full overflow-hidden bg-[color:color-mix(in_oklab,var(--color-fg)_6%,transparent)]">
        {hasCover ? (
          <Image
            src={mediaUrl(project.cover!.url)}
            alt={project.cover!.alternative_text ?? project.title}
            fill
            unoptimized
            className="object-cover"
            sizes="(max-width: 768px) 100vw, 33vw"
          />
        ) : (
          <div className="flex h-full items-center justify-center p-6 text-center">
            <span className="font-mono text-2xl font-bold leading-tight text-[color:var(--color-fg)]">
              {project.title}
            </span>
          </div>
        )}
      </div>
      <div className="p-4">
        <h3 className="font-semibold text-[color:var(--color-fg)] group-hover:text-[color:var(--color-accent)]">
          {project.title}
        </h3>
        <p className="mt-1 line-clamp-2 text-sm text-[color:var(--color-muted)]">{project.summary}</p>
        <div className="mt-2 flex items-center gap-2 font-mono text-xs text-[color:var(--color-muted)]">
          <span>{tKind(project.kind)}</span>
          {project.year && <span>· {project.year}</span>}
        </div>
      </div>
    </Link>
  );
}
