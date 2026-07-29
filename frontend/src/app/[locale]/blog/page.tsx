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
    <Container size="reading" className="py-12">
      <h1 className="mb-8 text-2xl font-semibold">{t("title")}</h1>
      {posts.data.length === 0 ? (
        <p className="text-[color:var(--color-muted)]">{t("empty")}</p>
      ) : (
        <div>
          {posts.data.map((p) => (
            <PostCard key={p.document_id} post={p} locale={locale} />
          ))}
        </div>
      )}
    </Container>
  );
}
