import createMiddleware from "next-intl/middleware";
import { routing } from "@/lib/i18n/routing";

export default createMiddleware(routing);

export const config = {
  // Match everything except:
  //  - Next internals (/_next, /_vercel)
  //  - the /api routes (revalidate) and /og images. /og can't live under /api:
  //    nginx sends /api/* to the FastAPI.
  //  - static assets with a file extension (feed.xml, sitemap.xml)
  matcher: ["/((?!api/|og/|_next|_vercel|.*\\..*).*)"],
};
