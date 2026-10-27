import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { CategoryNav } from "@/components/post/CategoryNav";
import { PostList } from "@/components/post/PostList";
import { listPosts } from "@/lib/api";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata() {
  const t = await getTranslations("archive");
  return pageMetadata({ title: t("title"), href: "/archive" });
}

export default async function ArchivePage({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const [posts, t] = await Promise.all([listPosts({ pageSize: 100 }), getTranslations("archive")]);

  return (
    <Container size="wide" className="py-16 sm:py-20">
      <header className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-[color:var(--color-fg)] sm:text-5xl">{t("title")}</h1>
        <div className="mt-6">
          <CategoryNav active={null} />
        </div>
      </header>
      <PostList posts={posts.data} empty={t("empty")} />
    </Container>
  );
}
