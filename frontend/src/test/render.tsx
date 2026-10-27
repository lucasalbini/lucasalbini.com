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

export interface ParsedMarkup {
  body: DocumentFragment;
  querySelector: DocumentFragment["querySelector"];
  querySelectorAll: DocumentFragment["querySelectorAll"];
}

/**
 * Parse rendered markup so tests can query it like a page. A <template> keeps the
 * content inert: iframes and scripts in it never try to load anything.
 */
export function dom(html: string): ParsedMarkup {
  const template = document.createElement("template");
  template.innerHTML = html;
  const body = template.content;
  return { body, querySelector: body.querySelector.bind(body), querySelectorAll: body.querySelectorAll.bind(body) };
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
