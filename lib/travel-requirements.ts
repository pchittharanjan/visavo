import { TravelStatus, UserDocument } from './types'
import { getCountryByCode } from './countries'

// Country-specific requirements database
const countryRequirements: Record<string, {
  passportValidity: string
  allowedStay: string
  notes: string
  visaFee?: string
  processingTime?: string
}> = {
  'US': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'ESTA required for visa-free travel. Apply online before departure.',
    visaFee: 'USD 21 (ESTA)',
    processingTime: 'Immediate'
  },
  'CA': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '6 months',
    notes: 'eTA (Electronic Travel Authorization) required. Apply online before departure.',
    visaFee: 'CAD 7 (eTA)',
    processingTime: 'Immediate'
  },
  'GB': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '6 months',
    notes: 'No visa required for tourism. May need to show proof of funds and return ticket.',
    visaFee: 'Free',
    processingTime: 'N/A'
  },
  'AU': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'ETA (Electronic Travel Authority) required. Apply online before departure.',
    visaFee: 'AUD 20 (ETA)',
    processingTime: 'Immediate'
  },
  'NZ': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'NZeTA (New Zealand Electronic Travel Authority) required. Apply online before departure.',
    visaFee: 'NZD 23 (NZeTA)',
    processingTime: 'Immediate'
  },
  'IN': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '60 days',
    notes: 'eVisa required. Apply online at least 4 days before travel.',
    visaFee: 'USD 25 (eVisa)',
    processingTime: '3-5 business days'
  },
  'TH': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '30 days',
    notes: 'Visa on arrival available at major airports. Bring 2 passport photos.',
    visaFee: 'THB 2,000 (VOA)',
    processingTime: 'Immediate'
  },
  'JP': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'No visa required for tourism. Register at local ward office if staying >90 days.',
    visaFee: 'Free',
    processingTime: 'N/A'
  },
  'SG': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'No visa required for tourism. Complete SG Arrival Card online.',
    visaFee: 'Free',
    processingTime: 'N/A'
  },
  'MY': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'No visa required for tourism. Complete Malaysia Digital Arrival Card.',
    visaFee: 'Free',
    processingTime: 'N/A'
  },
  'ID': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '30 days',
    notes: 'Visa on arrival available. Can be extended once for 30 days.',
    visaFee: 'USD 35 (VOA)',
    processingTime: 'Immediate'
  },
  'VN': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '30 days',
    notes: 'eVisa required. Apply online at least 3 days before travel.',
    visaFee: 'USD 25 (eVisa)',
    processingTime: '3-5 business days'
  },
  'BR': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'eVisa required for US citizens. Apply online before travel.',
    visaFee: 'USD 40 (eVisa)',
    processingTime: '5-10 business days'
  },

  'EG': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '30 days',
    notes: 'Visa on arrival available. Bring USD in cash for payment.',
    visaFee: 'USD 25 (VOA)',
    processingTime: 'Immediate'
  },
  'TR': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'eVisa required. Apply online before travel.',
    visaFee: 'USD 50 (eVisa)',
    processingTime: 'Immediate'
  },
  'AE': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '30 days',
    notes: 'Visa on arrival available. Can be extended for additional 30 days.',
    visaFee: 'Free',
    processingTime: 'Immediate'
  },
  'SA': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'eVisa required. Apply online before travel.',
    visaFee: 'USD 80 (eVisa)',
    processingTime: '24-72 hours'
  },
  'ZA': {
    passportValidity: '6+ months beyond stay',
    allowedStay: '90 days',
    notes: 'No visa required for tourism. May need yellow fever certificate.',
    visaFee: 'Free',
    processingTime: 'N/A'
  },
  'RU': {
    passportValidity: '6+ months beyond stay',
    allowedStay: 'Varies',
    notes: 'Consulate visa required. Apply at Russian embassy/consulate.',
    visaFee: 'USD 160+ (Visa)',
    processingTime: '10-20 business days'
  },
  'CN': {
    passportValidity: '6+ months beyond stay',
    allowedStay: 'Varies',
    notes: 'Consulate visa required. Apply at Chinese embassy/consulate.',
    visaFee: 'USD 140+ (Visa)',
    processingTime: '4-10 business days'
  }
}

