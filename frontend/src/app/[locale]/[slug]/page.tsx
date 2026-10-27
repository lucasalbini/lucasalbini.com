import { notFound } from "next/navigation";
import { setRequestLocale } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostBlocks } from "@/components/post/blocks/BlockRenderer";
import { PostHeader } from "@/components/post/PostHeader";
import { MediaFigure } from "@/components/post/blocks/MediaFigure";
import { PostMeta } from "@/components/post/PostMeta";
import { AuthorBio } from "@/components/post/AuthorBio";
import { RelatedPosts } from "@/components/post/RelatedPosts";
import { getPost, getProfile, listPosts } from "@/lib/api";
import { absoluteUrl } from "@/lib/format";
import { pageMetadata } from "@/lib/metadata";

type Params = Promise<{ locale: Locale; slug: string }>;

export async function generateMetadata({ params }: { params: Params }) {
  const { slug } = await params;
  const post = await getPost(slug);
  if (!post) return {};
  return {
    ...pageMetadata({
      title: post.title,
      description: post.summary,
      ogImage: absoluteUrl(`/og/${slug}`),
      href: { pathname: "/[slug]", params: { slug } },
      noindex: post.visibility !== "public",
    }),
    openGraph: {
      title: post.title,
      description: post.summary,
      type: "article",
      locale: "pt_BR",
      publishedTime: post.published_at ?? undefined,
      images: [absoluteUrl(`/og/${slug}`)],
    },
  };
}

export default async function PostPage({ params }: { params: Params }) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const [post, profile] = await Promise.all([getPost(slug), getProfile()]);
  if (!post) notFound();
  const related = await listPosts({ category: post.category, pageSize: 10 });

  return (
    <Container size="wide" className="py-12 lg:py-16">
      {/* Desktop: facts column on the left, story on the right. Text and media share the
          right column's width, so no image is wider than the text it sits in. */}
      <div className="lg:grid lg:grid-cols-[11rem_minmax(0,1fr)] lg:gap-x-14">
        <aside className="hidden lg:block">
          <div className="sticky top-28">
            <PostMeta post={post} />
          </div>
        </aside>
        <div className="min-w-0">
          <PostHeader post={post} />
          {post.cover && <MediaFigure media={post.cover} layout="wide" sizes="(max-width: 1024px) 100vw, 50rem" />}

          <article className="prose-reading">
            <PostBlocks blocks={post.body} />
          </article>

          <AuthorBio profile={profile} />
          <RelatedPosts current={post} candidates={related.data} />
        </div>
      </div>
    </Container>
  );
}
