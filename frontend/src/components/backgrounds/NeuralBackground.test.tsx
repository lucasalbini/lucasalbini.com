// @vitest-environment happy-dom
import { act } from "react";
import { createRoot } from "react-dom/client";
import { describe, expect, it, vi } from "vitest";
import { NeuralBackground } from "@/components/backgrounds/NeuralBackground";

type Options = { particles: { move: { enable: boolean } }; interactivity: { events: { onHover: { enable: boolean } } } };
const captured = vi.hoisted(() => ({ options: null as unknown }));
vi.mock("@tsparticles/react", () => ({
  default: ({ options }: { options: unknown }) => {
    captured.options = options;
    return <div data-testid="particles" />;
  },
  initParticlesEngine: async () => undefined,
}));
vi.mock("@tsparticles/slim", () => ({ loadSlim: async () => undefined }));
vi.mock("next-themes", () => ({ useTheme: () => ({ resolvedTheme: "dark" }) }));

function prefersReducedMotion(matches: boolean) {
  window.matchMedia = vi.fn().mockReturnValue({ matches, addEventListener: vi.fn(), removeEventListener: vi.fn() });
}

async function mount() {
  const container = document.createElement("div");
  await act(async () => {
    createRoot(container).render(<NeuralBackground />);
  });
  return container;
}

describe("NeuralBackground", () => {
  it("animates and follows the cursor by default", async () => {
    prefersReducedMotion(false);
    await mount();
    const options = captured.options as Options;

    expect(options.particles.move.enable).toBe(true);
    expect(options.interactivity.events.onHover.enable).toBe(true);
  });

  it("stands still for readers who asked for reduced motion", async () => {
    prefersReducedMotion(true);
    await mount();
    const options = captured.options as Options;

    expect(options.particles.move.enable).toBe(false);
    expect(options.interactivity.events.onHover.enable).toBe(false);
  });

  it("stays hidden from assistive technology", async () => {
    prefersReducedMotion(false);

    expect((await mount()).firstElementChild?.getAttribute("aria-hidden")).toBe("true");
  });
});
