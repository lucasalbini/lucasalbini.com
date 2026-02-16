"use client";

import { useState, useEffect } from "react";
import Image from "next/image";
import Particles, { initParticlesEngine } from "@tsparticles/react";
import { loadSlim } from "@tsparticles/slim";
import { TypingEffect } from "@/components/ui/TypingEffect";
import { SocialLinks } from "@/components/ui/SocialLinks";
import type { Profile } from "@/lib/types";
import { FaChevronDown } from "react-icons/fa";

interface HeroSectionProps {
  profile: Profile;
}

export function HeroSection({ profile }: HeroSectionProps) {
  const [engineReady, setEngineReady] = useState(false);

  useEffect(() => {
    initParticlesEngine(async (engine) => {
      await loadSlim(engine);
    }).then(() => setEngineReady(true));
  }, []);

  return (
    <section
      id="hero"
      className="relative flex min-h-screen items-center justify-center overflow-hidden bg-[#0F1E17]"
    >
      {engineReady && (
        <Particles
          id="hero-particles"
          className="absolute inset-0 z-0"
          options={{
            fullScreen: { enable: false },
            background: { color: { value: "transparent" } },
            fpsLimit: 60,
            particles: {
              number: { value: 60, density: { enable: true } },
              color: { value: ["#00D4AA", "#00B892", "#D4734A"] },
              shape: { type: "circle" },
              opacity: {
                value: { min: 0.3, max: 0.7 },
                animation: { enable: true, speed: 0.5, sync: false },
              },
              size: {
                value: { min: 1, max: 3 },
              },
              links: {
                enable: true,
                distance: 150,
                color: "#00D4AA",
                opacity: 0.15,
                width: 1,
              },
              move: {
                enable: true,
                speed: 0.8,
                direction: "none",
                random: true,
                straight: false,
                outModes: { default: "bounce" },
              },
            },
            interactivity: {
              events: {
                onHover: { enable: true, mode: "grab" },
              },
              modes: {
                grab: {
                  distance: 200,
                  links: { opacity: 0.4, color: "#D4734A" },
                },
              },
            },
            detectRetina: true,
          }}
        />
      )}

      <div className="relative z-10 flex flex-col items-center gap-6 px-4 text-center text-white">
        <div className="relative h-40 w-40 overflow-hidden rounded-full border-4 border-primary shadow-xl">
          <Image
            src="/images/profile_photo.jpeg"
            alt={profile.name}
            fill
            className="object-cover"
            priority
          />
        </div>

        <h1 className="text-4xl font-bold sm:text-5xl">{profile.name}</h1>

        <div className="text-xl sm:text-2xl">
          <TypingEffect titles={profile.typing_titles || [profile.designation]} />
        </div>

        <p className="max-w-md text-lg text-gray-300">{profile.location}</p>

        <SocialLinks links={profile.social_links || []} size="lg" />

        <a
          href="#about"
          className="mt-8 animate-bounce text-3xl text-white/70 transition-colors hover:text-primary"
        >
          <FaChevronDown />
        </a>
      </div>
    </section>
  );
}
