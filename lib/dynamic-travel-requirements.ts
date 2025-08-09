import { supabase } from './supabase'
import { UserDocument, TravelStatus } from './types'
import { getAllRequirements } from './simple-database'
import { getBestPassportForDestination } from './best-passport-selector'

interface VisaStatusType {
  id: number
  code: string
  name: string
  description: string
  color: string
  is_active: boolean
}

// Cache for status types to avoid repeated database calls
let statusTypesCache: VisaStatusType[] | null = null
let cacheTimestamp: number = 0
const CACHE_DURATION = 5 * 60 * 1000 // 5 minutes

// Function to clear cache and force refresh
export function clearStatusTypesCache() {
  statusTypesCache = null
  cacheTimestamp = 0
  console.log('🗑️ Cleared status types cache')
}

// Function to force refresh status types (clear cache and reload)
export async function forceRefreshStatusTypes(): Promise<VisaStatusType[]> {
  clearStatusTypesCache()
  return await loadStatusTypes()
}

// Load status types from database
export async function loadStatusTypes(): Promise<VisaStatusType[]> {
  const now = Date.now()
  
  // Return cached data if still valid
  if (statusTypesCache && (now - cacheTimestamp) < CACHE_DURATION) {
    console.log('📦 Using cached status types')
    return statusTypesCache
  }

  console.log('🔄 Loading fresh status types from database')
  try {
    const { data, error } = await supabase
      .from('visa_status_types')
      .select('*')
      .eq('is_active', true)
      .order('id')

    if (error) {
      console.error('Error loading status types:', error)
      return []
    }

    // Update cache
    statusTypesCache = data || []
    cacheTimestamp = now
    
    console.log('✅ Loaded fresh status types:', statusTypesCache)
    return statusTypesCache
  } catch (error) {
    console.error('Error loading status types:', error)
    return []
  }
}

// Dynamic status color mapping based on database
export async function getDynamicStatusColor(status: string): Promise<string> {
  const statusTypes = await loadStatusTypes()
  const statusType = statusTypes.find(st => st.code === status)
  
  // Return the color from database if found, otherwise fallback to default
  return statusType?.color || '#6b7280' // gray as default
}

// Dynamic status label mapping based on database
export async function getDynamicStatusLabel(status: string): Promise<string> {
  const statusTypes = await loadStatusTypes()
  const statusType = statusTypes.find(st => st.code === status)
  
  return statusType ? statusType.name : status
}

// REMOVED: Hardcoded getStatusColor function - now using dynamic database colors

export function getStatusLabel(status: TravelStatus): string {
  // This maintains backward compatibility while we transition
  switch (status) {
    case 'visa_free': return 'Visa Free'
    case 'eta_required': return 'eTA Required'
    case 'visa_on_arrival': return 'Visa on Arrival'
    case 'evisa': return 'eVisa'
    case 'consulate_visa': return 'Consulate Visa Required'
    default: return 'Unknown Status'
  }
}

// Single passport status function (original logic for performance)
async function getSinglePassportStatuses(
  passport: UserDocument,
  countryCodes: string[]
): Promise<Record<string, TravelStatus>> {
  const primaryPassport = passport.issuing_country
  
  // Get database requirements
  const { data: requirements, error } = await supabase
    .from('visa_requirements')
    .select('*')
    .eq('passport_country', primaryPassport)
    .eq('is_active', true)

  const requirementsMap = new Map()
  requirements?.forEach(req => {
    const key = `${req.passport_country}-${req.destination_country}`
    requirementsMap.set(key, req.status)
  })

  console.log(`🌐 Using single passport logic for ${primaryPassport}`)

  const result: Record<string, TravelStatus> = {}
  
  for (const countryCode of countryCodes) {
    let bestStatus: TravelStatus = 'consulate_visa'
    
    // Check citizenship
    if (passport.issuing_country === countryCode) {
      bestStatus = 'citizen'
    }
    // Use database data
    else {
      const key = `${primaryPassport}-${countryCode}`
      const dbStatus = requirementsMap.get(key)
      if (dbStatus) {
        bestStatus = dbStatus as TravelStatus
      }
    }
    
    result[countryCode] = bestStatus
  }
  
  return result
}

