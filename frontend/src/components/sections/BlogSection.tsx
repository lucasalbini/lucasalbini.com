"use client";

import { useState } from "react";
import { FadeIn } from "@/components/animations/FadeIn";
import { SectionHeading } from "@/components/ui/SectionHeading";
import type { Post } from "@/lib/types";
import { getStrapiMediaUrl } from "@/lib/utils";
import Image from "next/image";
import { FaClock, FaCalendar } from "react-icons/fa";
import { FiPlusCircle, FiMinusCircle } from "react-icons/fi";

// Sidebar categories - predefined
const sidebarCategories = [
  { label: "Projetos", slug: "projetos" },
  { label: "Documentações", slug: "documentacoes" },
  { label: "IA e Machine Learning", slug: "ia-ml" },
  { label: "Visão Computacional", slug: "visao-computacional" },
  { label: "Engenharia", slug: "engenharia" },
  { label: "Eletrônica", slug: "eletronica" },
  { label: "Cloud", slug: "cloud" },
  { label: "Outros", slug: "outros" },
];

interface SidebarCategory {
  label: string;
  slug: string;
  children?: { label: string; slug: string }[];
}

function SidebarItem({
  cat,
  activeFilter,
  onFilter,
  isLast,
}: {
  cat: SidebarCategory;
  activeFilter: string;
  onFilter: (slug: string) => void;
  isLast: boolean;
}) {
  const [open, setOpen] = useState(false);
  const hasChildren = cat.children && cat.children.length > 0;
  const isActive = activeFilter === cat.slug;
  const treeSymbol = isLast ? "└── " : "├── ";

  return (
    <li>
      <div className="flex items-center">
        <span className="mr-1 font-mono text-xs text-muted select-none">{treeSymbol}</span>
        {hasChildren && (
          <button
            type="button"
            onClick={() => setOpen(!open)}
            className="mr-1 text-muted hover:text-primary transition-colors"
          >
            {open ? (
              <FiMinusCircle className="w-3.5 h-3.5" />
            ) : (
              <FiPlusCircle className="w-3.5 h-3.5" />
            )}
          </button>
        )}
        <button
          type="button"
          onClick={() => onFilter(cat.slug)}
          className={`text-sm transition-colors hover:text-primary ${
            isActive ? "font-semibold text-primary" : "text-foreground"
          }`}
        >
          {cat.label}
        </button>
      </div>
      {hasChildren && open && (
        <ul className="ml-6 mt-1 space-y-1.5">
          {cat.children!.map((child, idx) => {
            const childSymbol = idx === cat.children!.length - 1 ? "└── " : "├── ";
            return (
              <li key={child.slug} className="flex items-center">
                <span className="mr-1 font-mono text-xs text-muted select-none">{childSymbol}</span>
                <button
                  type="button"
                  onClick={() => onFilter(child.slug)}
                  className={`text-sm transition-colors hover:text-primary ${
                    activeFilter === child.slug
                      ? "font-semibold text-primary"
                      : "text-muted"
                  }`}
                >
                  {child.label}
                </button>
              </li>
            );
          })}
        </ul>
      )}
    </li>
  );
}

interface BlogSectionProps {
  posts: Post[];
  title?: string;
  subtitle?: string;
  showAll?: boolean;
}

