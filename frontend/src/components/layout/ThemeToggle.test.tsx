// @vitest-environment happy-dom
import { act } from "react";
import { createRoot } from "react-dom/client";
import { describe, expect, it, vi } from "vitest";
import { NextIntlClientProvider } from "next-intl";
import messages from "../../../messages/pt.json";
import { ThemeToggle } from "@/components/layout/ThemeToggle";

const theme = vi.hoisted(() => ({ resolvedTheme: "light", setTheme: vi.fn() }));
vi.mock("next-themes", () => ({ useTheme: () => theme }));

async function mount() {
  const container = document.createElement("div");
  await act(async () => {
    createRoot(container).render(
      <NextIntlClientProvider locale="pt" messages={messages}>
        <ThemeToggle />
      </NextIntlClientProvider>,
    );
  });
  return container.querySelector("button")!;
}

describe("ThemeToggle", () => {
  it("switches a light page to dark", async () => {
    theme.resolvedTheme = "light";
    const button = await mount();

    act(() => button.click());

    expect(theme.setTheme).toHaveBeenLastCalledWith("dark");
  });

  it("switches a dark page to light", async () => {
    theme.resolvedTheme = "dark";
    const button = await mount();

    act(() => button.click());

    expect(theme.setTheme).toHaveBeenLastCalledWith("light");
  });

  it("is labelled for screen readers", async () => {
    expect((await mount()).getAttribute("aria-label")).toBe("Alternar tema");
  });
});
