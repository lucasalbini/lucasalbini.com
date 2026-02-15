"use client";

import Image from "next/image";
import { TypingEffect } from "@/components/ui/TypingEffect";
import { SocialLinks } from "@/components/ui/SocialLinks";
import type { Profile } from "@/lib/types";
import { FaChevronDown } from "react-icons/fa";

interface HeroSectionProps {
  profile: Profile;
}

export function HeroSection({ profile }: HeroSectionProps) {
  return (
    <section
      id="hero"
      className="relative flex min-h-screen items-center justify-center overflow-hidden"
    >
      <div className="absolute inset-0 z-0">
        <Image
          src="/images/background.gif"
          alt="Background"
          fill
          className="object-cover"
          unoptimized
          priority
        />
        <div className="absolute inset-0 bg-black/60" />
      </div>

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
