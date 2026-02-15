"use client";

import { useState } from "react";
import { FadeIn } from "@/components/animations/FadeIn";
import { SectionHeading } from "@/components/ui/SectionHeading";
import type { Publication } from "@/lib/types";
import { FaFileAlt, FaExternalLinkAlt, FaChevronDown } from "react-icons/fa";

interface PublicationsSectionProps {
  publications: Publication[];
}

export function PublicationsSection({ publications }: PublicationsSectionProps) {
  const [expandedPubs, setExpandedPubs] = useState<Set<number>>(new Set());

  if (!publications?.length) return null;

  const togglePub = (id: number) => {
    setExpandedPubs((prev) => {
      const next = new Set(prev);
      if (next.has(id)) {
        next.delete(id);
      } else {
        next.add(id);
      }
      return next;
    });
  };

  return (
    <section id="publications" className="section-container">
      <SectionHeading title="Publicações" subtitle="Artigos e publicações acadêmicas" />

      <div className="space-y-4">
        {publications.map((pub, idx) => {
          const isExpanded = expandedPubs.has(pub.id);
          const hasAbstract = !!pub.abstract;

          return (
            <FadeIn key={pub.id} delay={idx * 0.1}>
              <div className="glass-card">
                <button
                  type="button"
                  onClick={() => hasAbstract && togglePub(pub.id)}
                  className={`flex w-full gap-4 text-left ${hasAbstract ? "cursor-pointer" : "cursor-default"}`}
                >
                  <FaFileAlt className="mt-1 shrink-0 text-xl text-primary" />
                  <div className="flex-1">
                    <h3 className="font-bold">{pub.title}</h3>
                    {pub.journal && <p className="text-sm text-primary">{pub.journal}</p>}
                    <p className="text-sm text-muted">{pub.authors}</p>
                    {pub.date && (
                      <p className="text-xs text-muted">{new Date(pub.date).getFullYear()}</p>
                    )}
                  </div>
                  {hasAbstract && (
                    <FaChevronDown
                      className={`mt-2 shrink-0 text-xs text-muted transition-transform duration-300 ${
                        isExpanded ? "rotate-180" : ""
                      }`}
                    />
                  )}
                </button>

                <div
                  className={`grid transition-all duration-300 ease-in-out ${
                    isExpanded ? "grid-rows-[1fr] opacity-100 mt-3" : "grid-rows-[0fr] opacity-0"
                  }`}
                >
                  <div className="overflow-hidden">
                    <p className="text-sm text-muted border-t border-border pt-3">
                      {pub.abstract}
                    </p>
                    {pub.url && (
                      <a
                        href={pub.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="mt-2 inline-flex items-center gap-1 text-sm text-primary hover:underline"
                      >
                        Ver publicação <FaExternalLinkAlt className="text-xs" />
                      </a>
                    )}
                  </div>
                </div>
              </div>
            </FadeIn>
          );
        })}
      </div>
    </section>
  );
}
