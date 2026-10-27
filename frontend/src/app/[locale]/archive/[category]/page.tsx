import { notFound } from "next/navigation";
import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { CategoryNav } from "@/components/post/CategoryNav";
import { PostList } from "@/components/post/PostList";
import { listPosts } from "@/lib/api";
import { CATEGORIES, categoryFromSegment, categorySegment } from "@/lib/categories";
import { pageMetadata } from "@/lib/metadata";

type Params = Promise<{ locale: Locale; category: string }>;

export function generateStaticParams() {
  return CATEGORIES.map((c) => ({ category: categorySegment(c) }));
}

export async function generateMetadata({ params }: { params: Params }) {
  const { category: segment } = await params;
  const category = categoryFromSegment(segment);
  if (!category) return {};
  const t = await getTranslations("categories_plural");
  return pageMetadata({ title: t(category), href: { pathname: "/archive/[category]", params: { category: segment } } });
}

export default async function CategoryPage({ params }: { params: Params }) {
  const { locale, category: segment } = await params;
  setRequestLocale(locale);
  const category = categoryFromSegment(segment);
  if (!category) notFound();

  const [posts, t, tPlural] = await Promise.all([
    listPosts({ category, pageSize: 100 }),
    getTranslations("archive"),
    getTranslations("categories_plural"),
  ]);

  return (
    <Container size="wide" className="py-16 sm:py-20">
      <header className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-[color:var(--color-fg)] sm:text-5xl">{tPlural(category)}</h1>
        <div className="mt-6">
          <CategoryNav active={category} />
        </div>
      </header>
      <PostList posts={posts.data} empty={t("empty")} />
    </Container>
  );
}
