import { renderToStaticMarkup } from "react-dom/server";
import { NextIntlClientProvider } from "next-intl";
import messages from "../../messages/pt.json";

/** Server-render a component with the real Portuguese messages. */
export function render(ui: React.ReactElement): string {
  return renderToStaticMarkup(
    <NextIntlClientProvider locale="pt" messages={messages} timeZone="America/Sao_Paulo">
      {ui}
    </NextIntlClientProvider>,
  );
}

/** Parse rendered markup so tests can query it like a page. */
export function dom(html: string): Document {
  return new DOMParser().parseFromString(html, "text/html");
}

/**
 * Stand-in for `next-intl/server` in tests: async server components get the same
 * Portuguese messages the client provider uses.
 *   vi.mock("next-intl/server", async () => (await import("@/test/render")).intlServerMock());
 */
export async function intlServerMock() {
  const { createTranslator } = await import("next-intl");
  return {
    getTranslations: async (namespace?: string) =>
      createTranslator({ locale: "pt", messages, namespace: namespace as never }),
  };
}
