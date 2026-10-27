import { fileURLToPath } from "node:url";
import { defineConfig } from "vitest/config";

export default defineConfig({
  resolve: {
    alias: { "@": fileURLToPath(new URL("./src", import.meta.url)) },
  },
  esbuild: { jsx: "automatic" },
  test: {
    environment: "node",
    // next-intl imports `next/navigation` without an extension; inlining lets Vite resolve it.
    server: { deps: { inline: ["next-intl"] } },
    include: ["src/**/*.test.{ts,tsx}"],
    // Parsed markup includes iframes and <script src>; tests must never hit the network.
    environmentOptions: {
      happyDOM: {
        settings: {
          disableIframePageLoading: true,
          disableJavaScriptFileLoading: true,
          disableJavaScriptEvaluation: true,
          disableCSSFileLoading: true,
        },
      },
    },
    coverage: {
      provider: "v8",
      reporter: ["text", "cobertura"],
      // `all` lists untested files too, so diff-cover sees new code even when it has no test.
      all: true,
      include: ["src/lib/**", "src/components/**"],
      exclude: ["src/**/*.test.{ts,tsx}", "src/lib/api-types.ts"],
    },
  },
});
