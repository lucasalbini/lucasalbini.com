"use client";

import { useState } from "react";
import { cn } from "@/lib/utils";

const locales = [
  { code: "pt", label: "PT" },
  { code: "en", label: "EN" },
];

export function LanguageSwitcher() {
  const [currentLocale, setCurrentLocale] = useState("pt");

  return (
    <div className="flex items-center gap-1 rounded-full bg-neutral p-1">
      {locales.map((locale) => (
        <button
          key={locale.code}
          onClick={() => setCurrentLocale(locale.code)}
          className={cn(
            "rounded-full px-2 py-1 text-xs font-medium transition-colors",
            currentLocale === locale.code
              ? "bg-primary text-background"
              : "text-muted hover:text-foreground"
          )}
        >
          {locale.label}
        </button>
      ))}
    </div>
  );
}
