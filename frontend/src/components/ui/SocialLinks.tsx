import { FaGithub, FaLinkedin, FaEnvelope, FaXTwitter, FaItchIo } from "react-icons/fa6";
import clsx from "clsx";
import type { SocialLink } from "@/lib/types";

const ICONS: Record<string, React.ComponentType<{ className?: string }>> = {
  github: FaGithub,
  linkedin: FaLinkedin,
  email: FaEnvelope,
  twitter: FaXTwitter,
  x: FaXTwitter,
  itch: FaItchIo,
  "itch.io": FaItchIo,
};

export function SocialLinks({
  links,
  className = "text-[color:var(--color-muted)] hover:text-[color:var(--color-accent)]",
  size = "md",
}: {
  links: SocialLink[];
  className?: string;
  size?: "sm" | "md" | "lg";
}) {
  const sizeClass = size === "lg" ? "text-2xl" : size === "sm" ? "text-sm" : "text-lg";
  return (
    <div className={clsx("flex items-center gap-4", sizeClass)}>
      {links.map((l) => {
        const Icon = ICONS[l.platform?.toLowerCase()] ?? FaEnvelope;
        return (
          <a
            key={`${l.platform}-${l.url}`}
            href={l.url}
            aria-label={l.platform}
            className={clsx("transition-colors no-underline", className)}
            target="_blank"
            rel="noopener noreferrer"
          >
            <Icon />
          </a>
        );
      })}
    </div>
  );
}
