import { ImageResponse } from "next/og";
import type { Locale } from "@/lib/i18n/routing";
import { getPost, getProject } from "@/lib/api";

export const runtime = "nodejs";
export const revalidate = 3600;

export async function GET(
  _req: Request,
  { params }: { params: Promise<{ locale: string; type: string; slug: string }> },
) {
  const { locale, type, slug } = await params;
  const loc = (locale === "pt" ? "pt" : "en") as Locale;

  let title = "Lucas Albini";
  let summary = "";
  if (type === "post") {
    const post = await getPost(loc, slug);
    if (post) {
      title = post.title;
      summary = post.summary;
    }
  } else if (type === "project") {
    const project = await getProject(loc, slug);
    if (project) {
      title = project.title;
      summary = project.summary;
    }
  }

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
        <div>
          <div style={{ fontSize: 72, fontWeight: 700, lineHeight: 1.1 }}>{title}</div>
          {summary && (
            <div style={{ marginTop: 24, fontSize: 30, color: "#9ca3af", lineHeight: 1.4 }}>
              {summary}
            </div>
          )}
        </div>
        <div style={{ display: "flex", justifyContent: "space-between", fontSize: 22, color: "#9ca3af" }}>
          <span>Lucas Albini</span>
          <span style={{ color: "#00D4AA" }}>{loc === "pt" ? "PT-BR" : "EN"}</span>
        </div>
      </div>
    ),
    { width: 1200, height: 630 },
  );
}
