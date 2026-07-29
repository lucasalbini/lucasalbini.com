import { Link } from "@/lib/i18n/routing";

interface Props {
  title: string;
  linkHref?: React.ComponentProps<typeof Link>["href"];
  linkLabel?: string;
}

/** Mono label + hairline + optional "see all" link. The rule is what separates
 *  sections now that cards no longer carry borders. */
export function SectionHeading({ title, linkHref, linkLabel }: Props) {
  return (
    <div className="mb-8 flex items-center gap-4">
      <h2 className="label-mono shrink-0">{title}</h2>
      <span className="rule flex-1" aria-hidden />
      {linkHref && linkLabel && (
        <Link
          href={linkHref}
          className="shrink-0 font-mono text-[11px] uppercase tracking-[0.12em] no-underline hover:underline"
        >
          {linkLabel} →
        </Link>
      )}
    </div>
  );
}
