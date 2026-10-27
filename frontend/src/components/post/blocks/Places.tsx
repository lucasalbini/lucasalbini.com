import { useTranslations } from "next-intl";
import type { PlacesBlock } from "@/lib/types";
import { mapsUrl } from "@/lib/embeds";
import { PlacesMap } from "./PlacesMap";

export function Places({ block }: { block: PlacesBlock }) {
  const t = useTranslations("places");
  return (
    <section className="bleed-wide my-10">
      {block.title && <h2 className="label-mono mb-4">{block.title}</h2>}
      <div className="h-72 overflow-hidden rounded bg-[color:var(--color-surface)] sm:h-96">
        <PlacesMap places={block.places} />
      </div>
      <ol className="!mt-6 grid !list-none gap-x-8 gap-y-5 !p-0 sm:grid-cols-2">
        {block.places.map((place, i) => (
          <li key={place.document_id} className="flex gap-3">
            <span className="font-mono text-xs leading-6 text-[color:var(--color-accent)]">{i + 1}</span>
            <div className="min-w-0">
              <p className="font-semibold text-[color:var(--color-fg)]">{place.name}</p>
              <p className="font-mono text-[11px] uppercase tracking-wider text-[color:var(--color-muted)]">
                {t(`kind.${place.kind}`)}
                {place.city ? ` · ${place.city}` : ""}
              </p>
              {place.note && <p className="mt-1 text-sm text-[color:var(--color-muted)]">{place.note}</p>}
              <p className="mt-1 flex gap-4 text-sm">
                <a href={mapsUrl(place.latitude, place.longitude)} target="_blank" rel="noopener noreferrer">
                  {t("directions")}
                </a>
                {place.url && (
                  <a href={place.url} target="_blank" rel="noopener noreferrer">
                    {t("website")}
                  </a>
                )}
              </p>
            </div>
          </li>
        ))}
      </ol>
    </section>
  );
}
