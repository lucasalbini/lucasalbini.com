import { notFound } from "next/navigation";
import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostList } from "@/components/post/PostList";
import { getCollection } from "@/lib/api";
import { pageMetadata } from "@/lib/metadata";

type Params = Promise<{ locale: Locale; slug: string }>;

export async function generateMetadata({ params }: { params: Params }) {
  const { slug } = await params;
  const collection = await getCollection(slug);
  if (!collection) return {};
  return pageMetadata({
    title: collection.title,
    description: collection.description ?? undefined,
    href: { pathname: "/collections/[slug]", params: { slug } },
  });
}

export default async function CollectionPage({ params }: { params: Params }) {
  const { locale, slug } = await params;
  setRequestLocale(locale);
  const [collection, t] = await Promise.all([getCollection(slug), getTranslations("collection")]);
  if (!collection) notFound();

  return (
    <Container size="wide" className="py-16 sm:py-20">
      <header className="mb-12">
        <p className="label-mono">{t("label")}</p>
        <h1 className="mt-2 text-4xl font-bold tracking-tight text-[color:var(--color-fg)] sm:text-5xl">{collection.title}</h1>
        {collection.description && (
          <p className="mt-4 max-w-[60ch] text-[color:var(--color-muted)]">{collection.description}</p>
        )}
      </header>
      <PostList posts={collection.posts} empty={t("empty")} />
    </Container>
  );
}
