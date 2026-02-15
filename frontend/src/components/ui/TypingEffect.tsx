"use client";
import { useState, useEffect } from "react";

interface TypingEffectProps {
  titles: string[];
  typingSpeed?: number;
  deletingSpeed?: number;
  pauseTime?: number;
}

export function TypingEffect({
  titles,
  typingSpeed = 100,
  deletingSpeed = 50,
  pauseTime = 2000,
}: TypingEffectProps) {
  const [text, setText] = useState("");
  const [titleIndex, setTitleIndex] = useState(0);
  const [isDeleting, setIsDeleting] = useState(false);

  useEffect(() => {
    if (!titles.length) return;
    const current = titles[titleIndex];

    const timeout = setTimeout(
      () => {
        if (!isDeleting) {
          setText(current.slice(0, text.length + 1));
          if (text.length + 1 === current.length) {
            setTimeout(() => setIsDeleting(true), pauseTime);
          }
        } else {
          setText(current.slice(0, text.length - 1));
          if (text.length === 0) {
            setIsDeleting(false);
            setTitleIndex((prev) => (prev + 1) % titles.length);
          }
        }
      },
      isDeleting ? deletingSpeed : typingSpeed
    );

    return () => clearTimeout(timeout);
  }, [text, isDeleting, titleIndex, titles, typingSpeed, deletingSpeed, pauseTime]);

  return (
    <span className="text-primary">
      {text}
      <span className="animate-pulse">|</span>
    </span>
  );
}
