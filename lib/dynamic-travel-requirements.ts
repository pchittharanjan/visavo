import { supabase } from './supabase'
import { TravelStatus, UserDocument } from './types'
import { travelBuddyAPI } from './travel-buddy-api'

// Dynamic travel requirements using database + Travel Buddy API
export async function getDynamicTravelStatus(
  userDocuments: UserDocument[],
  destinationCountry: string
): Promise<TravelStatus> {
  try {
    // Get primary passport
    const passport = userDocuments.find(doc => doc.document_type === 'passport')
    if (!passport) return 'consulate_visa'

    const passportCountry = passport.issuing_country
    
    // Check if user is a citizen of the destination country (passport from that country)
    if (destinationCountry === passportCountry) {
      return 'visa_free'
    }
    
    // Check if user has permanent residency in the destination country
    const permanentResidency = userDocuments.find(doc => 
      (doc.document_type === 'permanent_residence') &&
      doc.issuing_country === destinationCountry
    )
    
    if (permanentResidency) {
      return 'visa_free' // Permanent residents don't need visas
    }
    
      // PR logic removed - simplified system
    
    // Check if user has an existing visa for the destination country
    // Visa logic removed - passports only
    
    // Check for special overrides in database
    const { data: overrides, error: overrideError } = await supabase
      .from('special_overrides')
      .select('*')
      .eq('destination_country', destinationCountry)
      .eq('is_active', true)

    if (!overrideError && overrides && overrides.length > 0) {
      for (const override of overrides) {
        const requiredDocs = override.required_documents
        const hasRequiredDocs = requiredDocs.every((requiredDoc: string) => {
          if (requiredDoc === passportCountry) return true
          return userDocuments.some(doc => 
            doc.document_type === requiredDoc && 
            doc.issuing_country === passportCountry
          )
        })
        if (hasRequiredDocs) return override.override_status as TravelStatus
      }
    }

      // Note: Individual visa requirement endpoint doesn't exist
  // We'll use the map data instead

    // Fallback: Get regular requirements from database
    const { data: requirements, error } = await supabase
      .from('visa_requirements')
      .select('*')
      .eq('passport_country', passportCountry)
      .eq('destination_country', destinationCountry)
      .eq('is_active', true)
      .single()

    if (error || !requirements) {
      console.warn(`No visa requirements found for ${passportCountry} → ${destinationCountry}`)
      return 'consulate_visa'
    }

    return requirements.status as TravelStatus
  } catch (error) {
    console.error('Error getting dynamic travel status:', error)
    return 'consulate_visa'
  }
}

export async function getDynamicRequirementsText(
  status: TravelStatus, 
  countryCode: string, 
  userDocuments?: UserDocument[]
): Promise<{
  passportValidity?: string
  allowedStay?: string
  notes?: string
  visaFee?: string
  processingTime?: string
}> {
  try {
    // Check if this is the user's own country (citizen case)
    if (userDocuments) {
      const passport = userDocuments.find(doc => doc.document_type === 'passport')
      if (passport && passport.issuing_country === countryCode) {
        return {
          passportValidity: 'Valid passport required',
          allowedStay: 'Unlimited (citizen)',
          notes: 'No visa required - you are a citizen of this country',
          visaFee: 'Free',
          processingTime: 'N/A'
        }
      }
      
      // Check if user has permanent residency in this country
      const permanentResidency = userDocuments.find(doc => 
        doc.document_type === 'permanent_residence' &&
        doc.issuing_country === countryCode
      )
      
      if (permanentResidency) {
        return {
          passportValidity: 'Valid passport required',
          allowedStay: 'Unlimited (permanent resident)',
          notes: 'No visa required - you are a permanent resident of this country',
          visaFee: 'Free',
          processingTime: 'N/A'
        }
      }
      
      // Check if user has an existing valid visa for this country
      const existingVisa = userDocuments.find(doc => 
        (doc.document_type === 'tourist_visa' || 
         doc.document_type === 'business_visa' || 
         doc.document_type === 'student_visa' || 
         doc.document_type === 'work_permit') &&
        doc.issuing_country === countryCode
      )
      
      if (existingVisa) {
        const visaExpiry = new Date(existingVisa.expiration_date)
        const today = new Date()
        if (visaExpiry > today) {
          return {
            passportValidity: '6+ months beyond stay',
            allowedStay: 'As per visa validity',
            notes: `You have a valid ${existingVisa.document_type.replace('_', ' ')} until ${visaExpiry.toLocaleDateString()}`,
            visaFee: 'Already paid',
            processingTime: 'N/A'
          }
        }
      }
    }
    
    // Get country-specific requirements from database
    const { data: requirements, error } = await supabase
      .from('country_requirements')
      .select('*')
      .eq('country_code', countryCode)
      .eq('is_active', true)

    if (!error && requirements && requirements.length > 0) {
      const result: any = {}
      requirements.forEach(req => {
        switch (req.requirement_type) {
          case 'passport_validity':
            result.passportValidity = req.requirement_value
            break
          case 'allowed_stay':
            result.allowedStay = req.requirement_value
            break
          case 'visa_fee':
            result.visaFee = req.requirement_value
            break
          case 'processing_time':
            result.processingTime = req.requirement_value
            break
          case 'notes':
            result.notes = req.requirement_value
            break
        }
      })
      return result
    }
    
    // Fallback to generic requirements based on status
    return getGenericRequirements(status)
  } catch (error) {
    console.error('Error getting dynamic requirements text:', error)
    return getGenericRequirements(status)
  }
}

