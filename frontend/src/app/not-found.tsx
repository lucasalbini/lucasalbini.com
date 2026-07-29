import { redirect } from "next/navigation";

/**
 * Any 404 outside a [locale] segment redirects to the default locale's 404 page.
 * The middleware normally handles this, but static routes (like /favicon.ico)
 * that miss can trip the root 404.
 */
export default function NotFound() {
  redirect("/pt");
}
