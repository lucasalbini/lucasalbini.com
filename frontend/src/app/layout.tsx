import type { Metadata } from "next";
import { Inter } from "next/font/google";
import { ThemeProvider } from "@/providers/ThemeProvider";
import "./globals.css";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Lucas Albini - Tech Lead em IA",
  description:
    "Tech Lead com experiência em IA Generativa, Computer Vision e Machine Learning. 4x AWS Certified.",
  openGraph: {
    title: "Lucas Albini - Tech Lead em IA",
    description:
      "Tech Lead com experiência em IA Generativa, Computer Vision e Machine Learning.",
    type: "website",
  },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pt" suppressHydrationWarning>
      <body className={inter.className}>
        <ThemeProvider>{children}</ThemeProvider>
      </body>
    </html>
  );
}