// Removed special-case status overrides to avoid hardcoding

// Simplified travel requirements - passports only
export async function getSimpleTravelStatus(
  userDocuments: UserDocument[],
  destinationCountry: string
): Promise<TravelStatus> {
  try {
    // Get user's passports
    const passports = userDocuments.filter(doc => doc.document_type === 'passport')
    
    if (passports.length === 0) {
      return 'consulate_visa'
    }

    // Check if user is a citizen of the destination country
    const isCitizen = passports.some(passport => passport.issuing_country === destinationCountry)
    if (isCitizen) {
      return 'citizen'
    }

    // Use database for visa requirements
    const primaryPassport = passports[0].issuing_country
    console.log(`🌐 Getting visa requirements from database for ${primaryPassport} → ${destinationCountry}`)
    
    const requirements = await getAllRequirements(primaryPassport)
    const requirement = requirements.find(r => r.destination_country === destinationCountry)
    
    if (requirement) {
      console.log(`✅ Database visa requirement found: ${requirement.status}`)
      return requirement.status as TravelStatus
    }

    // Fallback to default
    console.warn(`No visa requirements found for ${primaryPassport} → ${destinationCountry}`)
    return 'consulate_visa'
  } catch (error) {
    console.error('Error getting simple travel status:', error)
    return 'consulate_visa'
  }
}

// Enhanced batch function with best passport selection
export async function getSimpleBatchTravelStatuses(
  userDocuments: UserDocument[],
  countryCodes: string[]
): Promise<Record<string, TravelStatus>> {
  try {
    // Get user's passports
    const passports = userDocuments.filter(doc => doc.document_type === 'passport')
    
    if (passports.length === 0) {
      const result: Record<string, TravelStatus> = {}
      countryCodes.forEach(code => result[code] = 'consulate_visa')
      return result
    }

    // If only one passport, use the old logic for performance
    if (passports.length === 1) {
      return await getSinglePassportStatuses(passports[0], countryCodes)
    }

    // Multiple passports - use best passport logic
    console.log(`🎯 Using best passport selection for ${passports.length} passports`)
    
    const result: Record<string, TravelStatus> = {}
    
    // Process each country with best passport selection
    for (const countryCode of countryCodes) {
      try {
        const bestPassport = await getBestPassportForDestination(passports, countryCode)
        result[countryCode] = bestPassport.status
        
        // Log the selection for debugging
        console.log(`🌍 ${countryCode}: Using ${bestPassport.passport} passport (${bestPassport.status}) - ${bestPassport.reason}`)
        
      } catch (error) {
        console.error(`Error getting best passport for ${countryCode}:`, error)
        // Fallback to first passport
        result[countryCode] = 'consulate_visa'
      }
    }
    
    return result
  } catch (error) {
    console.error('Error in simple batch travel statuses:', error)
    const result: Record<string, TravelStatus> = {}
    countryCodes.forEach(code => result[code] = 'consulate_visa')
    return result
  }
}

