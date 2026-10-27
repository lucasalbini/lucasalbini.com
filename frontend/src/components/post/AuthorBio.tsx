import Image from "next/image";
import { useTranslations } from "next-intl";
import { Link } from "@/lib/i18n/routing";
import type { Profile } from "@/lib/types";
import { mediaUrl } from "@/lib/format";

/**
 * Required at the bottom of every post page. Someone landing from Google
 * needs to know who wrote what they just read, and how to reach them.
 */
export function AuthorBio({ profile }: { profile: Profile | null }) {
  const t = useTranslations("nav");
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
