import { ImageResponse } from "next/og";
import { getPost } from "@/lib/api";
import { formatDate } from "@/lib/format";

export const runtime = "nodejs";
export const revalidate = 3600;

export async function GET(_req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const post = await getPost(slug);
  const title = post?.title ?? "Lucas Albini";
  const summary = post?.summary ?? "";
  const date = formatDate(post?.date, "pt");

  return new ImageResponse(
    (
      <div
        style={{
          height: "100%",
          width: "100%",
          display: "flex",
          flexDirection: "column",
          justifyContent: "space-between",
          padding: "80px 90px",
          background: "#0a0a0a",
          color: "#ededed",
          fontFamily: "sans-serif",
        }}
      >
        <div style={{ fontSize: 28, color: "#9ca3af", letterSpacing: 2, textTransform: "uppercase" }}>
          lucasalbini.com
        </div>
        <div style={{ display: "flex", flexDirection: "column" }}>
          <div style={{ display: "flex", fontSize: 72, fontWeight: 700, lineHeight: 1.1 }}>{title}</div>
          {summary && (
            <div style={{ marginTop: 24, fontSize: 30, color: "#9ca3af", lineHeight: 1.4 }}>
              {summary}
            </div>
          )}
        </div>
        <div style={{ display: "flex", justifyContent: "space-between", fontSize: 22, color: "#9ca3af" }}>
          <span>Lucas Albini</span>
          <span style={{ color: "#00D4AA" }}>{date}</span>
        </div>
      </div>
    ),
    { width: 1200, height: 630 },
  );
}