// Dynamic requirements text generator based on database
export async function getDynamicRequirementsText(status: string, countryCode: string, passportCountry: string): Promise<{
  passportValidity?: string
  allowedStay?: string
  notes?: string
  visaFee?: string
  processingTime?: string
}> {
  try {
    // Get status type info for description (always fetch fresh from database)
    const statusTypes = await loadStatusTypes()
    const statusType = statusTypes.find(st => st.code === status)
    
    // Get specific visa requirements from database
    const { data: visaRequirements, error } = await supabase
      .from('visa_requirements')
      .select('allowed_stay_days, visa_fee_amount, visa_fee_currency, notes, passport_validity_months')
      .eq('passport_country', passportCountry)
      .eq('destination_country', countryCode)
      .single()

    if (error) {
      console.error('Error fetching visa requirements:', error)
    }

    // Always use the description from visa_status_types (single source of truth)
    const description = statusType?.description || 'Check embassy website for current requirements.'

    // Fetch country-level passport validity text from countries table (preferred),
    // fall back to country_requirements if needed
    let countryPassportValidity: string | undefined
    try {
      const { data: countryRow, error: countryError } = await supabase
        .from('countries')
        .select('passport_validity')
        .eq('code', countryCode)
        .single()
      if (!countryError && countryRow && (countryRow as any).passport_validity) {
        countryPassportValidity = (countryRow as any).passport_validity as string
      }
    } catch (e) {
      console.warn('countries.passport_validity not available or query failed; will try country_requirements:', e)
    }
    if (!countryPassportValidity) {
      try {
        const { data: countryReq, error: countryReqError } = await supabase
          .from('country_requirements')
          .select('requirement_value')
          .eq('country_code', countryCode)
          .eq('requirement_type', 'passport_validity')
          .eq('is_active', true)
          .limit(1)
        if (!countryReqError && countryReq && countryReq.length > 0) {
          countryPassportValidity = countryReq[0]?.requirement_value as string | undefined
        }
      } catch (e) {
        console.error('Error fetching country passport validity from country_requirements:', e)
      }
    }
    
    // Format allowed stay
            const allowedStayDays = visaRequirements?.allowed_stay_days || 'Unknown'
    const allowedStayText = allowedStayDays || 'Varies by destination'

    // Format visa fee
    const visaFeeAmount = visaRequirements?.visa_fee_amount
    const visaFeeCurrency = visaRequirements?.visa_fee_currency
    const visaFeeText = visaFeeAmount && visaFeeCurrency
      ? `${visaFeeAmount} ${visaFeeCurrency}`
      : 'Varies'

    // Decide passport validity text with fallbacks
    const months = (visaRequirements as any)?.passport_validity_months as number | null | undefined
    const passportValidity = countryPassportValidity
      || (typeof months === 'number' && months > 0 ? `${months}+ months beyond stay` : 'Valid passport required')

    return {
      passportValidity,
      allowedStay: allowedStayText,
      notes: description, // Always use fresh description from status types
      visaFee: visaFeeText,
      processingTime: 'Varies'
    }
  } catch (error) {
    console.error('Error in getDynamicRequirementsText:', error)
    return {
      passportValidity: 'Valid passport required',
      allowedStay: 'Varies by destination',
      notes: 'Check embassy website for current requirements.',
      visaFee: 'Varies',
      processingTime: 'Varies'
    }
  }
}

// Simple requirements text generator (backward compatibility)
export function getRequirementsText(status: TravelStatus, countryCode: string): {
  passportValidity?: string
  allowedStay?: string
  notes?: string
  visaFee?: string
  processingTime?: string
} {
  switch (status) {
    case 'visa_free':
      return {
        passportValidity: 'Valid passport required',
        allowedStay: '90 days (typically)',
        notes: 'No visa required for tourism',
        visaFee: 'Free',
        processingTime: 'N/A'
      }
    case 'eta_required':
      return {
        passportValidity: 'Valid passport required',
        allowedStay: '90 days (typically)',
        notes: 'Electronic Travel Authorization required',
        visaFee: '$5-20 USD',
        processingTime: 'Immediate to 24 hours'
      }
    case 'visa_on_arrival':
      return {
        passportValidity: 'Valid passport required',
        allowedStay: '30-90 days',
        notes: 'Visa can be obtained at airport',
        visaFee: '$25-100 USD',
        processingTime: '15-30 minutes at airport'
      }
    case 'evisa':
      return {
        passportValidity: 'Valid passport required',
        allowedStay: '30-90 days',
        notes: 'Electronic visa required before travel',
        visaFee: '$25-100 USD',
        processingTime: '3-7 business days'
      }
    case 'consulate_visa':
      return {
        passportValidity: 'Valid passport required',
        allowedStay: 'Varies by visa type',
        notes: 'Visa must be obtained at consulate',
        visaFee: '$50-200 USD',
        processingTime: '1-4 weeks'
      }
    default:
      return {
        passportValidity: 'Valid passport required',
        allowedStay: 'Check with embassy',
        notes: 'Contact embassy for requirements',
        visaFee: 'Varies',
        processingTime: 'Varies'
      }
  }
} 