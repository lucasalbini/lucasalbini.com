import { Navbar } from "@/components/layout/Navbar";
import { Footer } from "@/components/layout/Footer";
import { ScrollToTop } from "@/components/layout/ScrollToTop";
import { MarkdownRenderer } from "@/components/ui/MarkdownRenderer";
import { getPostBySlug } from "@/lib/api";
import { getStrapiMediaUrl } from "@/lib/utils";
import Image from "next/image";
import { FaCalendar, FaClock, FaArrowLeft } from "react-icons/fa";

interface BlogPostPageProps {
  params: Promise<{ slug: string }>;
}

export default async function BlogPostPage({ params }: BlogPostPageProps) {
  const { slug } = await params;
  let postData;
  try {
    const response = await getPostBySlug(slug);
    const data = (response as { data: unknown[] })?.data;
    postData = Array.isArray(data) ? data[0] : data;
  } catch {
    postData = null;
  }

  if (!postData) {
    return (
      <>
        <Navbar />
        <main className="pt-24 text-center">
          <h1 className="text-2xl font-bold">Post não encontrado</h1>
          <a href="/blog" className="mt-4 inline-block text-primary hover:underline">
            Voltar ao blog
          </a>
        </main>
        <Footer />
      </>
    );
  }

  return (
    <>
      <Navbar />
      <main className="pt-20">
        <article className="mx-auto max-w-3xl px-4 py-8">
          <a
            href="/blog"
            className="mb-6 inline-flex items-center gap-2 text-sm text-muted hover:text-primary"
          >
            <FaArrowLeft /> Voltar ao blog
          </a>

          {postData.featured_image && (
            <div className="relative mb-8 h-64 w-full overflow-hidden rounded-xl sm:h-96">
              <Image
                src={getStrapiMediaUrl(postData.featured_image.url)}
                alt={postData.title}
                fill
                className="object-cover"
              />
            </div>
          )}

          <h1 className="mb-4 text-3xl font-bold sm:text-4xl">{postData.title}</h1>

          <div className="mb-8 flex items-center gap-4 text-sm text-muted">
            <span className="flex items-center gap-1">
              <FaCalendar />
              {new Date(postData.createdAt).toLocaleDateString("pt-BR")}
            </span>
            {postData.reading_time && (
              <span className="flex items-center gap-1">
                <FaClock />
                {postData.reading_time} min de leitura
              </span>
            )}
            {postData.author && <span>por {postData.author}</span>}
          </div>

          {postData.tags?.length > 0 && (
            <div className="mb-8 flex flex-wrap gap-2">
              {postData.tags.map((tag: string) => (
                <span
                  key={tag}
                  className="rounded-full bg-primary/10 px-3 py-1 text-xs font-medium text-primary"
                >
                  {tag}
                </span>
              ))}
            </div>
          )}

          <MarkdownRenderer content={postData.content || ""} />
        </article>
      </main>
      <Footer />
      <ScrollToTop />
    </>
  );
}
