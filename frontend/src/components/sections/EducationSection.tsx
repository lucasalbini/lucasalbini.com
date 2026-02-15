"use client";

import { FadeIn } from "@/components/animations/FadeIn";
import { SectionHeading } from "@/components/ui/SectionHeading";
import type { Education } from "@/lib/types";
import { FaGraduationCap } from "react-icons/fa";

interface EducationSectionProps {
  education: Education[];
}

export function EducationSection({ education }: EducationSectionProps) {
  return (
    <section id="education" className="section-container">
      <SectionHeading title="Formação Acadêmica" subtitle="Minha formação educacional" />

      <div className="grid gap-6 md:grid-cols-2">
        {education.map((edu, idx) => (
          <FadeIn key={edu.id} delay={idx * 0.15}>
            <div className="glass-card flex gap-4 transition-transform hover:scale-[1.02]">
              <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-primary/10">
                <FaGraduationCap className="text-xl text-primary" />
              </div>
              <div>
                <h3 className="font-bold">{edu.institution}</h3>
                <p className="text-primary">{edu.degree}</p>
                <p className="text-sm text-muted">{edu.field_of_study}</p>
                <p className="mt-1 text-sm text-muted">
                  {edu.start_date?.slice(0, 4)} - {edu.end_date?.slice(0, 4) || "Presente"}
                </p>
              </div>
            </div>
          </FadeIn>
        ))}
      </div>
    </section>
  );
}
