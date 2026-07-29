import type { NextConfig } from "next";
import createNextIntlPlugin from "next-intl/plugin";

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
    // Legacy URLs from the pre-i18n site. Keep them working so any incoming
    // link still lands on the right page.
    return [
      { source: "/blog", destination: "/pt/blog", permanent: true },
      { source: "/blog/:slug", destination: "/pt/blog/:slug", permanent: true },
      { source: "/projects", destination: "/pt/projetos", permanent: true },
      { source: "/projects/:slug", destination: "/pt/projetos/:slug", permanent: true },
    ];
  },
};

export default withNextIntl(nextConfig);
