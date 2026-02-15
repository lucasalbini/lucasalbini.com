interface SectionHeadingProps {
  title: string;
  subtitle?: string;
}

export function SectionHeading({ title, subtitle }: SectionHeadingProps) {
  return (
    <div className="mb-12 text-center">
      <h2 className="text-3xl font-bold tracking-tight sm:text-4xl">{title}</h2>
      {subtitle && <p className="mt-3 text-muted">{subtitle}</p>}
      <div className="mx-auto mt-4 h-1 w-20 rounded bg-primary" />
    </div>
  );
}
