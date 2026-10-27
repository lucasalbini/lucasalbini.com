import { notFound } from "next/navigation";
import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostList } from "@/components/post/PostList";
import { getTagAggregation } from "@/lib/api";
import { pageMetadata } from "@/lib/metadata";

type Params = Promise<{ locale: Locale; tag: string }>;

export async function generateMetadata({ params }: { params: Params }) {
  const { tag } = await params;
  const agg = await getTagAggregation(tag);
  if (!agg) return {};
  return pageMetadata({ title: `#${agg.tag.label}`, href: { pathname: "/tags/[tag]", params: { tag } } });
}

export default async function TagPage({ params }: { params: Params }) {
  const { locale, tag } = await params;
  setRequestLocale(locale);
  const [agg, t] = await Promise.all([getTagAggregation(tag), getTranslations("tags")]);
  if (!agg) notFound();

  return (
    <Container size="wide" className="py-16 sm:py-20">
      <header className="mb-12">
        <p className="label-mono">{t("title")}</p>
        <h1 className="mt-2 text-4xl font-bold tracking-tight text-[color:var(--color-fg)]">#{agg.tag.label}</h1>
      </header>
      <PostList posts={agg.posts} empty={t("empty")} />
    </Container>
  );
}
