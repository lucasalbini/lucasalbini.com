/**
 * Renders an itch.io game embed. Users paste the plain widget URL
 * (e.g. https://itch.io/embed/1234567) into `project.itch_embed_url` and
 * we frame it here. Height is roughly what itch expects.
 */
export function ItchEmbed({ url, title }: { url: string; title: string }) {
  return (
    <iframe
      src={url}
      title={title}
      loading="lazy"
      className="my-6 h-40 w-full rounded border border-[color:var(--color-border)]"
      frameBorder="0"
    />
  );
}
