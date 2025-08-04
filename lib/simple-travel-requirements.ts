import { supabase } from './supabase'
import { UserDocument, TravelStatus } from './types'
import { travelBuddyAPI } from './travel-buddy-api'

// Status color mapping
export function getStatusColor(status: TravelStatus): string {
  switch (status) {
    case 'visa_free':
      return '#10b981' // green-500
    case 'eta_required':
      return '#3b82f6' // blue-500
    case 'visa_on_arrival':
    case 'evisa':
      return '#f59e0b' // yellow-500
    case 'reciprocity_fee':
      return '#8b5cf6' // purple-500
    case 'consulate_visa':
      return '#ef4444' // red-500
    case 'banned':
    case 'special_permission':
      return '#1f2937' // gray-800
    default:
      return '#6b7280' // gray-500
  }
}

// Status label mapping
export function getStatusLabel(status: TravelStatus): string {
  switch (status) {
    case 'visa_free':
      return 'Visa Free'
    case 'eta_required':
      return 'eTA Required'
    case 'visa_on_arrival':
      return 'Visa on Arrival'
    case 'evisa':
      return 'eVisa'
    case 'reciprocity_fee':
      return 'Reciprocity Fee'
    case 'consulate_visa':
      return 'Consulate Visa Required'
    case 'banned':
      return 'Banned'
    case 'special_permission':
      return 'Special Permission Required'
    default:
      return 'Unknown Status'
  }
}

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
      return 'visa_free'
    }

    // Use Travel Buddy API for visa requirements
    const primaryPassport = passports[0].issuing_country
    console.log(`🌐 Getting Travel Buddy map colors for ${primaryPassport}`)
    
    const apiResponse = await travelBuddyAPI.getMapColors(primaryPassport)
    
    if (apiResponse.success && apiResponse.data) {
      console.log(`✅ Travel Buddy API map colors received`)
      const countryData = apiResponse.data.find((item: any) => 
        item.countryCode === destinationCountry
      )
      
      if (countryData) {
        const status = travelBuddyAPI.convertColorToStatus(countryData.color)
        return status as TravelStatus
      }
    }

    // Fallback to database
    const { data: requirements, error } = await supabase
      .from('visa_requirements')
      .select('*')
      .eq('passport_country', primaryPassport)
      .eq('destination_country', destinationCountry)
      .eq('is_active', true)

    if (error || !requirements || requirements.length === 0) {
      return 'consulate_visa'
    }

    return requirements[0].status as TravelStatus
  } catch (error) {
    console.error('Error getting simple travel status:', error)
    return 'consulate_visa'
  }
}

// Simplified batch function - passports only
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

    const primaryPassport = passports[0].issuing_country
    
    // Get database requirements first (more reliable)
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

    // Get Travel Buddy API data as secondary source
    console.log(`🌐 Getting Travel Buddy map colors for ${primaryPassport}`)
    const apiResponse = await travelBuddyAPI.getMapColors(primaryPassport)
    let apiMapColors: Record<string, string> = {}
    
    if (apiResponse.success && apiResponse.data) {
      console.log(`✅ Travel Buddy API map colors received`)
      apiResponse.data.forEach((item: any) => {
        if (item.countryCode && item.color) {
          apiMapColors[item.countryCode] = travelBuddyAPI.convertColorToStatus(item.color)
        }
      })
    }

    // Process each country - prioritize database over API
    const result: Record<string, TravelStatus> = {}
    
    for (const countryCode of countryCodes) {
      let bestStatus: TravelStatus = 'consulate_visa'
      
      // Check citizenship
      if (passports.some(passport => passport.issuing_country === countryCode)) {
        bestStatus = 'visa_free'
      }
      // Use database data first (more reliable)
      else {
        const key = `${primaryPassport}-${countryCode}`
        const dbStatus = requirementsMap.get(key)
        if (dbStatus) {
          bestStatus = dbStatus as TravelStatus
        }
        // Only use API data if we don't have database data
        else if (apiMapColors[countryCode]) {
          bestStatus = apiMapColors[countryCode] as TravelStatus
        }
      }
      
      result[countryCode] = bestStatus
    }
    
    return result
  } catch (error) {
    console.error('Error in simple batch travel statuses:', error)
    const result: Record<string, TravelStatus> = {}
    countryCodes.forEach(code => result[code] = 'consulate_visa')
    return result
  }
} 