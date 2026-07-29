import Image from "next/image";
import { getTranslations } from "next-intl/server";
import { Link } from "@/lib/i18n/routing";
import type { Locale } from "@/lib/i18n/routing";
import type { Profile } from "@/lib/types";
import { mediaUrl } from "@/lib/format";

/**
 * Required at the bottom of every blog/[slug] page. Someone landing from Google
 * needs to know who wrote what they just read, and how to reach them.
 */
export async function AuthorBio({ profile, locale }: { profile: Profile | null; locale: Locale }) {
  const t = await getTranslations({ locale, namespace: "nav" });
  if (!profile) return null;
  return (
    <aside className="mt-16 flex gap-4 border-t border-[color:var(--color-border)] pt-8">
      {profile.avatar?.url && (
        <div className="relative h-16 w-16 shrink-0 overflow-hidden rounded-full">
          <Image
            src={mediaUrl(profile.avatar.url)}
            alt={profile.name}
            fill
            unoptimized
            className="object-cover"
            sizes="64px"
          />
        </div>
      )}
      <div>
        <p className="font-semibold text-[color:var(--color-fg)]">{profile.name}</p>
        {profile.role && (
          <p className="text-sm text-[color:var(--color-muted)]">
            {profile.role}
            {profile.company ? ` · ${profile.company}` : ""}
          </p>
        )}
        {profile.short_bio && (
          <p className="mt-2 text-sm text-[color:var(--color-muted)]">{profile.short_bio}</p>
        )}
        <p className="mt-2 text-xs">
          <Link href="/about" className="font-mono">
            {t("about")} →
          </Link>
        </p>
      </div>
    </aside>
  );
}
