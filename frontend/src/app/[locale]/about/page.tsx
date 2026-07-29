import Image from "next/image";
import { setRequestLocale, getTranslations } from "next-intl/server";
import { FaLocationDot } from "react-icons/fa6";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostBody } from "@/components/post/PostBody";
import { SocialLinks } from "@/components/ui/SocialLinks";
import { getCV, listPublications } from "@/lib/api";
import { mediaUrl, formatDate } from "@/lib/format";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "about" });
  return pageMetadata({ locale, title: t("title"), href: { pathname: "/about" } });
}

const SKILL_LABELS: Record<string, { pt: string; en: string }> = {
  language: { pt: "Linguagens", en: "Languages" },
  framework: { pt: "Frameworks", en: "Frameworks" },
  cloud: { pt: "Cloud", en: "Cloud" },
  ai_ml: { pt: "IA / ML", en: "AI / ML" },
  devops: { pt: "DevOps", en: "DevOps" },
  tools: { pt: "Ferramentas", en: "Tools" },
};

export default async function AboutPage({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const [cv, publications, t, tPub] = await Promise.all([
    getCV(locale),
    listPublications(locale),
    getTranslations({ locale, namespace: "about" }),
    getTranslations({ locale, namespace: "publications" }),
  ]);
  const { profile, experiences, education, certifications, skills } = cv;

  const skillsByCategory = skills.reduce<Record<string, typeof skills>>((acc, s) => {
    (acc[s.category] ||= []).push(s);
    return acc;
  }, {});

  return (
    <Container size="full" className="py-12">
      {profile && (
        <header className="mb-16 grid gap-8 md:grid-cols-[auto_1fr] md:items-start">
          {profile.avatar?.url && (
            <div className="relative h-28 w-28 shrink-0 overflow-hidden rounded-full border-4 border-[color:var(--color-primary)] shadow-md sm:h-36 sm:w-36">
              <Image
                src={mediaUrl(profile.avatar.url)}
                alt={profile.name}
                fill
                unoptimized
                className="object-cover"
                sizes="144px"
              />
            </div>
          )}
          <div>
            <h1 className="text-3xl font-bold text-[color:var(--color-fg)] sm:text-4xl">{profile.name}</h1>
            {profile.role && (
              <p className="mt-2 text-lg text-[color:var(--color-muted)]">
                {profile.role}
                {profile.company ? ` · ${profile.company}` : ""}
              </p>
            )}
            {profile.location && (
              <p className="mt-1 inline-flex items-center gap-1.5 text-sm text-[color:var(--color-muted)]">
                <FaLocationDot aria-hidden />
                {profile.location}
              </p>
            )}
            <div className="mt-5 flex flex-wrap items-center gap-4">
              {profile.social_links?.length > 0 && (
                <SocialLinks links={profile.social_links} size="md" />
              )}
              {profile.cv_pdf?.url && (
                <a
                  href={mediaUrl(profile.cv_pdf.url)}
                  download
                  className="inline-flex items-center gap-1.5 rounded-lg border border-[color:var(--color-primary)] px-3 py-1.5 font-mono text-xs text-[color:var(--color-primary)] no-underline transition-colors hover:bg-[color:var(--color-primary)] hover:text-white"
                >
                  {t("download_cv")} (PDF) ↓
                </a>
              )}
            </div>
          </div>
        </header>
      )}

      <div className="grid gap-12 lg:grid-cols-[minmax(0,2fr)_minmax(0,1fr)]">
        {/* Left column: bio + experience + education */}
        <div className="min-w-0">
          {profile?.long_bio && profile.long_bio.length > 0 && (
            <section className="prose-reading mb-16 max-w-none">
              <PostBody blocks={profile.long_bio} />
            </section>
          )}

          {experiences.length > 0 && (
            <section className="mb-16">
              <h2 className="mb-6 text-xs font-semibold uppercase tracking-[0.25em] text-[color:var(--color-muted)]">
                {t("experience")}
              </h2>
              <div className="relative space-y-8 border-l-2 border-[color:var(--color-border)] pl-6">
                {experiences.map((e) => (
                  <article key={e.document_id} className="relative">
                    <span className="absolute -left-[31px] top-1 h-3.5 w-3.5 rounded-full border-2 border-[color:var(--color-primary)] bg-[color:var(--color-bg)]" />
                    <h3 className="text-lg font-semibold text-[color:var(--color-fg)]">{e.company_name}</h3>
                    {e.company_location && (
                      <p className="text-xs text-[color:var(--color-muted)]">{e.company_location}</p>
                    )}
                    <ul className="mt-3 space-y-3">
                      {e.positions.map((p, i) => (
                        <li key={i}>
                          <div className="flex flex-wrap items-baseline gap-x-3 gap-y-1">
                            <span className="text-sm font-medium text-[color:var(--color-fg)]">
                              {p.designation}
                            </span>
                            <span className="font-mono text-xs text-[color:var(--color-muted)]">
                              {formatDate(p.start_date, locale, { month: "short", year: "numeric" })} —{" "}
                              {p.is_current
                                ? t("present")
                                : formatDate(p.end_date ?? "", locale, { month: "short", year: "numeric" })}
                            </span>
                          </div>
                          {p.responsibilities.length > 0 && (
                            <ul className="mt-2 list-disc space-y-1 pl-5 text-sm text-[color:var(--color-muted)]">
                              {p.responsibilities.map((r, j) => (
                                <li key={j}>{r.description}</li>
                              ))}
                            </ul>
                          )}
                        </li>
                      ))}
                    </ul>
                  </article>
                ))}
              </div>
            </section>
          )}

          {education.length > 0 && (
            <section>
              <h2 className="mb-6 text-xs font-semibold uppercase tracking-[0.25em] text-[color:var(--color-muted)]">
                {t("education")}
              </h2>
              <ul className="space-y-4">
                {education.map((ed) => (
                  <li
                    key={ed.document_id}
                    className="rounded-xl border border-[color:var(--color-border)] bg-[color:var(--color-surface)]/40 p-4"
                  >
                    <div className="font-semibold text-[color:var(--color-fg)]">{ed.institution}</div>
                    <div className="mt-1 text-sm text-[color:var(--color-muted)]">
                      {ed.degree}
                      {ed.field_of_study ? ` · ${ed.field_of_study}` : ""}
                    </div>
                    {ed.start_date && (
                      <div className="mt-1 font-mono text-xs text-[color:var(--color-muted)]">
                        {formatDate(ed.start_date, locale, { year: "numeric" })} —{" "}
                        {ed.end_date ? formatDate(ed.end_date, locale, { year: "numeric" }) : t("present")}
                      </div>
                    )}
                  </li>
                ))}
              </ul>
            </section>
          )}
        </div>

        {/* Right column: skills + certifications */}
        <aside className="min-w-0 space-y-12">
          {Object.keys(skillsByCategory).length > 0 && (
            <section>
              <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.25em] text-[color:var(--color-muted)]">
                Skills
              </h2>
              <div className="space-y-4">
                {Object.entries(skillsByCategory).map(([category, list]) => (
                  <div key={category}>
                    <p className="mb-2 font-mono text-[11px] uppercase tracking-widest text-[color:var(--color-muted)]">
                      {SKILL_LABELS[category]?.[locale] ?? category}
                    </p>
                    <div className="flex flex-wrap gap-1.5">
                      {list.map((s) => (
                        <span
                          key={s.document_id}
                          className="rounded-md border border-[color:var(--color-border)] bg-[color:var(--color-surface)]/60 px-2 py-1 text-xs text-[color:var(--color-fg)]"
                        >
                          {s.name}
                        </span>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {certifications.length > 0 && (
            <section>
              <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.25em] text-[color:var(--color-muted)]">
                {t("certifications")}
              </h2>
              <ul className="space-y-3">
                {certifications.map((c) => (
                  <li
                    key={c.document_id}
                    className="rounded-lg border border-[color:var(--color-border)] p-3 text-sm"
                  >
                    <div className="font-medium text-[color:var(--color-fg)]">
                      {c.credential_url ? <a href={c.credential_url}>{c.name}</a> : c.name}
                    </div>
                    {c.issuer && (
                      <div className="mt-0.5 text-xs text-[color:var(--color-muted)]">{c.issuer}</div>
                    )}
                    {c.issue_date && (
                      <div className="mt-1 font-mono text-[11px] text-[color:var(--color-muted)]">
                        {formatDate(c.issue_date, locale, { month: "short", year: "numeric" })}
                      </div>
                    )}
                  </li>
                ))}
              </ul>
            </section>
          )}
        </aside>
      </div>

      {/* Publications — full-width section anchored so /publicacoes redirect lands here. */}
      {publications.length > 0 && (
        <section id="publications" className="mt-20 scroll-mt-24">
          <div className="mb-6 flex items-baseline justify-between">
            <h2 className="text-xs font-semibold uppercase tracking-[0.25em] text-[color:var(--color-muted)]">
              {tPub("title")}
            </h2>
            <span className="font-mono text-xs text-[color:var(--color-muted)]">
              {publications.length}
            </span>
          </div>
          <ul className="grid gap-4 md:grid-cols-2">
            {publications.map((p) => (
              <li
                key={p.document_id}
                className="flex flex-col rounded-xl border border-[color:var(--color-border)] bg-[color:var(--color-bg)]/85 p-5 backdrop-blur-sm transition-colors hover:border-[color:var(--color-primary)]"
              >
                <h3 className="text-base font-semibold leading-snug text-[color:var(--color-fg)]">
                  {p.url ? <a href={p.url}>{p.title}</a> : p.title}
                </h3>
                {(p.journal || p.date) && (
                  <p className="mt-1.5 text-xs text-[color:var(--color-muted)]">
                    {p.journal}
                    {p.date ? ` · ${formatDate(p.date, locale, { year: "numeric" })}` : ""}
                  </p>
                )}
                {p.authors && (
                  <p className="mt-1 text-[11px] italic text-[color:var(--color-muted)]">{p.authors}</p>
                )}
                {p.abstract && (
                  <p className="mt-3 flex-1 text-sm text-[color:var(--color-fg)]/85">{p.abstract}</p>
                )}
                {p.doi && (
                  <p className="mt-3 font-mono text-[10px] text-[color:var(--color-muted)]">DOI: {p.doi}</p>
                )}
              </li>
            ))}
          </ul>
        </section>
      )}
    </Container>
  );
}
