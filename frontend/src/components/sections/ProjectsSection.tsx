"use client";

import { useState } from "react";
import { FadeIn } from "@/components/animations/FadeIn";
import { StaggerChildren, StaggerItem } from "@/components/animations/StaggerChildren";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { FilterButton } from "@/components/ui/FilterButton";
import type { Project } from "@/lib/types";
import { getCategoryLabel } from "@/lib/utils";
import { FaGithub, FaExternalLinkAlt, FaFolder } from "react-icons/fa";

const categories = ["all", "professional", "academic", "hobby"] as const;

interface ProjectsSectionProps {
  projects: Project[];
  showAll?: boolean;
}

export function ProjectsSection({ projects, showAll = false }: ProjectsSectionProps) {
  const [activeCategory, setActiveCategory] = useState("all");

  const filtered = activeCategory === "all"
    ? projects
    : projects.filter((p) => p.category === activeCategory);

  const displayed = showAll ? filtered : filtered.filter((p) => p.featured);

  return (
    <section id="projects" className="section-container">
      <SectionHeading title="Projetos" subtitle="Principais projetos desenvolvidos" />

      <div className="mb-8 flex flex-wrap justify-center gap-2">
        {categories.map((cat) => (
          <FilterButton
            key={cat}
            label={cat === "all" ? "Todos" : getCategoryLabel(cat)}
            active={activeCategory === cat}
            onClick={() => setActiveCategory(cat)}
          />
        ))}
      </div>

      <StaggerChildren className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {displayed.map((project) => (
          <StaggerItem key={project.id}>
            <div className="glass-card flex h-full flex-col transition-transform hover:scale-[1.02]">
              <div className="mb-3 flex items-center gap-3">
                <FaFolder className="text-xl text-primary" />
                <h3 className="font-bold">{project.name}</h3>
              </div>
              {project.role && (
                <p className="mb-2 text-sm font-medium text-primary">{project.role}</p>
              )}
              <p className="mb-4 flex-1 text-sm text-muted">{project.description}</p>
              {project.tags?.length > 0 && (
                <div className="mb-4 flex flex-wrap gap-1">
                  {project.tags.map((tag) => (
                    <span
                      key={tag}
                      className="rounded bg-primary/10 px-2 py-0.5 text-xs text-primary"
                    >
                      {tag}
                    </span>
                  ))}
                </div>
              )}
              <div className="flex gap-4">
                {project.repo_url && (
                  <a
                    href={project.repo_url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-muted transition-colors hover:text-primary"
                  >
                    <FaGithub className="text-lg" />
                  </a>
                )}
                {project.demo_url && (
                  <a
                    href={project.demo_url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-muted transition-colors hover:text-primary"
                  >
                    <FaExternalLinkAlt className="text-lg" />
                  </a>
                )}
              </div>
            </div>
          </StaggerItem>
        ))}
      </StaggerChildren>

      {!showAll && (
        <div className="mt-8 text-center">
          <a
            href="/projects"
            className="inline-flex items-center gap-2 rounded-lg bg-primary px-6 py-3 font-medium text-white transition-colors hover:bg-primary-dark"
          >
            Ver todos os projetos
          </a>
        </div>
      )}
    </section>
  );
}
