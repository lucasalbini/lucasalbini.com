import { getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";

/**
 * Sits at the top of a post/project page when the user landed on the fallback
 * locale (the requested translation doesn't exist). Encourages using browser
 * translation rather than hiding the content.
 */
export async function TranslationNotice({ locale }: { locale: Locale }) {
  const t = await getTranslations({ locale, namespace: "blog" });
  return (
    <div className="mb-6 rounded border border-[color:var(--color-border)] bg-[color:color-mix(in_oklab,var(--color-accent)_6%,transparent)] p-3 text-sm text-[color:var(--color-fg)]">
      {t("translation_only")}{" "}
      <span className="text-[color:var(--color-muted)]">{t("translation_action")}</span>
    </div>
  );
}
