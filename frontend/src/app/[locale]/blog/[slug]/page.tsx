import { notFound } from "next/navigation";
import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostBody } from "@/components/post/PostBody";
import { AuthorBio } from "@/components/post/AuthorBio";
import { RelatedPosts } from "@/components/post/RelatedPosts";
import { TranslationNotice } from "@/components/post/TranslationNotice";
import { getPost, getProfile, listPosts, getTranslations as apiGetTranslations } from "@/lib/api";
import { formatDate, absoluteUrl } from "@/lib/format";
import { alternates } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale; slug: string }> }) {
  const { locale, slug } = await params;
  const post = await getPost(locale, slug);
  if (!post) return {};
  const translation = await apiGetTranslations("post", locale, slug);
  const altSlugs: { pt?: string | null; en?: string | null } = {};
  translation?.translations.forEach((t) => {
    if (t.locale === "pt-BR") altSlugs.pt = t.slug;
    if (t.locale === "en") altSlugs.en = t.slug;
  });
  return {
    title: post.title,
    description: post.summary,
    alternates: alternates({ href: { pathname: "/blog/[slug]", params: { slug: altSlugs[locale] ?? slug } } }),
    openGraph: {
      title: post.title,
      description: post.summary,
      type: "article",
      publishedTime: post.published_at ?? undefined,
      images: [absoluteUrl(`/api/og/${locale}/post/${slug}`)],
    },
  };
}

export default async function BlogPostPage({ params }: { params: Promise<{ locale: Locale; slug: string }> }) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const [post, profile, translation, tBlog] = await Promise.all([
    getPost(locale, slug),
    getProfile(locale),
    apiGetTranslations("post", locale, slug),
    getTranslations({ locale, namespace: "blog" }),
  ]);
  if (!post) notFound();

  // The requested locale has a fallback experience when the translation is missing —
  // we still render the post that exists (in the other locale) and show the notice.
  const apiLocaleCode = locale === "pt" ? "pt-BR" : "en";
  const isFallback = post.locale !== apiLocaleCode;

  const related = await listPosts(locale, { pageSize: 20 });

  return (
    <Container size="reading" className="py-12">
      {isFallback && <TranslationNotice locale={locale} />}

      <header className="mb-8">
        <h1 className="text-3xl font-semibold tracking-tight text-[color:var(--color-fg)]">{post.title}</h1>
        <div className="mt-3 flex items-center gap-3 font-mono text-xs text-[color:var(--color-muted)]">
          {post.published_at && (
            <time dateTime={post.published_at}>
              {tBlog("published_on", { date: formatDate(post.published_at, locale) })}
            </time>
          )}
          {post.reading_time_minutes && (
            <span>· {tBlog("reading_time", { minutes: post.reading_time_minutes })}</span>
          )}
        </div>
        <p className="mt-4 text-[color:var(--color-muted)]">{post.summary}</p>
      </header>

      <article className="prose-reading">
        <PostBody blocks={post.body} />
      </article>

      <AuthorBio profile={profile} locale={locale} />
      <RelatedPosts current={post} candidates={related.data} locale={locale} />

      <p className="mt-16 font-mono text-xs">
        <a href={`/${locale}/blog`}>{tBlog("back")}</a>
      </p>

      {/* Feed the LocaleSwitcher with alternate slugs so it can navigate correctly. */}
      <LocaleSwitcherSync translation={translation} />
    </Container>
  );
}

/** Small server component that side-loads translation slugs into a data attribute the
 * client LocaleSwitcher can read. Simpler than a context prop for a single page. */
function LocaleSwitcherSync({ translation }: { translation: Awaited<ReturnType<typeof apiGetTranslations>> }) {
  const map: Record<string, string> = {};
  translation?.translations.forEach((t) => {
    map[t.locale === "pt-BR" ? "pt" : t.locale] = t.slug;
  });
  return (
    <script
      id="__locale_alternates__"
      type="application/json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(map) }}
    />
  );
}
