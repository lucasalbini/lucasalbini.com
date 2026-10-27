import type { NextConfig } from "next";
import createNextIntlPlugin from "next-intl/plugin";
import { LEGACY_REDIRECTS } from "./src/lib/redirects";

const withNextIntl = createNextIntlPlugin("./src/lib/i18n/request.ts");

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      { protocol: "http", hostname: "strapi", port: "1337" },
      { protocol: "http", hostname: "localhost", port: "1337" },
      { protocol: "http", hostname: "localhost" },
      { protocol: "http", hostname: "nginx" },
      { protocol: "https", hostname: "**" },
    ],
  },
  async redirects() {
    return LEGACY_REDIRECTS;
  },
};

export default withNextIntl(nextConfig);
