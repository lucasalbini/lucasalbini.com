"use client";
import { motion } from "framer-motion";
import { ReactNode } from "react";

interface SlideInProps {
  children: ReactNode;
  delay?: number;
  from?: "left" | "right";
  className?: string;
}

export function SlideIn({ children, delay = 0, from = "left", className }: SlideInProps) {
  return (
    <motion.div
      initial={{ opacity: 0, x: from === "left" ? -100 : 100 }}
      whileInView={{ opacity: 1, x: 0 }}
      viewport={{ once: true, margin: "-100px" }}
      transition={{ duration: 0.6, delay, ease: "easeOut" }}
      className={className}
    >
      {children}
    </motion.div>
  );
}