// Simplified travel requirements database
// In a real app, this would be a comprehensive database with up-to-date visa requirements
const travelRequirements: Record<string, Record<string, TravelStatus>> = {
  // US passport holders
  'US': {
    'CA': 'eta_required', // Canada (eTA required)
    'MX': 'visa_free', // Mexico
    'GB': 'visa_free', // UK
    'DE': 'visa_free', // Germany
    'FR': 'visa_free', // France
    'IT': 'visa_free', // Italy
    'ES': 'visa_free', // Spain
    'NL': 'visa_free', // Netherlands
    'SE': 'visa_free', // Sweden
    'NO': 'visa_free', // Norway
    'DK': 'visa_free', // Denmark
    'FI': 'visa_free', // Finland
    'CH': 'visa_free', // Switzerland
    'AT': 'visa_free', // Austria
    'BE': 'visa_free', // Belgium
    'IE': 'visa_free', // Ireland
    'NZ': 'eta_required', // New Zealand (NZeTA required)
    'JP': 'visa_free', // Japan
    'KR': 'visa_free', // South Korea
    'SG': 'visa_free', // Singapore
    'AU': 'eta_required', // Australia (ETA required)
    'IN': 'evisa', // India (unless OCI)
    'TH': 'visa_on_arrival', // Thailand
    'MY': 'visa_free', // Malaysia
    'ID': 'visa_on_arrival', // Indonesia
    'PH': 'visa_free', // Philippines
    'VN': 'evisa', // Vietnam
    'MM': 'evisa', // Myanmar
    'KH': 'visa_on_arrival', // Cambodia
    'LA': 'visa_on_arrival', // Laos
    'BD': 'visa_on_arrival', // Bangladesh
    'PK': 'evisa', // Pakistan
    'LK': 'visa_on_arrival', // Sri Lanka
    'NP': 'visa_on_arrival', // Nepal
    'MV': 'visa_on_arrival', // Maldives
    'BR': 'evisa', // Brazil
    'AR': 'visa_free', // Argentina (visa-free for US citizens)
    'CL': 'visa_free', // Chile
    'CO': 'visa_free', // Colombia
    'PE': 'visa_free', // Peru
    'ZA': 'visa_free', // South Africa
    'EG': 'visa_on_arrival', // Egypt
    'MA': 'visa_free', // Morocco
    'TR': 'evisa', // Turkey
    'IL': 'visa_free', // Israel
    'AE': 'visa_free', // UAE
    'SA': 'evisa', // Saudi Arabia
    'QA': 'visa_on_arrival', // Qatar
    'KW': 'evisa', // Kuwait
    'BH': 'visa_on_arrival', // Bahrain
    'OM': 'evisa', // Oman
    'JO': 'visa_on_arrival', // Jordan
    'LB': 'visa_on_arrival', // Lebanon
    'RU': 'consulate_visa', // Russia
    'UA': 'visa_free', // Ukraine
    'PL': 'visa_free', // Poland
    'CZ': 'visa_free', // Czech Republic
    'HU': 'visa_free', // Hungary
    'RO': 'visa_free', // Romania
    'BG': 'visa_free', // Bulgaria
    'HR': 'visa_free', // Croatia
    'SI': 'visa_free', // Slovenia
    'SK': 'visa_free', // Slovakia
    'LT': 'visa_free', // Lithuania
    'LV': 'visa_free', // Latvia
    'EE': 'visa_free', // Estonia
    'MT': 'visa_free', // Malta
    'CY': 'visa_free', // Cyprus
    'GR': 'visa_free', // Greece
    'PT': 'visa_free', // Portugal
    'LU': 'visa_free', // Luxembourg
    'IS': 'visa_free', // Iceland
  },
  // UK passport holders
  'GB': {
    'US': 'visa_free',
    'CA': 'visa_free',
    'AU': 'visa_free',
    'NZ': 'visa_free',
    'JP': 'visa_free',
    'KR': 'visa_free',
    'SG': 'visa_free',
    'IN': 'evisa',
    'TH': 'visa_on_arrival',
    'MY': 'visa_free',
    'ID': 'visa_on_arrival',
    'PH': 'visa_free',
    'VN': 'visa_free',
    'MM': 'evisa',
    'KH': 'visa_on_arrival',
    'LA': 'visa_on_arrival',
    'BD': 'visa_on_arrival',
    'PK': 'evisa',
    'LK': 'visa_on_arrival',
    'NP': 'visa_on_arrival',
    'MV': 'visa_on_arrival',
    'BR': 'visa_free',
    'AR': 'visa_free',
    'CL': 'visa_free',
    'CO': 'visa_free',
    'PE': 'visa_free',
    'ZA': 'visa_free',
    'EG': 'visa_on_arrival',
    'MA': 'visa_free',
    'TR': 'visa_free',
    'IL': 'visa_free',
    'AE': 'visa_free',
    'SA': 'evisa',
    'QA': 'visa_on_arrival',
    'KW': 'evisa',
    'BH': 'visa_on_arrival',
    'OM': 'evisa',
    'JO': 'visa_on_arrival',
    'LB': 'visa_on_arrival',
    'RU': 'consulate_visa',
    'UA': 'visa_free',
  },
  // Canadian passport holders
  'CA': {
    'US': 'visa_free',
    'GB': 'visa_free',
    'AU': 'visa_free',
    'NZ': 'visa_free',
    'JP': 'visa_free',
    'KR': 'visa_free',
    'SG': 'visa_free',
    'IN': 'evisa',
    'TH': 'visa_on_arrival',
    'MY': 'visa_free',
    'ID': 'visa_on_arrival',
    'PH': 'visa_free',
    'VN': 'visa_free',
    'MM': 'evisa',
    'KH': 'visa_on_arrival',
    'LA': 'visa_on_arrival',
    'BD': 'visa_on_arrival',
    'PK': 'evisa',
    'LK': 'visa_on_arrival',
    'NP': 'visa_on_arrival',
    'MV': 'visa_on_arrival',
    'BR': 'visa_free',
    'AR': 'visa_free',
    'CL': 'visa_free',
    'CO': 'visa_free',
    'PE': 'visa_free',
    'ZA': 'visa_free',
    'EG': 'visa_on_arrival',
    'MA': 'visa_free',
    'TR': 'visa_free',
    'IL': 'visa_free',
    'AE': 'visa_free',
    'SA': 'evisa',
    'QA': 'visa_on_arrival',
    'KW': 'evisa',
    'BH': 'visa_on_arrival',
    'OM': 'evisa',
    'JO': 'visa_on_arrival',
    'LB': 'visa_on_arrival',
    'RU': 'consulate_visa',
    'UA': 'visa_free',
  }
}

