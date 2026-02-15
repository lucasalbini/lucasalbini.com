import { FaGithub, FaLinkedin, FaEnvelope, FaTwitter } from "react-icons/fa";
import type { SocialLink } from "@/lib/types";

const iconMap: Record<string, React.ComponentType<{ className?: string }>> = {
  github: FaGithub,
  linkedin: FaLinkedin,
  email: FaEnvelope,
  twitter: FaTwitter,
};

interface SocialLinksProps {
  links: SocialLink[];
  size?: "sm" | "md" | "lg";
}

export function SocialLinks({ links, size = "md" }: SocialLinksProps) {
  const sizeClasses = { sm: "text-lg", md: "text-2xl", lg: "text-3xl" };
  return (
    <div className="flex items-center gap-4">
      {links.map((link) => {
        const Icon = iconMap[link.platform.toLowerCase()] || FaGithub;
        const href = link.platform.toLowerCase() === "email" ? `mailto:${link.url}` : link.url;
        return (
          <a
            key={link.id}
            href={href}
            target="_blank"
            rel="noopener noreferrer"
            className={`${sizeClasses[size]} text-muted transition-colors hover:text-primary`}
          >
            <Icon />
          </a>
        );
      })}
    </div>
  );
}
