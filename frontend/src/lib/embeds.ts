/** URL helpers for the social embeds (ADR-0002 §4.6). Editors paste whatever URL the
 *  app's share button gives them; these normalize it or return null. */

const YOUTUBE_ID = /^[\w-]{11}$/;

/** Video id from watch, youtu.be, shorts, live and embed URLs. */
export function youtubeId(url: string): string | null {
  let u: URL;
  try {
    u = new URL(url);
  } catch {
    return null;
  }
  const host = u.hostname.replace(/^(www\.|m\.)/, "");
  let id: string | null = null;
  if (host === "youtu.be") {
    id = u.pathname.slice(1).split("/")[0];
  } else if (host === "youtube.com" || host === "youtube-nocookie.com") {
    const [, first, second] = u.pathname.split("/");
    id = first === "watch" ? u.searchParams.get("v") : ["shorts", "live", "embed"].includes(first) ? second : null;
  }
  return id && YOUTUBE_ID.test(id) ? id : null;
}

/** Privacy-enhanced embed: no cookies until the reader presses play. */
export function youtubeEmbedUrl(id: string): string {
  return `https://www.youtube-nocookie.com/embed/${id}`;
}

/** Canonical permalink for a post, reel or IGTV link, without tracking params. */
export function instagramPermalink(url: string): string | null {
  let u: URL;
  try {
    u = new URL(url);
  } catch {
    return null;
  }
  if (u.hostname.replace(/^www\./, "") !== "instagram.com") return null;
  const match = u.pathname.match(/^\/(?:[\w.]+\/)?(p|reel|reels|tv)\/([\w-]+)/);
  if (!match) return null;
  const kind = match[1] === "reels" ? "reel" : match[1];
  return `https://www.instagram.com/${kind}/${match[2]}/`;
}

/** Google Maps search for a coordinate: what readers expect to tap on a phone. */
export function mapsUrl(latitude: number, longitude: number): string {
  return `https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}`;
}

/** "PDF · 1,2 MB" from Strapi's ext and size (kilobytes). */
export function fileInfo(ext: string | null | undefined, sizeKb: number | null | undefined): string {
  const parts: string[] = [];
  if (ext) parts.push(ext.replace(/^\./, "").toUpperCase());
  if (sizeKb != null) {
    parts.push(
      sizeKb >= 1024
        ? `${(sizeKb / 1024).toLocaleString("pt-BR", { maximumFractionDigits: 1 })} MB`
        : `${Math.max(1, Math.round(sizeKb))} KB`,
    );
  }
  return parts.join(" · ");
}