export function BlogSection({
  posts,
  title = "Blog",
  subtitle = "Últimos artigos e publicações",
  showAll = false,
}: BlogSectionProps) {
  const [activeFilter, setActiveFilter] = useState("all");
  const [search, setSearch] = useState("");

  if (!posts?.length) return null;

  const displayed = (showAll ? posts : posts.slice(0, 3)).filter((post) => {
    if (search) {
      const q = search.toLowerCase();
      if (
        !post.title.toLowerCase().includes(q) &&
        !post.excerpt?.toLowerCase().includes(q)
      )
        return false;
    }
    return true;
  });

  const formatDateFull = (dateStr: string) => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("pt-BR", {
      weekday: "long",
      year: "numeric",
      month: "long",
      day: "numeric",
    });
  };

  // Homepage preview
  if (!showAll) {
    return (
      <section id="blog" className="section-container">
        <SectionHeading title={title} subtitle={subtitle} />
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {displayed.map((post, idx) => (
            <FadeIn key={post.id} delay={idx * 0.1}>
              <a href={`/blog/${post.slug}`} className="group block">
                <div className="glass-card overflow-hidden !p-0 transition-transform hover:scale-[1.02]">
                  {post.featured_image && (
                    <div className="relative h-48 w-full overflow-hidden">
                      <Image
                        src={getStrapiMediaUrl(post.featured_image.url)}
                        alt={post.title}
                        fill
                        className="object-cover transition-transform group-hover:scale-110"
                      />
                    </div>
                  )}
                  <div className="p-5">
                    <h3 className="mb-2 font-bold group-hover:text-primary">{post.title}</h3>
                    <p className="mb-3 text-sm text-muted line-clamp-2">{post.excerpt}</p>
                    <div className="flex items-center gap-4 text-xs text-muted">
                      <span className="flex items-center gap-1">
                        <FaCalendar /> {formatDateFull(post.createdAt)}
                      </span>
                      {post.reading_time && (
                        <span className="flex items-center gap-1">
                          <FaClock /> {post.reading_time} min
                        </span>
                      )}
                    </div>
                  </div>
                </div>
              </a>
            </FadeIn>
          ))}
        </div>
        {posts.length > 3 && (
          <div className="mt-8 text-center">
            <a
              href="/blog"
              className="inline-flex items-center gap-2 rounded-lg bg-primary px-6 py-3 font-medium text-white transition-colors hover:bg-primary-dark"
            >
              Ver todos os posts
            </a>
          </div>
        )}
      </section>
    );
  }

  // Full blog page — Toha layout
  return (
    <div className="flex min-h-[calc(100vh-4rem)]">
      {/* ── Sidebar ── */}
      <aside className="hidden lg:block w-80 shrink-0 border-r border-border bg-background-alt">
        <div
          className="sticky top-16 overflow-y-auto px-4 py-6"
          style={{ maxHeight: "calc(100vh - 4rem)" }}
        >
          {/* Search */}
          <input
            type="text"
            placeholder="Search"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-full rounded border border-border bg-background px-3 py-1.5 text-sm outline-none placeholder:text-muted focus:border-primary mb-4"
          />

          {/* Sidebar tree */}
          <div className="sidebar-tree">
            <ul className="space-y-3">
              <li className="mb-1">
                <button
                  type="button"
                  onClick={() => setActiveFilter("all")}
                  className={`text-sm font-bold transition-colors hover:text-primary ${
                    activeFilter === "all" ? "text-primary" : "text-foreground"
                  }`}
                >
                  Posts
                </button>
              </li>
              {sidebarCategories.map((cat, idx) => (
                <SidebarItem
                  key={cat.slug}
                  cat={cat}
                  activeFilter={activeFilter}
                  onFilter={setActiveFilter}
                  isLast={idx === sidebarCategories.length - 1}
                />
              ))}
            </ul>
          </div>
        </div>
      </aside>

      {/* ── Content ── */}
      <div className="flex-1 bg-background-alt/40">
        <div className="px-6 py-8 lg:px-10">
          {/* Post card grid */}
          <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {displayed.map((post) => (
              <article
                key={post.id}
                className="flex flex-col overflow-hidden rounded-md border border-border bg-background shadow-sm transition-shadow hover:shadow-lg"
              >
                {/* Card image */}
                <a href={`/blog/${post.slug}`} className="block">
                  <div className="relative aspect-[16/9] w-full overflow-hidden bg-background-alt">
                    {post.featured_image ? (
                      <Image
                        src={getStrapiMediaUrl(post.featured_image.url)}
                        alt={post.title}
                        fill
                        className="object-cover"
                      />
                    ) : (
                      <div className="flex h-full w-full items-center justify-center text-4xl text-muted/30">
                        📄
                      </div>
                    )}
                  </div>
                </a>

                {/* Card body */}
                <a href={`/blog/${post.slug}`} className="flex-1 px-5 pt-4 pb-3">
                  <h5 className="mb-2 text-base font-bold leading-snug text-foreground">
                    {post.title}
                  </h5>
                  <p className="text-sm leading-relaxed text-muted line-clamp-4">
                    {post.excerpt}
                  </p>
                </a>

                {/* Card footer */}
                <div className="flex items-center justify-between border-t border-border px-5 py-2.5">
                  <span className="text-xs text-muted">
                    {formatDateFull(post.createdAt)}
                    {post.reading_time ? ` | ${post.reading_time} min` : ""}
                  </span>
                  <a
                    href={`/blog/${post.slug}`}
                    className="shrink-0 rounded border border-primary px-3 py-1 text-xs font-medium text-primary transition-colors hover:bg-primary hover:text-white"
                  >
                    Ler
                  </a>
                </div>
              </article>
            ))}
          </div>

          {displayed.length === 0 && (
            <p className="py-20 text-center text-muted">Nenhum post encontrado.</p>
          )}
        </div>
      </div>
    </div>
  );
}
