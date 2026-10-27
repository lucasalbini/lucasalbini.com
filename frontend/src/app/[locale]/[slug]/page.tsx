import { notFound } from "next/navigation";
import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostBody } from "@/components/post/PostBody";
import { AuthorBio } from "@/components/post/AuthorBio";
import { RelatedPosts } from "@/components/post/RelatedPosts";
import { getPost, getProfile, listPosts } from "@/lib/api";
import { formatDate, absoluteUrl } from "@/lib/format";
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

  const [post, profile, tPost, tCategories] = await Promise.all([
    getPost(slug),
    getProfile(),
    getTranslations("post"),
    getTranslations("categories"),
  ]);
  if (!post) notFound();
  const related = await listPosts({ category: post.category, pageSize: 10 });

  return (
    <Container size="reading" className="py-12">
      <header className="mb-8">
        <p className="label-mono">{tCategories(post.category)}</p>
        <h1 className="mt-2 text-3xl font-semibold tracking-tight text-[color:var(--color-fg)]">{post.title}</h1>
        <div className="mt-3 flex items-center gap-3 font-mono text-xs text-[color:var(--color-muted)]">
          {post.date && <time dateTime={post.date}>{formatDate(post.date, "pt")}</time>}
          {post.reading_time_minutes && <span>· {tPost("reading_time", { minutes: post.reading_time_minutes })}</span>}
        </div>
        <p className="mt-4 text-[color:var(--color-muted)]">{post.summary}</p>
      </header>

      <article className="prose-reading">
        <PostBody blocks={post.body.flatMap((b) => (b.type === "text" ? b.body : []))} />
      </article>

      <AuthorBio profile={profile} />
      <RelatedPosts current={post} candidates={related.data} />
    </Container>
  );
}
