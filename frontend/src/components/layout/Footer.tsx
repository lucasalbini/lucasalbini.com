import { getTranslations } from "next-intl/server";
import { FaRss } from "react-icons/fa6";
import { Container } from "./Container";
import { SocialLinks } from "@/components/ui/SocialLinks";
import type { SocialLink } from "@/lib/types";

/** `year` comes from the caller so the footer stays a pure function of its props. */
export async function Footer({ links, year }: { links: SocialLink[]; year: number }) {
  const t = await getTranslations("footer");

  return (
    <footer className="mt-8 border-t border-[color:var(--color-border)] py-10 text-sm text-[color:var(--color-muted)]">
      <Container size="wide" className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <p>© {year} · {t("rights")}</p>
        <div className="flex items-center gap-4">
          <SocialLinks links={links} size="md" />
          <a
            href="/feed.xml"
            aria-label="RSS"
            className="text-lg text-[color:var(--color-muted)] no-underline transition-colors hover:text-[color:var(--color-accent)]"
          >
            <FaRss />
          </a>
        </div>
      </Container>
    </footer>
  );
}
