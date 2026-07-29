import Image from "next/image";
import { Link } from "@/lib/i18n/routing";
import { getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import type { Project } from "@/lib/types";
import { mediaUrl } from "@/lib/format";
import clsx from "clsx";

/**
 * Project card. `size="lg"` is the lead slot on the home grid (taller cover,
 * bigger title); `size="md"` is everything else.
 */
export async function ProjectCard({
  project,
  locale,
  size = "md",
}: {
  project: Project;
  locale: Locale;
  size?: "md" | "lg";
}) {
  const tKind = await getTranslations({ locale, namespace: "projects.kind" });
  const tStatus = await getTranslations({ locale, namespace: "projects.status" });
  const lg = size === "lg";

  return (
    <Link
      href={{ pathname: "/projects/[slug]", params: { slug: project.slug } }}
      className="group flex h-full flex-col no-underline"
    >
      <div
        className={clsx(
          "relative w-full overflow-hidden rounded-lg bg-[color:var(--color-surface)]",
          // The lead card runs full width, so it needs a panoramic crop —
          // 16/10 across 1100px would be a ~700px tall image.
          lg ? "aspect-[5/2]" : "aspect-[16/9]",
        )}
      >
        {project.cover?.url ? (
          <Image
            src={mediaUrl(project.cover.url)}
            alt={project.cover.alternative_text ?? project.title}
            fill
            unoptimized
            sizes={lg ? "100vw" : "(max-width: 640px) 100vw, 45vw"}
            className="object-cover transition-transform duration-500 group-hover:scale-[1.03]"
          />
        ) : (
          <div className="flex h-full items-center justify-center p-4 text-center">
            <span className="font-mono text-sm leading-snug text-[color:var(--color-muted)]">
              {project.title}
            </span>
          </div>
        )}
      </div>

      <div className="flex flex-1 flex-col pt-4">
        <div className="label-mono flex items-center gap-2">
          <span>{tKind(project.kind)}</span>
          <span aria-hidden>·</span>
          <span className="inline-flex items-center gap-1.5">
            <span
              className="inline-block h-1.5 w-1.5 rounded-full"
              style={{
                background:
                  project.status === "active" ? "var(--color-primary)" : "var(--color-muted)",
              }}
            />
            {tStatus(project.status)}
          </span>
          {project.year && (
            <>
              <span aria-hidden>·</span>
              <span>{project.year}</span>
            </>
          )}
        </div>

        <h3
          className={clsx(
            "mt-2 font-semibold leading-snug text-[color:var(--color-fg)] transition-colors group-hover:text-[color:var(--color-accent)]",
            lg ? "text-2xl" : "text-lg",
          )}
        >
          {project.title}
        </h3>

        <p
          className={clsx(
            "mt-2 flex-1 leading-relaxed text-[color:var(--color-muted)]",
            lg ? "max-w-[58ch] text-base" : "text-sm",
          )}
        >
          {project.summary}
        </p>

        {project.stack.length > 0 && (
          <p className="mt-3 truncate font-mono text-[11px] text-[color:var(--color-muted)]">
            {project.stack.slice(0, 4).map((s) => s.name).join(" · ")}
          </p>
        )}
      </div>
    </Link>
  );
}
