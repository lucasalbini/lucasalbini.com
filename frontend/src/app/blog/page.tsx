import { Navbar } from "@/components/layout/Navbar";
import { Footer } from "@/components/layout/Footer";
import { ScrollToTop } from "@/components/layout/ScrollToTop";
import { BlogSection } from "@/components/sections/BlogSection";
import { getPosts } from "@/lib/api";

export const metadata = {
  title: "Blog - Lucas Albini",
  description: "Artigos sobre IA, Machine Learning e tecnologia",
};

export default async function BlogPage() {
  let posts;
  try {
    posts = await getPosts("pt-BR", 1, 50);
  } catch {
    posts = { data: [] };
  }

  return (
    <>
      <Navbar />
      <main className="pt-16">
        <BlogSection
          posts={posts?.data || []}
          showAll
        />
      </main>
      <Footer />
      <ScrollToTop />
    </>
  );
}
