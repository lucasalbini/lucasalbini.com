"use client";

import { useEffect, useState } from "react";
import Particles, { initParticlesEngine } from "@tsparticles/react";
import { loadSlim } from "@tsparticles/slim";
import { useTheme } from "next-themes";

/**
 * Neural-network style particle field that reacts to the cursor.
 * Fixed behind the whole page. Dense enough to read as a network rather than
 * scattered dots — which means it has to move slowly, or the page shimmers.
 */
export function NeuralBackground({ className = "" }: { className?: string }) {
  const [ready, setReady] = useState(false);
  const [reducedMotion, setReducedMotion] = useState(false);
  const { resolvedTheme } = useTheme();

  useEffect(() => {
    const mq = window.matchMedia("(prefers-reduced-motion: reduce)");
    const sync = () => setReducedMotion(mq.matches);
    sync();
    mq.addEventListener("change", sync);
    initParticlesEngine(async (engine) => {
      await loadSlim(engine);
    }).then(() => setReady(true));
    return () => mq.removeEventListener("change", sync);
  }, []);

  if (!ready) return <div className={className} aria-hidden />;

  const isDark = resolvedTheme === "dark";
  const nodeColors = isDark ? ["#00D4AA", "#16E5BB", "#D4734A"] : ["#00B892", "#0D8B72", "#B85A35"];
  const linkColor = isDark ? "#00D4AA" : "#5E7058";
  const grabColor = isDark ? "#E58A66" : "#B85A35";
  const linkOpacity = isDark ? 0.3 : 0.34;

  return (
    <div className={className} aria-hidden>
      <Particles
        id="neural-bg"
        className="absolute inset-0"
        options={{
          fullScreen: { enable: false },
          background: { color: { value: "transparent" } },
          fpsLimit: 60,
          particles: {
            number: { value: 120, density: { enable: true } },
            color: { value: nodeColors },
            shape: { type: "circle" },
            opacity: {
              value: { min: 0.3, max: 0.65 },
              animation: { enable: !reducedMotion, speed: 0.4, sync: false },
            },
            size: { value: { min: 1, max: 2.5 } },
            links: {
              enable: true,
              distance: 130,
              color: linkColor,
              opacity: linkOpacity,
              width: 1,
            },
            move: {
              enable: !reducedMotion,
              speed: 0.35,
              direction: "none",
              random: true,
              straight: false,
              outModes: { default: "bounce" },
            },
          },
          interactivity: {
            events: {
              onHover: { enable: !reducedMotion, mode: "grab" },
            },
            modes: {
              grab: {
                distance: 200,
                links: { opacity: 0.55, color: grabColor },
              },
            },
          },
          detectRetina: true,
        }}
      />
    </div>
  );
}
