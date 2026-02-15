"use client";

import { FadeIn } from "@/components/animations/FadeIn";
import { SectionHeading } from "@/components/ui/SectionHeading";
import type { Profile, Certification } from "@/lib/types";
import { FaDownload, FaAward } from "react-icons/fa";

interface AboutSectionProps {
  profile: Profile;
  certifications: Certification[];
}

export function AboutSection({ profile, certifications }: AboutSectionProps) {
  return (
    <section id="about" className="section-container">
      <SectionHeading title="Sobre Mim" subtitle="Conheça um pouco sobre minha trajetória" />

      <div className="grid gap-8 md:grid-cols-2">
        <FadeIn>
          <div className="prose prose-slate dark:prose-invert max-w-none">
            <div dangerouslySetInnerHTML={{ __html: profile.summary || "" }} />
          </div>

          <a
            href="/files/curriculo_lucasalbini.pdf"
            target="_blank"
            className="mt-6 inline-flex items-center gap-2 rounded-lg bg-primary px-6 py-3 font-medium text-white transition-colors hover:bg-primary-dark"
          >
            <FaDownload /> Download CV
          </a>
        </FadeIn>

        <FadeIn delay={0.2}>
          <div className="space-y-6">
            <h3 className="text-lg font-semibold">Certificações</h3>
            <div className="grid gap-3">
              {certifications.map((cert) => (
                <a
                  key={cert.id}
                  href={cert.credential_url || "#"}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="glass-card flex items-center gap-3 !p-4 transition-transform hover:scale-[1.02]"
                >
                  <FaAward className="shrink-0 text-xl text-primary" />
                  <div>
                    <p className="font-medium">{cert.name}</p>
                    <p className="text-sm text-muted">{cert.issuer}</p>
                  </div>
                </a>
              ))}
            </div>

            {profile.soft_skills?.length > 0 && (
              <>
                <h3 className="text-lg font-semibold">Soft Skills</h3>
                <div className="flex flex-wrap gap-2">
                  {profile.soft_skills.map((skill) => (
                    <span
                      key={skill.id}
                      className="rounded-full bg-primary/10 px-3 py-1 text-sm font-medium text-primary"
                    >
                      {skill.name}
                    </span>
                  ))}
                </div>
              </>
            )}
          </div>
        </FadeIn>
      </div>
    </section>
  );
}