function getGenericRequirements(status: TravelStatus) {
  switch (status) {
    case 'visa_free':
      return {
        passportValidity: '6+ months beyond stay',
        allowedStay: '30-90 days',
        notes: 'No visa required for tourism',
        visaFee: 'Free',
        processingTime: 'N/A'
      }
    case 'eta_required':
      return {
        passportValidity: '6+ months beyond stay',
        allowedStay: '90 days',
        notes: 'Electronic Travel Authorization required',
        visaFee: 'Varies by country',
        processingTime: 'Immediate'
      }
    case 'visa_on_arrival':
      return {
        passportValidity: '6+ months beyond stay',
        allowedStay: '15-30 days',
        notes: 'Visa can be obtained at airport/border',
        visaFee: 'Varies by country',
        processingTime: 'Immediate'
      }
    case 'evisa':
      return {
        passportValidity: '6+ months beyond stay',
        allowedStay: '30-60 days',
        notes: 'Apply online before travel',
        visaFee: 'USD 20-80',
        processingTime: '1-5 business days'
      }
    case 'reciprocity_fee':
      return {
        passportValidity: '6+ months beyond stay',
        allowedStay: '90 days',
        notes: 'Reciprocity fee required',
        visaFee: 'USD 50-200',
        processingTime: 'Immediate'
      }
    case 'consulate_visa':
      return {
        passportValidity: '6+ months beyond stay',
        allowedStay: 'Varies by visa type',
        notes: 'Apply at embassy/consulate',
        visaFee: 'USD 50-200+',
        processingTime: '5-20 business days'
      }
    default:
      return {
        notes: 'Contact embassy for requirements',
        visaFee: 'Contact embassy',
        processingTime: 'Contact embassy'
      }
  }
}

// Admin functions for managing the database
export async function updateVisaRequirement(
  passportCountry: string,
  destinationCountry: string,
  status: TravelStatus,
  details: {
    allowedStayDays?: number
    visaFeeAmount?: number
    visaFeeCurrency?: string
    processingTimeDays?: number
    notes?: string
  }
) {
  const { data, error } = await supabase
    .from('visa_requirements')
    .upsert({
      passport_country: passportCountry,
      destination_country: destinationCountry,
      status,
      allowed_stay_days: details.allowedStayDays,
      visa_fee_amount: details.visaFeeAmount,
      visa_fee_currency: details.visaFeeCurrency,
      processing_time_days: details.processingTimeDays,
      notes: details.notes,
      last_updated: new Date().toISOString()
    })

  return { data, error }
}

export async function addSpecialOverride(
  destinationCountry: string,
  requiredDocuments: string[],
  overrideStatus: TravelStatus,
  notes?: string
) {
  const { data, error } = await supabase
    .from('special_overrides')
    .insert({
      destination_country: destinationCountry,
      required_documents: requiredDocuments,
      override_status: overrideStatus,
      notes
    })

  return { data, error }
}

// Analytics and usage tracking
export async function logTravelQuery(
  userId: string,
  passportCountry: string,
  destinationCountry: string,
  result: TravelStatus
) {
  const { data, error } = await supabase
    .from('api_logs')
    .insert({
      user_id: userId,
      endpoint: 'travel_status',
      request_data: { passportCountry, destinationCountry },
      response_data: { status: result },
      response_time_ms: 0 // Would be calculated in real implementation
    })

  return { data, error }
}

