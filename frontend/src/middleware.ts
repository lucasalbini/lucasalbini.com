import createMiddleware from "next-intl/middleware";
import { routing } from "@/lib/i18n/routing";

export default createMiddleware(routing);

export const config = {
  // Match everything except:
  //  - Next internals (/_next, /_vercel)
  //  - the /api routes (revalidate, og, feed)
  //  - static assets with a file extension
  matcher: ["/((?!api|_next|_vercel|.*\\..*).*)"],
};
