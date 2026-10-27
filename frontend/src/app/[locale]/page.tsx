import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { Hero } from "@/components/home/Hero";
import { CollectionsList, NowSection, VideoGrid } from "@/components/home/HomeSections";
import { FeaturedPostCard, PostCard } from "@/components/cards/PostCard";
import { getLatestVideos, getProfile, listCollections, listPosts } from "@/lib/api";
import { findSocialLink, pickHomePosts } from "@/lib/home";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata() {
  const t = await getTranslations("meta");
  return pageMetadata({ title: t("site_title"), description: t("site_description"), href: "/" });
}

export default async function HomePage({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);

  const [profile, featured, recent, videos, collections, t] = await Promise.all([
    getProfile(),
    listPosts({ featured: true, pageSize: 3 }),
    listPosts({ pageSize: 7 }),
    getLatestVideos(3),
    listCollections().catch(() => []),
    getTranslations("home"),
  ]);
  const { lead, rest } = pickHomePosts(featured.data, recent.data);
  const youtube = findSocialLink(profile?.social_links ?? [], "youtube");

  return (
    <Container size="wide">
      <Hero profile={profile} />
      <NowSection text={profile?.now ?? null} />

      {lead && (
        <section className="pb-20 sm:pb-24">
          <SectionHeading title={t("recent")} linkHref="/archive" linkLabel={t("recent_all")} />
          <FeaturedPostCard post={lead} />
          {rest.length > 0 && (
            <div className="mt-14 grid gap-12 sm:grid-cols-2 sm:gap-x-10 lg:grid-cols-3">
              {rest.map((p) => (
                <PostCard key={p.document_id} post={p} />
              ))}
            </div>
          )}
        </section>
      )}

      <VideoGrid videos={videos} channelUrl={youtube?.url ?? null} />
      <CollectionsList collections={collections} />
    </Container>
  );
}

export const revalidate = 300;
