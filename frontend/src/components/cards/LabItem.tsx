import type { Locale } from "@/lib/i18n/routing";
import type { Lab } from "@/lib/types";
import { formatShortDate } from "@/lib/format";
import { PostBody } from "@/components/post/PostBody";
import { LanguageBadge } from "@/components/ui/LanguageBadge";

/**
 * The lab has no per-item detail page — content lives inline in the list.
 * Deliberately minimal: date, title, body, optional external link. No cover.
 */
export function LabItem({ item, locale }: { item: Lab; locale: Locale }) {
  return (
    <article className="border-b border-[color:var(--color-border)] py-6 last:border-b-0">
      <header className="mb-2 flex items-center gap-3">
        <time dateTime={item.date} className="font-mono text-xs text-[color:var(--color-muted)]">
          {formatShortDate(item.date, locale)}
        </time>
        {item.language !== locale && (
          <LanguageBadge currentLocale={locale} contentLocale={item.language} />
        )}
      </header>
      <h3 className="text-lg font-semibold text-[color:var(--color-fg)]">{item.title}</h3>
      {item.body.length > 0 && (
        <div className="prose-reading mt-3 text-sm">
          <PostBody blocks={item.body} />
        </div>
      )}
      {item.external_link && (
        <a href={item.external_link} className="mt-3 inline-block font-mono text-xs">
          {item.external_link} ↗
        </a>
      )}
    </article>
  );
}

/**
 * Changelog-style row for the home: date pinned in a fixed mono column, title
 * and one-line excerpt to the right. Denser than LabItem, which renders the
 * whole note body.
 */
export function LabRow({ item, locale }: { item: Lab; locale: Locale }) {
  return (
    <li className="flex flex-col gap-1 py-3.5 sm:flex-row sm:gap-6">
      <time
        dateTime={item.date}
        className="shrink-0 font-mono text-xs leading-6 text-[color:var(--color-muted)] sm:w-24"
      >
        {formatShortDate(item.date, locale)}
      </time>
      <div className="min-w-0">
        <div className="flex flex-wrap items-center gap-2">
          <h3 className="font-medium leading-6 text-[color:var(--color-fg)]">{item.title}</h3>
          {item.language !== locale && (
            <LanguageBadge currentLocale={locale} contentLocale={item.language} />
          )}
        </div>
        {item.external_link && (
          <a href={item.external_link} className="mt-1 block truncate font-mono text-xs">
            {item.external_link} ↗
          </a>
        )}
      </div>
    </li>
  );
}
