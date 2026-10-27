// @vitest-environment happy-dom
import { act } from "react";
import { createRoot } from "react-dom/client";
import { describe, expect, it, vi } from "vitest";
import { PlacesMap } from "@/components/post/blocks/PlacesMap";
import type { Place } from "@/lib/types";

const leaflet = vi.hoisted(() => {
  const map = { setView: vi.fn(), fitBounds: vi.fn(), remove: vi.fn() };
  const layer = () => ({ addTo: vi.fn().mockReturnThis(), bindTooltip: vi.fn().mockReturnThis() });
  return {
    map,
    tooltips: [] as string[],
    module: {
      map: vi.fn(() => map),
      tileLayer: vi.fn(layer),
      circleMarker: vi.fn(() => {
        const l = layer();
        l.bindTooltip = vi.fn((text: string) => {
          leaflet.tooltips.push(text);
          return l;
        });
        return l;
      }),
      latLng: (lat: number, lng: number) => ({ lat, lng }),
      latLngBounds: (points: unknown[]) => ({ points }),
    },
  };
});
vi.mock("leaflet", () => ({ ...leaflet.module, default: leaflet.module }));
vi.mock("leaflet/dist/leaflet.css", () => ({}));

const place = (id: string, latitude: number): Place => ({
  document_id: id,
  name: `Lugar ${id}`,
  slug: id,
  kind: "other",
  latitude,
  longitude: -48.5,
  address: null,
  city: null,
  country: null,
  url: null,
  note: null,
  photo: null,
});

async function mount(places: Place[]) {
  const container = document.createElement("div");
  const root = createRoot(container);
  await act(async () => {
    root.render(<PlacesMap places={places} />);
  });
  // Leaflet is imported lazily inside the effect; let that promise settle.
  await act(async () => {
    await new Promise((r) => setTimeout(r, 0));
  });
  return root;
}

describe("PlacesMap", () => {
  it("frames several places and numbers their markers like the list", async () => {
    leaflet.tooltips.length = 0;
    await mount([place("a", -1.45), place("b", -1.44)]);

    expect(leaflet.map.fitBounds).toHaveBeenCalled();
    expect(leaflet.tooltips).toEqual(["1. Lugar a", "2. Lugar b"]);
  });

  it("zooms into a single place instead of fitting bounds", async () => {
    await mount([place("a", -1.45)]);

    expect(leaflet.map.setView).toHaveBeenCalledWith({ lat: -1.45, lng: -48.5 }, 15);
  });

  it("tears the map down when the block unmounts", async () => {
    const root = await mount([place("a", -1.45)]);
    leaflet.map.remove.mockClear();

    act(() => root.unmount());

    expect(leaflet.map.remove).toHaveBeenCalled();
  });
});
