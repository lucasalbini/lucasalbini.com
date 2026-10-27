import { FeaturedPostCard, PostCard } from "@/components/cards/PostCard";
import type { PostSummary } from "@/lib/types";

/** Lead card on top, the rest in a two-column grid. Shared by archive, tag and collection pages. */
export function PostList({ posts, empty }: { posts: PostSummary[]; empty: string }) {
  if (posts.length === 0) return <p className="text-[color:var(--color-muted)]">{empty}</p>;
  const [lead, ...rest] = posts;
  return (
    <>
      <FeaturedPostCard post={lead} />
      {rest.length > 0 && (
        <div className="mt-16 grid gap-12 border-t border-[color:var(--color-border)] pt-12 sm:grid-cols-2 sm:gap-x-10">
          {rest.map((p) => (
            <PostCard key={p.document_id} post={p} />
          ))}
        </div>
      )}
    </>
  );
}
