"use client";

import { FadeIn } from "@/components/animations/FadeIn";
import { SectionHeading } from "@/components/ui/SectionHeading";
import type { Publication } from "@/lib/types";
import { FaFileAlt, FaExternalLinkAlt } from "react-icons/fa";

interface PublicationsSectionProps {
  publications: Publication[];
}

export function PublicationsSection({ publications }: PublicationsSectionProps) {
  if (!publications?.length) return null;

  return (
    <section id="publications" className="section-container bg-background-alt">
      <SectionHeading title="Publicações" subtitle="Artigos e publicações acadêmicas" />

      <div className="space-y-4">
        {publications.map((pub, idx) => (
          <FadeIn key={pub.id} delay={idx * 0.1}>
            <div className="glass-card flex gap-4 transition-transform hover:scale-[1.01]">
              <FaFileAlt className="mt-1 shrink-0 text-xl text-primary" />
              <div>
                <h3 className="font-bold">{pub.title}</h3>
                {pub.journal && <p className="text-sm text-primary">{pub.journal}</p>}
                <p className="text-sm text-muted">{pub.authors}</p>
                {pub.date && (
                  <p className="text-xs text-muted">{new Date(pub.date).getFullYear()}</p>
                )}
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
          </FadeIn>
        ))}
      </div>
    </section>
  );
}
