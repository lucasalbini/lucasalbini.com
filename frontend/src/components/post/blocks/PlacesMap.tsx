"use client";

import { useEffect, useRef } from "react";
import "leaflet/dist/leaflet.css";
import type { Place } from "@/lib/types";

/**
 * Leaflet + OpenStreetMap tiles (ADR-0002 §4.7). Numbered circle markers match the list
 * next to the map and avoid Leaflet's default marker images, which bundlers break.
 * The effect only builds the map from props already on the page; no data is fetched here.
 */
export function PlacesMap({ places }: { places: Place[] }) {
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    let disposed = false;
    let map: import("leaflet").Map | undefined;

    import("leaflet").then((L) => {
      if (disposed || !ref.current) return;
      map = L.map(ref.current, { scrollWheelZoom: false });
      L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
        maxZoom: 19,
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
      }).addTo(map);

      const accent = getComputedStyle(ref.current).getPropertyValue("--color-accent").trim() || "#D4734A";
      const points = places.map((p, i) => {
        const latLng = L.latLng(p.latitude, p.longitude);
        L.circleMarker(latLng, { radius: 9, color: "#fff", weight: 2, fillColor: accent, fillOpacity: 1 })
          .bindTooltip(`${i + 1}. ${p.name}`)
          .addTo(map!);
        return latLng;
      });
      if (points.length === 1) map.setView(points[0], 15);
      else map.fitBounds(L.latLngBounds(points), { padding: [32, 32] });
    });

    return () => {
      disposed = true;
      map?.remove();
    };
  }, [places]);

  return <div ref={ref} className="h-full w-full" />;
}
