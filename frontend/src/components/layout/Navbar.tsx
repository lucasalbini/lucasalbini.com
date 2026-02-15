"use client";

import { useState } from "react";
import { FaBars, FaTimes } from "react-icons/fa";
import { ThemeToggle } from "./ThemeToggle";
import { useActiveSection } from "@/hooks/useActiveSection";
import { cn } from "@/lib/utils";

const navLinks = [
  { id: "about", label: "Sobre" },
  { id: "skills", label: "Skills" },
  { id: "experience", label: "Experiência" },
  { id: "education", label: "Formação" },
  { id: "projects", label: "Projetos" },
  { id: "publications", label: "Publicações" },
  { id: "blog", label: "Blog" },
];

export function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const activeSection = useActiveSection(navLinks.map((l) => l.id));

  return (
    <nav className="fixed top-0 z-50 w-full border-b border-border bg-background/80 backdrop-blur-md">
      <div className="mx-auto flex max-w-6xl items-center justify-between px-4 py-3">
        <a href="#hero" className="text-xl font-bold text-primary">
          LA
        </a>
        <div className="hidden items-center gap-6 md:flex">
          {navLinks.map((link) => (
            <a
              key={link.id}
              href={`#${link.id}`}
              className={cn(
                "text-sm font-medium transition-colors hover:text-primary",
                activeSection === link.id ? "text-primary" : "text-muted"
              )}
            >
              {link.label}
            </a>
          ))}
          <ThemeToggle />
        </div>
        <div className="flex items-center gap-4 md:hidden">
          <ThemeToggle />
          <button onClick={() => setIsOpen(!isOpen)} className="text-xl text-foreground">
            {isOpen ? <FaTimes /> : <FaBars />}
          </button>
        </div>
      </div>
      {isOpen && (
        <div className="border-t border-border bg-background md:hidden">
          {navLinks.map((link) => (
            <a
              key={link.id}
              href={`#${link.id}`}
              onClick={() => setIsOpen(false)}
              className="block px-4 py-3 text-sm font-medium text-muted hover:bg-background-alt hover:text-primary"
            >
              {link.label}
            </a>
          ))}
        </div>
      )}
    </nav>
  );
}
