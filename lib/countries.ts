import { Country } from './types'

export const countries: Country[] = [
  {
    code: 'US',
    name: 'United States',
    flag: '🇺🇸',
    documentTypes: ['passport']
  },
  {
    code: 'CA',
    name: 'Canada',
    flag: '🇨🇦',
    documentTypes: ['passport']
  },
  {
    code: 'MX',
    name: 'Mexico',
    flag: '🇲🇽',
    documentTypes: ['passport']
  }
]

export function getCountryByCode(code: string): Country | undefined {
  return countries.find(country => country.code === code)
}

export function getDocumentTypesForCountry(countryCode: string): string[] {
  const country = getCountryByCode(countryCode)
  return country?.documentTypes || []
} 