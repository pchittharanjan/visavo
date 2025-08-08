import { Country } from './types'
import { supabase } from './supabase'

// Dynamic function that fetches countries from database
export async function getCountries(allowedCountries?: string[]): Promise<Country[]> {
  try {
    let query = supabase
      .from('countries')
      .select('code, name, flag')
      .order('code')
    
    // If allowedCountries is provided, filter by those codes
    if (allowedCountries && allowedCountries.length > 0) {
      query = query.in('code', allowedCountries)
    }
    
    const { data, error } = await query
    
    if (error) {
      console.error('Error fetching countries:', error)
      return []
    }
    
    // Transform database data to frontend format
    return data?.map(country => ({
      code: country.code,
      name: country.name,
      flag: country.flag,
      documentTypes: [] // Will be populated by getDocumentTypesForCountry
    })) || []
  } catch (error) {
    console.error('Error in getCountries:', error)
    return []
  }
}

export function getCountryByCode(code: string, countries: Country[]): Country | undefined {
  return countries.find(country => country.code === code)
}

export function getCountryName(code: string, countries: Country[]): string {
  const country = getCountryByCode(code, countries)
  return country?.name || code // Fallback to code if not found
}

// Dynamic function that fetches document types from database
export async function getDocumentTypesForCountry(countryCode: string): Promise<string[]> {
  try {
    const { data, error } = await supabase
      .from('document_types')
      .select('name')
      .order('name')
    
    if (error) {
      console.error('Error fetching document types:', error)
      return []
    }
    
    return data?.map(docType => docType.name) || []
  } catch (error) {
    console.error('Error in getDocumentTypesForCountry:', error)
    return []
  }
}

// New function that returns document types with both name and description
export async function getDocumentTypesWithDescriptions(): Promise<Array<{name: string, description: string}>> {
  try {
    const { data, error } = await supabase
      .from('document_types')
      .select('name, description')
      .order('name')
    
    if (error) {
      console.error('Error fetching document types:', error)
      return []
    }
    
    return data?.map(docType => ({
      name: docType.name,
      description: docType.description || docType.name
    })) || []
  } catch (error) {
    console.error('Error in getDocumentTypesWithDescriptions:', error)
    return []
  }
}

// Legacy function for backward compatibility - now calls the async version
export async function getAllCountries(): Promise<Country[]> {
  return getCountries()
} 