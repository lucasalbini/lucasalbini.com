"use client";

import { useState } from "react";
import { FadeIn } from "@/components/animations/FadeIn";
import { SectionHeading } from "@/components/ui/SectionHeading";
import type { Experience } from "@/lib/types";
import { formatDate } from "@/lib/utils";
import { FaBriefcase, FaChevronDown } from "react-icons/fa";

interface ExperienceSectionProps {
  experiences: Experience[];
}

export function ExperienceSection({ experiences }: ExperienceSectionProps) {
  const [expandedPositions, setExpandedPositions] = useState<Set<number>>(new Set());

  const togglePosition = (positionId: number) => {
    setExpandedPositions((prev) => {
      const next = new Set(prev);
      if (next.has(positionId)) {
        next.delete(positionId);
      } else {
        next.add(positionId);
      }
      return next;
    });
  };

  return (
    <section id="experience" className="section-container">
      <SectionHeading title="Experiência" subtitle="Minha trajetória profissional" />

      <div className="relative">
        <div className="absolute left-4 top-0 hidden h-full w-0.5 bg-border md:left-1/2 md:block" />

        <div className="space-y-8">
          {experiences.map((exp, idx) => (
            <FadeIn
              key={exp.id}
              direction={idx % 2 === 0 ? "left" : "right"}
              delay={idx * 0.1}
            >
              <div
                className={`relative md:w-1/2 ${
                  idx % 2 === 0 ? "md:pr-8" : "md:ml-auto md:pl-8"
                }`}
              >
                <div className="absolute left-4 top-6 hidden h-4 w-4 rounded-full border-4 border-primary bg-background md:block md:left-auto md:right-0 md:translate-x-1/2 ${idx % 2 !== 0 ? '!left-0 !-translate-x-1/2' : ''}" />

                <div className="glass-card ml-8 md:ml-0">
                  <div className="mb-4 flex items-center gap-3">
                    <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-primary/10">
                      <FaBriefcase className="text-primary" />
                    </div>
                    <div>
                      <h3 className="text-lg font-bold">{exp.company_name}</h3>
                      <p className="text-sm text-muted">{exp.company_location}</p>
                    </div>
                  </div>

                  <div className="space-y-3">
                    {exp.positions?.map((pos) => {
                      const isExpanded = expandedPositions.has(pos.id);
                      const hasResponsibilities = pos.responsibilities?.length > 0;

                      return (
                        <div key={pos.id} className="border-l-2 border-primary/30 pl-4">
                          <button
                            type="button"
                            onClick={() => hasResponsibilities && togglePosition(pos.id)}
                            className={`w-full text-left ${hasResponsibilities ? "cursor-pointer" : "cursor-default"}`}
                          >
                            <div className="flex items-center justify-between">
                              <div>
                                <h4 className="font-semibold">{pos.designation}</h4>
                                <p className="text-sm text-muted">
                                  {formatDate(pos.start_date)} -{" "}
                                  {pos.is_current ? "Presente" : pos.end_date ? formatDate(pos.end_date) : ""}
                                </p>
                              </div>
                              {hasResponsibilities && (
                                <FaChevronDown
                                  className={`shrink-0 text-xs text-muted transition-transform duration-300 ${
                                    isExpanded ? "rotate-180" : ""
                                  }`}
                                />
                              )}
                            </div>
                          </button>

                          <div
                            className={`grid transition-all duration-300 ease-in-out ${
                              isExpanded ? "grid-rows-[1fr] opacity-100 mt-2" : "grid-rows-[0fr] opacity-0"
                            }`}
                          >
                            <div className="overflow-hidden">
                              <ul className="space-y-1 text-sm text-muted">
                                {pos.responsibilities?.map((r) => (
                                  <li key={r.id} className="flex gap-2">
                                    <span className="mt-1.5 h-1.5 w-1.5 shrink-0 rounded-full bg-primary" />
                                    {r.description}
                                  </li>
                                ))}
                              </ul>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              </div>
            </FadeIn>
          ))}
        </div>
      </div>
    </section>
  );
}
