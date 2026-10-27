/**
 * Legacy URLs → current ones (ADR-0002 §3.5). Links to the bilingual site are out in
 * the wild (LinkedIn, old posts, search results); every one of them must still land.
 * Order matters: Next applies the first rule that matches.
 */
export interface Redirect {
  source: string;
  destination: string;
  permanent: true;
}

const r = (source: string, destination: string): Redirect => ({ source, destination, permanent: true });

export const LEGACY_REDIRECTS: Redirect[] = [
  // Posts used to live under /blog, with or without a locale prefix.
  r("/:locale(pt|en)/blog/:slug", "/:slug"),
  r("/blog/:slug", "/:slug"),
  r("/:locale(pt|en)/blog", "/arquivo"),
  r("/blog", "/arquivo"),
  // Projects are posts now, under the "projetos" category.
  r("/pt/projetos/:slug", "/:slug"),
  r("/:locale(pt|en)/projects/:slug", "/:slug"),
  r("/projects/:slug", "/:slug"),
  r("/pt/projetos", "/arquivo/projetos"),
  r("/:locale(pt|en)/projects", "/arquivo/projetos"),
  r("/projects", "/arquivo/projetos"),
  // Lab notes are the "ideias" category.
  r("/:locale(pt|en)/lab", "/arquivo/ideias"),
  // About and the publications that moved inside it.
  r("/en/about", "/sobre"),
  r("/about", "/sobre"),
  r("/pt/publicacoes", "/sobre#publications"),
  r("/:locale(pt|en)/publications", "/sobre#publications"),
  r("/publications", "/sobre#publications"),
  // Whatever else kept a locale prefix just drops it.
  r("/:locale(pt|en)", "/"),
  r("/:locale(pt|en)/:path*", "/:path*"),
];
