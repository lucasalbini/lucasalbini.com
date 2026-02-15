import { Skeleton } from "@/components/ui/Skeleton";

export default function Loading() {
  return (
    <div className="min-h-screen">
      {/* Hero skeleton */}
      <div className="flex min-h-screen items-center justify-center bg-background-alt">
        <div className="flex flex-col items-center gap-6">
          <Skeleton className="h-40 w-40 rounded-full" />
          <Skeleton className="h-10 w-64" />
          <Skeleton className="h-6 w-48" />
          <div className="flex gap-4">
            <Skeleton className="h-8 w-8 rounded-full" />
            <Skeleton className="h-8 w-8 rounded-full" />
            <Skeleton className="h-8 w-8 rounded-full" />
          </div>
        </div>
      </div>

      {/* Section skeletons */}
      <div className="section-container">
        <div className="mb-12 flex flex-col items-center">
          <Skeleton className="h-8 w-48 mb-4" />
          <Skeleton className="h-4 w-32" />
        </div>
        <div className="grid gap-4 md:grid-cols-2">
          <Skeleton className="h-48" />
          <Skeleton className="h-48" />
        </div>
      </div>
    </div>
  );
}
