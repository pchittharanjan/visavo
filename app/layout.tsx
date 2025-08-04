import type { Metadata } from "next";
import { Inter, Gruppo } from "next/font/google";
import "./globals.css";

const inter = Inter({
  variable: "--font-inter",
  subsets: ["latin"],
  display: "swap",
  weight: ["400", "500", "600", "700"],
});

const gruppo = Gruppo({
  variable: "--font-gruppo",
  subsets: ["latin"],
  display: "swap",
  weight: "400",
});

export const metadata: Metadata = {
  title: "Visavo - Visa + Voyage",
  description: "Discover where you can travel based on your documents. Interactive visa-free travel planning tool.",
  keywords: ["visa", "travel", "passport", "tourism", "visa-free", "travel planning"],
  authors: [{ name: "Visavo Team" }],
  viewport: "width=device-width, initial-scale=1",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body
        className={`${inter.variable} ${gruppo.variable} antialiased`}
        suppressHydrationWarning
      >
        {children}
      </body>
    </html>
  );
}
