import { supabase } from './supabase'
import { UserDocument, TravelStatus } from './types'

// Enhanced cache with TTL and size limits
class OptimizedCache {
  private cache = new Map<string, { data: any; timestamp: number; ttl: number }>()
  private maxSize = 1000 // Maximum cache entries
  private defaultTTL = 10 * 60 * 1000 // 10 minutes

  set(key: string, data: any, ttl: number = this.defaultTTL): void {
    // Evict oldest entries if cache is full
    if (this.cache.size >= this.maxSize) {
      const oldestKey = this.cache.keys().next().value
      this.cache.delete(oldestKey)
    }

    this.cache.set(key, {
      data,
      timestamp: Date.now(),
      ttl
    })
  }

  get(key: string): any | null {
    const entry = this.cache.get(key)
    if (!entry) return null

    const isExpired = Date.now() - entry.timestamp > entry.ttl
    if (isExpired) {
      this.cache.delete(key)
      return null
    }

    return entry.data
  }

  clear(): void {
    this.cache.clear()
  }

  size(): number {
    return this.cache.size
  }
}

// Global cache instance
const requirementsCache = new OptimizedCache()

/**
 * Get visa requirements for multiple passport-destination combinations in one query
 */
export async function getBatchRequirements(
  passportCountries: string[],
  destinationCountries: string[]
): Promise<Map<string, any>> {
  try {
    // Create cache key for this batch
    const cacheKey = `batch-${passportCountries.sort().join(',')}-${destinationCountries.sort().join(',')}`
    const cached = requirementsCache.get(cacheKey)
    if (cached) {
      console.log(`📦 Using cached batch requirements (${requirementsCache.size()} items in cache)`)
      return cached
    }

    console.log(`🔍 Fetching batch requirements for ${passportCountries.length} passports × ${destinationCountries.length} destinations`)

    // Build the query with multiple passport countries
    const { data, error } = await supabase
      .from('visa_requirements')
      .select('*')
      .in('passport_country', passportCountries)
      .in('destination_country', destinationCountries)
      .eq('is_active', true)

    if (error) {
      console.error('Error fetching batch requirements:', error)
      return new Map()
    }

    // Create a map for fast lookups
    const requirementsMap = new Map<string, any>()
    data?.forEach(req => {
      const key = `${req.passport_country}-${req.destination_country}`
      requirementsMap.set(key, req)
    })

    // Cache the result for 5 minutes
    requirementsCache.set(cacheKey, requirementsMap, 5 * 60 * 1000)

    console.log(`✅ Fetched ${requirementsMap.size} requirements for batch query`)
    return requirementsMap

  } catch (error) {
    console.error('Error in getBatchRequirements:', error)
    return new Map()
  }
}

/**
 * Get optimized batch travel statuses for multiple countries
 */
export async function getOptimizedBatchStatuses(
  userDocuments: UserDocument[],
  countryCodes: string[]
): Promise<Record<string, TravelStatus>> {
  try {
    const passports = userDocuments.filter(doc => doc.document_type === 'passport')
    
    if (passports.length === 0) {
      const result: Record<string, TravelStatus> = {}
      countryCodes.forEach(code => result[code] = 'consulate_visa')
      return result
    }

    // Single passport - use fast path
    if (passports.length === 1) {
      return await getSinglePassportBatchStatuses(passports[0], countryCodes)
    }

    // Multiple passports - use optimized batch query
    const passportCountries = passports.map(p => p.issuing_country)
    const requirementsMap = await getBatchRequirements(passportCountries, countryCodes)

    const result: Record<string, TravelStatus> = {}
    
    for (const countryCode of countryCodes) {
      // Check for citizen status first
      const citizenPassport = passports.find(p => p.issuing_country === countryCode)
      if (citizenPassport) {
        result[countryCode] = 'citizen'
        continue
      }

      // Find best passport for this destination
      let bestStatus: TravelStatus = 'consulate_visa'
      let bestPassport = passports[0].issuing_country

      for (const passport of passports) {
        const key = `${passport.issuing_country}-${countryCode}`
        const requirements = requirementsMap.get(key)
        
        if (requirements) {
          const status = requirements.status as TravelStatus
          if (getStatusPriority(status) > getStatusPriority(bestStatus)) {
            bestStatus = status
            bestPassport = passport.issuing_country
          }
        }
      }

      result[countryCode] = bestStatus
    }

    return result

  } catch (error) {
    console.error('Error in getOptimizedBatchStatuses:', error)
    
    // Fallback to consulate visa for all countries
    const result: Record<string, TravelStatus> = {}
    countryCodes.forEach(code => result[code] = 'consulate_visa')
    return result
  }
}

/**
 * Fast path for single passport users
 */
async function getSinglePassportBatchStatuses(
  passport: UserDocument,
  countryCodes: string[]
): Promise<Record<string, TravelStatus>> {
  const passportCountry = passport.issuing_country
  
  // Get all requirements for this passport in one query
  const { data, error } = await supabase
    .from('visa_requirements')
    .select('*')
    .eq('passport_country', passportCountry)
    .in('destination_country', countryCodes)
    .eq('is_active', true)

  if (error) {
    console.error('Error fetching single passport requirements:', error)
    const result: Record<string, TravelStatus> = {}
    countryCodes.forEach(code => result[code] = 'consulate_visa')
    return result
  }

  // Create lookup map
  const requirementsMap = new Map<string, any>()
  data?.forEach(req => {
    requirementsMap.set(req.destination_country, req)
  })

  const result: Record<string, TravelStatus> = {}
  
  for (const countryCode of countryCodes) {
    // Check citizenship
    if (passport.issuing_country === countryCode) {
      result[countryCode] = 'citizen'
    } else {
      // Use database data
      const requirements = requirementsMap.get(countryCode)
      result[countryCode] = requirements?.status || 'consulate_visa'
    }
  }

  return result
}

/**
 * Get status priority for comparison
 */
function getStatusPriority(status: TravelStatus): number {
  const priorities: Record<TravelStatus, number> = {
    'citizen': 5,
    'visa_free': 4,
    'eta_required': 3,
    'evisa': 3,
    'visa_on_arrival': 2,
    'consulate_visa': 1,
    'banned': 0,
    'special_permission': 1
  }
  return priorities[status] || 0
}

/**
 * Clear the cache
 */
export function clearOptimizedCache(): void {
  requirementsCache.clear()
  console.log('🗑️ Cleared optimized requirements cache')
}

/**
 * Get cache statistics
 */
export function getCacheStats(): { size: number; maxSize: number } {
  return {
    size: requirementsCache.size(),
    maxSize: 1000
  }
}
