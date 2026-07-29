import clsx from "clsx";

export function Container({
  children,
  className,
  as: Tag = "div",
  size = "default",
}: {
  children: React.ReactNode;
  className?: string;
  as?: keyof React.JSX.IntrinsicElements;
  size?: "default" | "reading" | "wide";
}) {
  const sizeClass =
    size === "reading" ? "max-w-[70ch]" : size === "wide" ? "max-w-5xl" : "max-w-3xl";
  const El = Tag as React.ElementType;
  return (
    <El className={clsx("mx-auto w-full px-5 sm:px-6", sizeClass, className)}>{children}</El>
  );
}