// Special override rules
const specialOverrides: Record<string, { documents: string[], status: TravelStatus }[]> = {
  'IN': [
    { documents: ['US', 'oci_card'], status: 'visa_free' },
    { documents: ['GB', 'oci_card'], status: 'visa_free' },
    { documents: ['CA', 'oci_card'], status: 'visa_free' },
  ]
}

export function getTravelStatus(
  userDocuments: UserDocument[],
  destinationCountry: string
): TravelStatus {
  // Get primary passport
  const passport = userDocuments.find(doc => doc.document_type === 'passport')
  if (!passport) return 'consulate_visa'

  const passportCountry = passport.issuing_country
  
  // If destination is the same as passport country, no visa needed
  if (destinationCountry === passportCountry) {
    return 'visa_free'
  }
  
  // Check if user has an existing visa for the destination country
  const existingVisa = userDocuments.find(doc => 
    (doc.document_type === 'tourist_visa' || 
     doc.document_type === 'business_visa' || 
     doc.document_type === 'student_visa' || 
     doc.document_type === 'work_permit') &&
    doc.issuing_country === destinationCountry
  )
  
  if (existingVisa) {
    // Check if visa is still valid
    const visaExpiry = new Date(existingVisa.expiration_date)
    const today = new Date()
    if (visaExpiry > today) {
      return 'visa_free' // Valid visa exists
    }
  }
  
  // Check for special overrides first
  const overrides = specialOverrides[destinationCountry]
  if (overrides) {
    for (const override of overrides) {
      const hasRequiredDocs = override.documents.every(requiredDoc => {
        if (requiredDoc === passportCountry) return true
        return userDocuments.some(doc => 
          doc.document_type === requiredDoc && 
          doc.issuing_country === passportCountry
        )
      })
      if (hasRequiredDocs) return override.status
    }
  }

  // Check regular requirements
  const requirements = travelRequirements[passportCountry]
  if (!requirements) return 'consulate_visa'

  return requirements[destinationCountry] || 'consulate_visa'
}

export function getStatusColor(status: TravelStatus): string {
  switch (status) {
    case 'visa_free':
      return '#10b981' // Green - Good
    case 'eta_required':
      return '#3b82f6' // Blue - Easy
    case 'visa_on_arrival':
    case 'evisa':
    case 'reciprocity_fee': // Merged into yellow category
      return '#f59e0b' // Yellow - Medium (Visa Required)
    case 'consulate_visa':
      return '#ef4444' // Red - Hard
    case 'banned':
    case 'special_permission':
      return '#1f2937' // Gray - Impossible
    default:
      return '#ef4444' // Red fallback
  }
}

export function getStatusLabel(status: TravelStatus): string {
  switch (status) {
    case 'visa_free':
      return 'Visa Free'
    case 'eta_required':
      return 'eTA Required'
    case 'visa_on_arrival':
      return 'Visa on Arrival'
    case 'evisa':
      return 'eVisa Required'
    case 'reciprocity_fee':
      return 'Reciprocity Fee'
    case 'consulate_visa':
      return 'Consulate Visa Required'
    case 'banned':
      return 'Travel Banned'
    case 'special_permission':
      return 'Special Permission Required'
    default:
      return 'Unknown'
  }
}

export function getRequirementsText(status: TravelStatus, countryCode: string, userDocuments?: UserDocument[]): {
  passportValidity?: string
  allowedStay?: string
  notes?: string
  visaFee?: string
  processingTime?: string
} {
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
  
  // Get country-specific requirements if available
  const countrySpecific = countryRequirements[countryCode]
  
  if (countrySpecific) {
    return countrySpecific
  }
  
  // Fallback to generic requirements based on status
  switch (status) {
    case 'visa_free':
      return {
        passportValidity: 'Valid passport required',
        allowedStay: 'Unlimited (citizen)',
        notes: 'No visa required - you are a citizen of this country',
        visaFee: 'Free',
        processingTime: 'N/A'
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