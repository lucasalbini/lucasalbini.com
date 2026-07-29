import { NextResponse } from "next/server";
import { revalidateTag } from "next/cache";

/**
 * Called by the FastAPI webhook receiver after Strapi publishes content.
 * The FastAPI side signs by URL query rather than header (simpler for internal traffic).
 *
 *   POST /api/revalidate?tag=posts:pt&secret=<REVALIDATE_SECRET>
 */
export async function POST(req: Request) {
  const url = new URL(req.url);
  const tag = url.searchParams.get("tag");
  const secret = url.searchParams.get("secret");

  const expected = process.env.REVALIDATE_SECRET;
  if (!expected) {
    return NextResponse.json({ error: "REVALIDATE_SECRET not configured on the frontend" }, { status: 500 });
  }
  if (secret !== expected) {
    return NextResponse.json({ error: "invalid secret" }, { status: 401 });
  }
  if (!tag) {
    return NextResponse.json({ error: "missing tag" }, { status: 400 });
  }

  revalidateTag(tag);
  return NextResponse.json({ revalidated: true, tag });
}
