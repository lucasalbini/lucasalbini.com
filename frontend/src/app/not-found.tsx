import { redirect } from "next/navigation";

/**
 * Any 404 outside a [locale] segment redirects home.
 * The middleware normally handles this, but static routes (like /favicon.ico)
 * that miss can trip the root 404.
 */
export default function NotFound() {
  redirect("/");
}
