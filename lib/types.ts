export type DocumentType = 'passport'

export type TravelStatus =
  | 'visa_free'
  | 'eta_required'
  | 'visa_on_arrival'
  | 'evisa'
  | 'consulate_visa'
  | 'citizen'
  | 'banned'
  | 'special_permission'

export interface Country {
  code: string
  name: string
  flag: string
  documentTypes: DocumentType[]
}

export interface UserDocument {
  id: number
  user_id: string
  issuing_country: string
  document_type: DocumentType
  expiration_date: string
  created_at: string
}

export interface TravelRequirement {
  countryCode: string
  status: TravelStatus
  requirements: {
    passportValidity?: string
    allowedStay?: string
    notes?: string
    visaFee?: string
    processingTime?: string
  }
}

export interface User {
  id: string
  email: string
  displayName: string
  createdAt: string
  updatedAt: string
}

export interface CountryInfo {
  code: string
  name: string
  flag: string
  status: TravelStatus
  requirements: {
    passportValidity?: string
    allowedStay?: string
    notes?: string
    visaFee?: string
    processingTime?: string
    passportUsed?: string
    passportReason?: string
    allPassportOptions?: Array<{
      passport: string
      status: TravelStatus
      requirements?: any
    }>
  }
} 