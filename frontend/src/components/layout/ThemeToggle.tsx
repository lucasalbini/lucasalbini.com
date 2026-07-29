"use client";

import { useEffect, useState } from "react";
import { useTheme } from "next-themes";
import { useTranslations } from "next-intl";
import { FaMoon, FaSun } from "react-icons/fa6";

export function ThemeToggle() {
  const { resolvedTheme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);
  const t = useTranslations("theme");

  useEffect(() => setMounted(true), []);

  const isDark = resolvedTheme === "dark";

  return (
    <button
      type="button"
      aria-label={t("toggle")}
      onClick={() => setTheme(isDark ? "light" : "dark")}
      className="flex h-8 w-8 items-center justify-center rounded-full text-sm text-[color:var(--color-muted)] transition-colors hover:bg-[color:var(--color-surface)] hover:text-[color:var(--color-fg)]"
    >
      {/* Placeholder keeps the button from resizing between SSR and hydration. */}
      {mounted ? isDark ? <FaSun aria-hidden /> : <FaMoon aria-hidden /> : <span className="block h-4 w-4" />}
    </button>
  );
}
