"use client";
import { cn } from "@/lib/utils";

interface FilterButtonProps {
  label: string;
  active: boolean;
  onClick: () => void;
}

export function FilterButton({ label, active, onClick }: FilterButtonProps) {
  return (
    <button
      onClick={onClick}
      className={cn(
        "rounded-full px-4 py-2 text-sm font-medium transition-colors",
        active
          ? "bg-primary text-background"
          : "bg-neutral text-muted hover:text-foreground"
      )}
    >
      {label}
    </button>
  );
}