// Helper function to get all countries from database
export async function getCountriesFromDB() {
  const { data, error } = await supabase
    .from('countries')
    .select('*')
    .order('name')

  if (error) {
    console.error('Error fetching countries:', error)
    return []
  }

  return data || []
}

// Helper function to get visa requirements for a passport country
export async function getVisaRequirementsForPassport(passportCountry: string) {
  const { data, error } = await supabase
    .from('visa_requirements')
    .select(`
      *,
      destination_country_info:countries!visa_requirements_destination_country_fkey (
        code,
        name,
        flag
      )
    `)
    .eq('passport_country', passportCountry)
    .eq('is_active', true)
    .order('destination_country_info(name)')

  if (error) {
    console.error('Error fetching visa requirements:', error)
    return []
  }

  return data || []
}

// Batch function to get all travel statuses for a user
export async function getBatchTravelStatuses(
  userDocuments: UserDocument[],
  countryCodes: string[]
): Promise<Record<string, TravelStatus>> {
  try {
    // Get all passports and permanent residency documents
    const passports = userDocuments.filter(doc => doc.document_type === 'passport')
    const permanentResidency = userDocuments.filter(doc => 
      doc.document_type === 'permanent_residence'
    )
    
    if (passports.length === 0) {
      // No passport, return consulate visa for all countries
      const result: Record<string, TravelStatus> = {}
      countryCodes.forEach(code => result[code] = 'consulate_visa')
      return result
    }

    // Get all passport countries and permanent residency countries
    const passportCountries = passports.map(p => p.issuing_country)
    const prCountries = permanentResidency.map(pr => pr.issuing_country)
    
      // Get Travel Buddy API data for the primary passport
  const primaryPassport = passportCountries[0]
  console.log(`🌐 Getting Travel Buddy map colors for ${primaryPassport}`)
  
  const apiResponse = await travelBuddyAPI.getMapColors(primaryPassport)
  let apiMapColors: Record<string, string> = {}
  
  if (apiResponse.success && apiResponse.data) {
    console.log(`✅ Travel Buddy API map colors received`)
    // Convert API response to our format
    apiResponse.data.forEach((item: any) => {
      if (item.countryCode && item.color) {
        apiMapColors[item.countryCode] = travelBuddyAPI.convertColorToStatus(item.color)
      }
    })
  } else {
    console.log(`❌ Travel Buddy API failed:`, apiResponse.error)
  }
    
    // Get all requirements for all passport countries in one query (fallback)
    const { data: requirements, error } = await supabase
      .from('visa_requirements')
      .select('*')
      .in('passport_country', passportCountries)
      .eq('is_active', true)

    if (error) {
      console.error('Error fetching batch requirements:', error)
      const result: Record<string, TravelStatus> = {}
      countryCodes.forEach(code => result[code] = 'consulate_visa')
      return result
    }

    // Create a map for quick lookup: passport_country -> destination_country -> status
    const requirementsMap = new Map()
    requirements?.forEach(req => {
      const key = `${req.passport_country}-${req.destination_country}`
      requirementsMap.set(key, req.status)
    })

    // Special overrides removed - simplified system

    // Process each country
    const result: Record<string, TravelStatus> = {}
    
    for (const countryCode of countryCodes) {
      let bestStatus: TravelStatus = 'consulate_visa'
      
      // Check citizenship (any passport from destination country)
      if (passportCountries.includes(countryCode)) {
        bestStatus = 'visa_free'
      }
      
      // Visa logic removed - passports only
      
      // Use Travel Buddy API data if available
      if (bestStatus === 'consulate_visa' && apiMapColors[countryCode]) {
        bestStatus = apiMapColors[countryCode] as TravelStatus
      }
      // Fallback to database
      else if (bestStatus === 'consulate_visa') {
        for (const passportCountry of passportCountries) {
          const key = `${passportCountry}-${countryCode}`
          const dbStatus = requirementsMap.get(key)
          if (dbStatus) {
            bestStatus = dbStatus as TravelStatus
            break
          }
        }
      }
      
      result[countryCode] = bestStatus
    }
    
    return result
  } catch (error) {
    console.error('Error in batch travel statuses:', error)
    const result: Record<string, TravelStatus> = {}
    countryCodes.forEach(code => result[code] = 'consulate_visa')
    return result
  }
}