import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostCard } from "@/components/cards/PostCard";
import { listPosts } from "@/lib/api";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "blog" });
  return pageMetadata({ locale, title: t("title"), href: { pathname: "/blog" } });
}

export default async function BlogIndex({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const [posts, t] = await Promise.all([
    listPosts(locale, { pageSize: 50 }),
    getTranslations({ locale, namespace: "blog" }),
  ]);

  return (
    <Container size="full" className="py-12">
      <header className="mb-10">
        <h1 className="text-3xl font-semibold text-[color:var(--color-fg)]">{t("title")}</h1>
        <p className="mt-2 text-sm text-[color:var(--color-muted)]">
          {posts.pagination?.total ?? posts.data.length}{" "}
          {(posts.pagination?.total ?? posts.data.length) === 1 ? "post" : "posts"}
        </p>
      </header>
      {posts.data.length === 0 ? (
        <p className="text-[color:var(--color-muted)]">{t("empty")}</p>
      ) : (
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {posts.data.map((p) => (
            <PostCard key={p.document_id} post={p} locale={locale} />
          ))}
        </div>
      )}
    </Container>
  );
}
