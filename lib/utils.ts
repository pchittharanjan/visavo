import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function formatDate(date: Date | string | null): string {
  if (!date) return 'No date set'
  
  const dateObj = typeof date === 'string' ? new Date(date) : date
  
  if (isNaN(dateObj.getTime())) {
    return 'Invalid date'
  }
  
  return dateObj.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

export function isExpired(date: Date | string | null): boolean {
  if (!date) return false
  
  const dateObj = typeof date === 'string' ? new Date(date) : date
  
  if (isNaN(dateObj.getTime())) {
    return false
  }
  
  return new Date() > dateObj
}

export function getDaysUntilExpiry(date: Date | string | null): number {
  if (!date) return 0
  
  const dateObj = typeof date === 'string' ? new Date(date) : date
  
  if (isNaN(dateObj.getTime())) {
    return 0
  }
  
  const today = new Date()
  const diffTime = dateObj.getTime() - today.getTime()
  return Math.ceil(diffTime / (1000 * 60 * 60 * 24))
} 