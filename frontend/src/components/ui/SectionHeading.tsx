import { Link } from "@/lib/i18n/routing";

interface Props {
  title: string;
  linkHref?: React.ComponentProps<typeof Link>["href"];
  linkLabel?: string;
}

export function SectionHeading({ title, linkHref, linkLabel }: Props) {
  return (
    <div className="mb-4 flex items-baseline justify-between">
      <h2 className="text-sm font-semibold uppercase tracking-widest text-[color:var(--color-muted)]">
        {title}
      </h2>
      {linkHref && linkLabel && (
        <Link href={linkHref} className="text-xs uppercase tracking-wide">
          {linkLabel} →
        </Link>
      )}
    </div>
  );
}
