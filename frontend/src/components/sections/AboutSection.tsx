"use client";

import { FadeIn } from "@/components/animations/FadeIn";
import { SectionHeading } from "@/components/ui/SectionHeading";
import type { Profile, Certification } from "@/lib/types";
import { FaAward } from "react-icons/fa";

interface AboutSectionProps {
  profile: Profile;
  certifications: Certification[];
}

export function AboutSection({ profile, certifications }: AboutSectionProps) {
  return (
    <section id="about" className="section-container">
      <SectionHeading title="Sobre Mim" subtitle="Conheça um pouco sobre minha trajetória" />

      <FadeIn>
        <div className="glass-card !p-8">
          <div className="max-w-none text-xl leading-relaxed text-foreground dark:text-foreground">
            <div dangerouslySetInnerHTML={{ __html: profile.summary || "" }} />
          </div>
        </div>
      </FadeIn>

      <FadeIn delay={0.2}>
        <div className="mt-8">
          <div className="glass-card !p-6">
            <h3 className="text-lg font-semibold mb-4">Certificações</h3>
            <div className="grid gap-3 md:grid-cols-2">
              {certifications.map((cert) => (
                <a
                  key={cert.id}
                  href={cert.credential_url || "#"}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center gap-3 rounded-lg border border-border bg-neutral/50 p-3 transition-transform hover:scale-[1.02]"
                >
                  <FaAward className="shrink-0 text-xl text-primary" />
                  <div>
                    <p className="font-medium">{cert.name}</p>
                    <p className="text-sm text-muted">{cert.issuer}</p>
                  </div>
                </a>
              ))}
            </div>
          </div>
        </div>
      </FadeIn>
    </section>
  );
}
