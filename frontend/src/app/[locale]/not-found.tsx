import { getTranslations } from "next-intl/server";
import { Link } from "@/lib/i18n/routing";
import { Container } from "@/components/layout/Container";

export default async function NotFound() {
  const t = await getTranslations("not_found");
  return (
    <Container size="reading" className="py-24">
      <h1 className="text-2xl font-semibold">{t("title")}</h1>
      <p className="mt-2 text-[color:var(--color-muted)]">{t("description")}</p>
      <p className="mt-6">
        <Link href="/">{t("home")}</Link>
      </p>
    </Container>
  );
}
