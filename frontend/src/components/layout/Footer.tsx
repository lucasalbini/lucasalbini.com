import { FaHeart } from "react-icons/fa";

export function Footer() {
  return (
    <footer className="border-t border-border bg-background-alt py-8">
      <div className="mx-auto max-w-6xl px-4 text-center text-sm text-muted">
        <p className="flex items-center justify-center gap-1">
          Feito com <FaHeart className="text-red-500" /> por Lucas Albini
        </p>
        <p className="mt-2">&copy; {new Date().getFullYear()} Todos os direitos reservados.</p>
      </div>
    </footer>
  );
}
