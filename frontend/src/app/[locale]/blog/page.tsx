import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostCard, FeaturedPostCard } from "@/components/cards/PostCard";
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

  const total = posts.pagination?.total ?? posts.data.length;
  const [lead, ...rest] = posts.data;

  return (
    <Container size="wide" className="py-16 sm:py-20">
      <header className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-[color:var(--color-fg)] sm:text-5xl">
          {t("title")}
        </h1>
        <p className="label-mono mt-3">
          {total} {total === 1 ? "post" : "posts"}
        </p>
      </header>
      {posts.data.length === 0 ? (
        <p className="text-[color:var(--color-muted)]">{t("empty")}</p>
      ) : (
        <>
          <FeaturedPostCard post={lead} locale={locale} />
          {rest.length > 0 && (
            <div className="mt-16 grid gap-12 border-t border-[color:var(--color-border)] pt-12 sm:grid-cols-2 sm:gap-x-10">
              {rest.map((p) => (
                <PostCard key={p.document_id} post={p} locale={locale} />
              ))}
            </div>
          )}
        </>
      )}
    </Container>
  );
}
