import clsx from "clsx";

/**
 * Container widths. Every page, the header and the footer use `wide`, so all of them share
 * one left edge on desktop.
 *  - wide     → 5xl   (the site grid)
 *  - reading  → 46rem (short single-column pages, e.g. 404)
 *  - default  → 3xl
 *  - full     → 5xl   (alias of wide; kept so callers don't drift to another width)
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
      : size === "wide" || size === "full"
      ? "max-w-5xl"
      : "max-w-3xl";
  const El = Tag as React.ElementType;
  return (
    <El className={clsx("mx-auto w-full px-5 sm:px-6", sizeClass, className)}>{children}</El>
  );
}
