"use client";

import { FadeIn } from "@/components/animations/FadeIn";
import { StaggerChildren, StaggerItem } from "@/components/animations/StaggerChildren";
import { SectionHeading } from "@/components/ui/SectionHeading";
import type { Post } from "@/lib/types";
import { getStrapiMediaUrl } from "@/lib/utils";
import Image from "next/image";
import { FaClock, FaCalendar } from "react-icons/fa";

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
  if (!posts?.length) return null;

  const displayed = showAll ? posts : posts.slice(0, 3);

  return (
    <section id="blog" className="section-container">
      <SectionHeading title={title} subtitle={subtitle} />

      <StaggerChildren className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {displayed.map((post) => (
          <StaggerItem key={post.id}>
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
                      <FaCalendar />
                      {new Date(post.createdAt).toLocaleDateString("pt-BR")}
                    </span>
                    {post.reading_time && (
                      <span className="flex items-center gap-1">
                        <FaClock />
                        {post.reading_time} min
                      </span>
                    )}
                  </div>
                </div>
              </div>
            </a>
          </StaggerItem>
        ))}
      </StaggerChildren>

      {!showAll && posts.length > 3 && (
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
