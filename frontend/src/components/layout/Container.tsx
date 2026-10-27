import clsx from "clsx";

/**
 * Container widths (tuned for the new denser hub layout):
 *  - reading  → 46rem (long-form posts: ~70ch at the 20px desktop body size)
 *  - default  → 3xl   (narrow single-column sections)
 *  - wide     → 6xl   (grids on /blog, /projects, /publications)
 *  - full     → 7xl   (home hero, side-by-side layouts)
 */
export function Container({
  children,
  className,
  as: Tag = "div",
  size = "default",
}: {
  children: React.ReactNode;
  className?: string;
  as?: keyof React.JSX.IntrinsicElements;
  size?: "default" | "reading" | "wide" | "full";
}) {
  const sizeClass =
    size === "reading"
      ? "max-w-[46rem]"
      : size === "wide"
      ? "max-w-6xl"
      : size === "full"
      ? "max-w-7xl"
      : "max-w-3xl";
  const El = Tag as React.ElementType;
  return (
    <El className={clsx("mx-auto w-full px-5 sm:px-6", sizeClass, className)}>{children}</El>
  );
}
