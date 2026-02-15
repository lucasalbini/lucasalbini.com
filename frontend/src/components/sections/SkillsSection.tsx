"use client";

import { useState } from "react";
import { FadeIn } from "@/components/animations/FadeIn";
import { StaggerChildren, StaggerItem } from "@/components/animations/StaggerChildren";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { FilterButton } from "@/components/ui/FilterButton";
import type { Skill } from "@/lib/types";
import { getCategoryLabel } from "@/lib/utils";
import {
  SiPython, SiTypescript, SiGo, SiReact, SiNextdotjs, SiFastapi, SiDocker,
  SiKubernetes, SiTensorflow, SiPytorch, SiOpencv, SiAmazonwebservices,
  SiMicrosoftazure, SiGooglecloud,
} from "react-icons/si";
import { FaCode } from "react-icons/fa";

const iconMap: Record<string, React.ComponentType<{ className?: string }>> = {
  SiPython, SiTypescript, SiGo, SiReact, SiNextdotjs, SiFastapi,
  SiDocker, SiKubernetes, SiTensorflow, SiPytorch, SiOpencv,
  SiAmazonwebservices, SiMicrosoftazure, SiGooglecloud,
};

const categories = ["all", "language", "framework", "cloud", "ai_ml", "devops", "tools"] as const;

interface SkillsSectionProps {
  skills: Skill[];
}

export function SkillsSection({ skills }: SkillsSectionProps) {
  const [activeCategory, setActiveCategory] = useState("all");

  const filtered = activeCategory === "all"
    ? skills
    : skills.filter((s) => s.category === activeCategory);

  return (
    <section id="skills" className="section-container">
      <SectionHeading title="Skills" subtitle="Tecnologias e ferramentas que utilizo" />

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

      <StaggerChildren className="grid grid-cols-2 gap-4 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6">
        {filtered.map((skill) => {
          const Icon = (skill.icon_name && iconMap[skill.icon_name]) || FaCode;
          return (
            <StaggerItem key={skill.id}>
              <div className="glass-card flex flex-col items-center gap-3 text-center transition-transform hover:scale-105">
                <Icon className="text-3xl text-primary" />
                <span className="text-sm font-medium">{skill.name}</span>
              </div>
            </StaggerItem>
          );
        })}
      </StaggerChildren>
    </section>
  );
}
