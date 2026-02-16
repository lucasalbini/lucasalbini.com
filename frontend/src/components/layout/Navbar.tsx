"use client";

import { useState } from "react";
import { FaBars, FaTimes } from "react-icons/fa";
import { ThemeToggle } from "./ThemeToggle";
import { useActiveSection } from "@/hooks/useActiveSection";
import { cn } from "@/lib/utils";

const navLinks = [
  { id: "about", label: "Sobre", href: "/#about" },
  { id: "skills", label: "Skills", href: "/#skills" },
  { id: "experience", label: "Experiência", href: "/#experience" },
  { id: "education", label: "Formação", href: "/#education" },
  { id: "publications", label: "Publicações", href: "/#publications", dividerAfter: true },
  { id: "projects", label: "Projetos", href: "/projects" },
  { id: "blog", label: "Blog", href: "/blog" },
];

export function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const activeSection = useActiveSection(navLinks.map((l) => l.id));

  return (
    <nav className="fixed top-0 z-50 w-full border-b border-border bg-background/80 backdrop-blur-md">
      <div className="mx-auto flex max-w-6xl items-center justify-between px-4 py-3">
        <a href="/" className="text-xl font-bold text-primary">
          LA
        </a>
        <div className="hidden items-center gap-6 md:flex">
          {navLinks.map((link) => (
            <span key={link.id} className="flex items-center gap-6">
              <a
                href={link.href}
                className={cn(
                  "text-sm font-medium transition-colors hover:text-primary",
                  activeSection === link.id ? "text-primary" : "text-muted"
                )}
              >
                {link.label}
              </a>
              {link.dividerAfter && <span className="text-border">|</span>}
            </span>
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
              href={link.href}
              onClick={() => setIsOpen(false)}
              className="block px-4 py-3 text-sm font-medium text-muted hover:bg-surface hover:text-primary"
            >
              {link.label}
            </a>
          ))}
        </div>
      )}
    </nav>
  );
}
