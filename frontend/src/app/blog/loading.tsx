import { Skeleton } from "@/components/ui/Skeleton";

export default function BlogLoading() {
  return (
    <div className="section-container pt-24">
      <div className="mb-12 flex flex-col items-center">
        <Skeleton className="h-8 w-32 mb-4" />
        <Skeleton className="h-4 w-48" />
      </div>
      <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {Array.from({ length: 6 }).map((_, i) => (
          <div key={i} className="glass-card overflow-hidden !p-0">
            <Skeleton className="h-48 w-full" />
            <div className="space-y-3 p-5">
              <Skeleton className="h-5 w-3/4" />
              <Skeleton className="h-4 w-full" />
              <Skeleton className="h-3 w-1/3" />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
