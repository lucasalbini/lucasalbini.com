import { getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";

/**
 * Small "Only in English" / "Disponível apenas em inglês" badge, used when a
 * post or project card is shown in a locale where the translation doesn't exist.
 */
export async function LanguageBadge({
  currentLocale,
  contentLocale,
}: {
  currentLocale: Locale;
  contentLocale: "pt" | "en";
}) {
  const t = await getTranslations({ locale: currentLocale, namespace: "locale" });
  const label = contentLocale === "pt" ? t("badge_only_pt") : t("badge_only_en");
  return (
    <span className="inline-block rounded border border-[color:var(--color-border)] px-1.5 py-0.5 text-[10px] uppercase tracking-wide text-[color:var(--color-muted)]">
      {label}
    </span>
  );
}
