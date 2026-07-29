import Image from "next/image";
import { setRequestLocale, getTranslations } from "next-intl/server";
import type { Locale } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";
import { PostBody } from "@/components/post/PostBody";
import { getCV } from "@/lib/api";
import { mediaUrl, formatDate } from "@/lib/format";
import { pageMetadata } from "@/lib/metadata";

export async function generateMetadata({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "about" });
  return pageMetadata({ locale, title: t("title"), href: { pathname: "/about" } });
}

export default async function AboutPage({ params }: { params: Promise<{ locale: Locale }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const [cv, t] = await Promise.all([
    getCV(locale),
    getTranslations({ locale, namespace: "about" }),
  ]);
  const { profile, experiences, education, certifications } = cv;

  return (
    <Container size="reading" className="py-12">
      {profile && (
        <header className="mb-12 flex flex-col gap-4 sm:flex-row sm:items-start">
          {profile.avatar?.url && (
            <div className="relative h-24 w-24 shrink-0 overflow-hidden rounded-full">
              <Image
                src={mediaUrl(profile.avatar.url)}
                alt={profile.name}
                fill
                unoptimized
                className="object-cover"
                sizes="96px"
              />
            </div>
          )}
          <div>
            <h1 className="text-2xl font-semibold">{profile.name}</h1>
            {profile.role && (
              <p className="mt-1 text-sm text-[color:var(--color-muted)]">
                {profile.role}
                {profile.company ? ` · ${profile.company}` : ""}
                {profile.location ? ` · ${profile.location}` : ""}
              </p>
            )}
            {profile.cv_pdf?.url && (
              <p className="mt-3 font-mono text-xs">
                <a href={mediaUrl(profile.cv_pdf.url)} download>
                  {t("download_cv")} (PDF) ↓
                </a>
              </p>
            )}
          </div>
        </header>
      )}

      {profile?.long_bio && profile.long_bio.length > 0 && (
        <section className="prose-reading mb-12">
          <PostBody blocks={profile.long_bio} />
        </section>
      )}

      {experiences.length > 0 && (
        <section className="mb-12">
          <h2 className="mb-4 text-sm font-semibold uppercase tracking-widest text-[color:var(--color-muted)]">
            {t("experience")}
          </h2>
          <div className="space-y-6">
            {experiences.map((e) => (
              <article key={e.document_id}>
                <h3 className="font-semibold">
                  {e.company_name}
                  {e.company_location ? <span className="ml-2 text-sm font-normal text-[color:var(--color-muted)]">— {e.company_location}</span> : null}
                </h3>
                <ul className="mt-2 space-y-2">
                  {e.positions.map((p, i) => (
                    <li key={i} className="text-sm">
                      <div className="flex items-baseline gap-3">
                        <span className="font-mono text-xs text-[color:var(--color-muted)]">
                          {formatDate(p.start_date, locale, { month: "short", year: "numeric" })} —{" "}
                          {p.is_current ? t("present") : formatDate(p.end_date ?? "", locale, { month: "short", year: "numeric" })}
                        </span>
                        <span>{p.designation}</span>
                      </div>
                      {p.responsibilities.length > 0 && (
                        <ul className="mt-1 list-disc pl-6 text-[color:var(--color-muted)]">
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
        <section className="mb-12">
          <h2 className="mb-4 text-sm font-semibold uppercase tracking-widest text-[color:var(--color-muted)]">
            {t("education")}
          </h2>
          <ul className="space-y-3 text-sm">
            {education.map((ed) => (
              <li key={ed.document_id}>
                <div className="font-semibold">{ed.institution}</div>
                <div className="text-[color:var(--color-muted)]">
                  {ed.degree}{ed.field_of_study ? ` · ${ed.field_of_study}` : ""}
                  {ed.start_date && <span> · {formatDate(ed.start_date, locale, { year: "numeric" })} — {ed.end_date ? formatDate(ed.end_date, locale, { year: "numeric" }) : t("present")}</span>}
                </div>
              </li>
            ))}
          </ul>
        </section>
      )}

      {certifications.length > 0 && (
        <section>
          <h2 className="mb-4 text-sm font-semibold uppercase tracking-widest text-[color:var(--color-muted)]">
            {t("certifications")}
          </h2>
          <ul className="space-y-2 text-sm">
            {certifications.map((c) => (
              <li key={c.document_id} className="flex items-baseline justify-between gap-4">
                <span>
                  {c.credential_url ? <a href={c.credential_url}>{c.name}</a> : c.name}
                  {c.issuer ? <span className="ml-2 text-[color:var(--color-muted)]">— {c.issuer}</span> : null}
                </span>
                {c.issue_date && (
                  <time className="shrink-0 font-mono text-xs text-[color:var(--color-muted)]">
                    {formatDate(c.issue_date, locale, { month: "short", year: "numeric" })}
                  </time>
                )}
              </li>
            ))}
          </ul>
        </section>
      )}
    </Container>
  );
}
