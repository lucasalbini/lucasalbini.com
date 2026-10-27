import type { getPathname as GetPathname } from "@/lib/i18n/routing";

type Href = Parameters<typeof GetPathname>[0]["href"];

/**
 * next-intl's Link needs the Next router at render time. Tests swap it for a plain
 * anchor that still resolves the public path through the real routing config, so a
 * wrong pathname or param still fails the test.
 *
 * Usage (the factory receives the real module, so there is no import cycle):
 *   vi.mock("@/lib/i18n/routing", async (io) => (await import("@/test/routing-mock")).mockRoutingLink(io));
 */
export async function mockRoutingLink(importOriginal: <T>() => Promise<T>) {
  const actual = await importOriginal<typeof import("@/lib/i18n/routing")>();
  function TestLink({
    href,
    children,
    ...rest
  }: { href: Href; children?: React.ReactNode } & Omit<React.AnchorHTMLAttributes<HTMLAnchorElement>, "href">) {
    return (
      <a href={actual.getPathname({ locale: "pt", href })} {...rest}>
        {children}
      </a>
    );
  }
  return { ...actual, Link: TestLink };
}
