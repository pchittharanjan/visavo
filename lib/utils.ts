import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

// Date utilities used by components like `components/DocumentCard.tsx`
export function isExpired(date: Date): boolean {
  if (!(date instanceof Date) || Number.isNaN(date.getTime())) return false
  const today = new Date()
  const normalizedDate = new Date(date.getFullYear(), date.getMonth(), date.getDate())
  const normalizedToday = new Date(
    today.getFullYear(),
    today.getMonth(),
    today.getDate()
  )
  return normalizedDate < normalizedToday
}

export function getDaysUntilExpiry(date: Date): number {
  if (!(date instanceof Date) || Number.isNaN(date.getTime())) return 0
  const today = new Date()
  const normalizedDate = new Date(date.getFullYear(), date.getMonth(), date.getDate())
  const normalizedToday = new Date(
    today.getFullYear(),
    today.getMonth(),
    today.getDate()
  )
  const msPerDay = 24 * 60 * 60 * 1000
  const diffMs = normalizedDate.getTime() - normalizedToday.getTime()
  return Math.max(0, Math.ceil(diffMs / msPerDay))
}

export function formatDate(date: Date): string {
  if (!(date instanceof Date) || Number.isNaN(date.getTime())) return "—"
  return date.toLocaleDateString(undefined, {
    year: "numeric",
    month: "short",
    day: "numeric",
  })
}
