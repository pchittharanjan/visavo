import { UserDocument, TravelStatus } from './types'
import { supabase } from './supabase'

// Priority order for visa statuses (higher = better)
const STATUS_PRIORITY: Record<TravelStatus, number> = {
  'citizen': 5,           // Highest priority - citizen status
  'visa_free': 4,         // Visa-free travel
  'eta_required': 3,      // Electronic Travel Authorization
  'evisa': 3,             // Electronic visa
  'visa_on_arrival': 2,   // Visa on arrival
  'consulate_visa': 1,    // Consulate visa required
  'banned': 0,            // Travel banned
  'special_permission': 1 // Special permission required
}

// Cache for passport requirements to avoid repeated database calls
const requirementsCache = new Map<string, any>()
const CACHE_DURATION = 5 * 60 * 1000 // 5 minutes

interface BestPassportResult {
  passport: string
  status: TravelStatus
  reason: string
  allOptions?: Array<{
    passport: string
    status: TravelStatus
    requirements?: any
  }>
}

/**
 * Get the best passport for a specific destination country
 */
export async function getBestPassportForDestination(
  passports: UserDocument[], 
  destinationCountry: string
): Promise<BestPassportResult> {
  try {
    // Validate inputs
    if (!passports || passports.length === 0) {
      throw new Error('No passports provided')
    }
    
    if (!destinationCountry || destinationCountry.length !== 2) {
      throw new Error('Invalid destination country code')
    }

    // Check for citizen status first (highest priority)
    const citizenPassport = passports.find(passport => 
      passport.issuing_country === destinationCountry
    )
    
    if (citizenPassport) {
      return {
        passport: citizenPassport.issuing_country,
        status: 'citizen',
        reason: `You are a citizen of ${destinationCountry}`
      }
    }

    // Get requirements for all passports
    const passportOptions = await Promise.all(
      passports.map(async (passport) => {
        try {
          const requirements = await getRequirementsForPassport(
            passport.issuing_country, 
            destinationCountry
          )
          
          return {
            passport: passport.issuing_country,
            status: requirements?.status || 'consulate_visa',
            requirements
          }
        } catch (error) {
          console.error(`Error getting requirements for ${passport.issuing_country} → ${destinationCountry}:`, error)
          // Return fallback status
          return {
            passport: passport.issuing_country,
            status: 'consulate_visa' as TravelStatus,
            requirements: null
          }
        }
      })
    )

    // Find the best option based on priority
    let bestOption = passportOptions[0]
    let bestScore = STATUS_PRIORITY[bestOption.status] || 0

    for (const option of passportOptions) {
      const score = STATUS_PRIORITY[option.status] || 0
      if (score > bestScore) {
        bestScore = score
        bestOption = option
      }
    }

    // Generate reason for the selection
    const reason = generateSelectionReason(bestOption, passportOptions)

    return {
      passport: bestOption.passport,
      status: bestOption.status,
      reason,
      allOptions: passportOptions
    }

  } catch (error) {
    console.error('Error in getBestPassportForDestination:', error)
    
    // Fallback to first passport
    const fallbackPassport = passports[0]?.issuing_country || 'US'
    return {
      passport: fallbackPassport,
      status: 'consulate_visa',
      reason: 'Using fallback due to error'
    }
  }
}

/**
 * Get visa requirements for a specific passport-destination combination
 */
async function getRequirementsForPassport(
  passportCountry: string, 
  destinationCountry: string
): Promise<any> {
  const cacheKey = `${passportCountry}-${destinationCountry}`
  const now = Date.now()
  
  // Check cache first
  const cached = requirementsCache.get(cacheKey)
  if (cached && (now - cached.timestamp) < CACHE_DURATION) {
    return cached.data
  }

  try {
    // Query database with timeout
    const timeoutPromise = new Promise((_, reject) => 
      setTimeout(() => reject(new Error('Database timeout')), 5000)
    )

    const queryPromise = supabase
      .from('visa_requirements')
      .select('*')
      .eq('passport_country', passportCountry)
      .eq('destination_country', destinationCountry)
      .eq('is_active', true)
      .single()

    const { data, error } = await Promise.race([queryPromise, timeoutPromise]) as any

    if (error) {
      console.error(`Database error for ${passportCountry} → ${destinationCountry}:`, error)
      return null
    }

    // Cache the result
    requirementsCache.set(cacheKey, {
      data,
      timestamp: now
    })

    return data

  } catch (error) {
    console.error(`Error getting requirements for ${passportCountry} → ${destinationCountry}:`, error)
    return null
  }
}

/**
 * Generate a human-readable reason for passport selection
 */
function generateSelectionReason(
  bestOption: any, 
  allOptions: any[]
): string {
  if (bestOption.status === 'citizen') {
    return `You are a citizen of this country`
  }

  const betterOptions = allOptions.filter(option => 
    STATUS_PRIORITY[option.status] === STATUS_PRIORITY[bestOption.status]
  )

  if (betterOptions.length === 1) {
    const statusName = getStatusDisplayName(bestOption.status)
    return `Using ${bestOption.passport} passport for ${statusName}`
  }

  if (betterOptions.length > 1) {
    const otherPassports = betterOptions
      .filter(option => option.passport !== bestOption.passport)
      .map(option => option.passport)
      .join(', ')
    
    const statusName = getStatusDisplayName(bestOption.status)
    return `Using ${bestOption.passport} passport (${statusName}). Other options: ${otherPassports}`
  }

  const statusName = getStatusDisplayName(bestOption.status)
  return `Using ${bestOption.passport} passport for ${statusName}`
}

/**
 * Get display name for status codes
 */
function getStatusDisplayName(status: TravelStatus): string {
  switch (status) {
    case 'visa_free': return 'visa-free travel'
    case 'eta_required': return 'ETA required'
    case 'evisa': return 'eVisa required'
    case 'visa_on_arrival': return 'visa on arrival'
    case 'consulate_visa': return 'consulate visa required'
    case 'banned': return 'travel restricted'
    case 'special_permission': return 'special permission required'
    case 'citizen': return 'citizen status'
    default: return status
  }
}

/**
 * Clear the requirements cache
 */
export function clearRequirementsCache(): void {
  requirementsCache.clear()
  console.log('🗑️ Cleared passport requirements cache')
}
