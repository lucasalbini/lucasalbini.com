"use client";

import { useTranslations, useLocale } from "next-intl";
import { usePathname, useRouter } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import { useEffect, useState, useTransition } from "react";
import clsx from "clsx";

/**
 * Renders "PT / EN" in small text. Clicking swaps to the equivalent path in
 * the other locale.
 *
 * For dynamic content (blog/[slug], projects/[slug]) the SERVER-rendered page
 * embeds a <script id="__locale_alternates__" type="application/json"> with the
 * translated slugs per locale. We read that on mount and, on click, rewrite
 * the URL's last segment with the correct slug. When the alternate slug is
 * missing, the corresponding button is disabled with a tooltip.
 */
export function LocaleSwitcher() {
  const t = useTranslations("locale");
  const active = useLocale() as Locale;
  const pathname = usePathname();
  const router = useRouter();
  const [pending, start] = useTransition();
  const [alternates, setAlternates] = useState<Record<string, string> | null>(null);

  useEffect(() => {
    const el = document.getElementById("__locale_alternates__");
    if (!el) {
      setAlternates(null);
      return;
    }
    try {
      setAlternates(JSON.parse(el.textContent || "{}"));
    } catch {
      setAlternates(null);
    }
  }, [pathname]);

  function handle(target: Locale) {
    if (target === active) return;
    const alternateSlug = alternates?.[target];
    start(() => {
      if (alternateSlug) {
        const parts = pathname.split("/").filter(Boolean);
        parts[parts.length - 1] = alternateSlug;
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        router.replace(("/" + parts.join("/")) as any, { locale: target });
      } else {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        router.replace(pathname as any, { locale: target });
      }
    });
  }

  const Item = ({ target }: { target: Locale }) => {
    const label = target.toUpperCase();
    const isActive = active === target;
    const missing = alternates !== null && !alternates[target];
    const disabled = missing || pending;
    return (
      <button
        type="button"
        aria-label={target === "pt" ? t("switch_to_pt") : t("switch_to_en")}
        title={missing ? t("not_available", { locale: label }) : undefined}
        onClick={() => !disabled && handle(target)}
        disabled={disabled}
        className={clsx(
          "text-xs uppercase tracking-wide",
          isActive
            ? "font-semibold text-[color:var(--color-fg)]"
            : "text-[color:var(--color-muted)] hover:text-[color:var(--color-fg)]",
          disabled && !isActive && "cursor-not-allowed opacity-40 hover:text-[color:var(--color-muted)]",
        )}
      >
        {label}
      </button>
    );
  };

  return (
    <div className="flex items-center gap-1">
      <Item target="pt" />
      <span className="text-xs text-[color:var(--color-muted)]">/</span>
      <Item target="en" />
    </div>
  );
}
