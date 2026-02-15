import { Skeleton } from "@/components/ui/Skeleton";

export default function ProjectsLoading() {
  return (
    <div className="section-container pt-24">
      <div className="mb-12 flex flex-col items-center">
        <Skeleton className="h-8 w-32 mb-4" />
        <Skeleton className="h-4 w-48" />
      </div>
      <div className="mb-8 flex justify-center gap-2">
        {Array.from({ length: 4 }).map((_, i) => (
          <Skeleton key={i} className="h-9 w-24 rounded-full" />
        ))}
      </div>
      <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {Array.from({ length: 6 }).map((_, i) => (
          <div key={i} className="glass-card space-y-3">
            <Skeleton className="h-5 w-2/3" />
            <Skeleton className="h-4 w-full" />
            <Skeleton className="h-4 w-3/4" />
            <div className="flex gap-2">
              <Skeleton className="h-5 w-16 rounded" />
              <Skeleton className="h-5 w-16 rounded" />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
