import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { SectionHeading } from "@/components/ui/SectionHeading";
import { Hero } from "@/components/home/Hero";
import { FeaturedPostCard, PostRow } from "@/components/cards/PostCard";
import { getProfile, listPosts } from "@/lib/api";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata() {
  const t = await getTranslations("meta");
  return pageMetadata({ title: t("site_title"), description: t("site_description"), href: "/" });
}

export default async function HomePage({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);

  const [profile, recent, tHome] = await Promise.all([
    getProfile(),
    listPosts({ pageSize: 6 }),
    getTranslations("home"),
  ]);
  const [lead, ...rest] = recent.data;

  return (
    <Container size="wide">
      <Hero profile={profile} />
      {lead && (
        <section className="pb-20 sm:pb-24">
          <SectionHeading title={tHome("recent")} linkHref="/archive" linkLabel={tHome("recent_all")} />
          <FeaturedPostCard post={lead} />
          {rest.length > 0 && (
            <ul className="mt-10 divide-y divide-[color:var(--color-border)] border-t border-[color:var(--color-border)]">
              {rest.map((p) => (
                <PostRow key={p.document_id} post={p} />
              ))}
            </ul>
          )}
        </section>
      )}
    </Container>
  );
}

export const revalidate = 300;
