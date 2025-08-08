'use client'

import { useState, useEffect, useRef } from 'react'
import { getAllCountries } from '@/lib/countries'
import { getSimpleTravelStatus, getSimpleBatchTravelStatuses, getDynamicStatusColor, loadStatusTypes, clearStatusTypesCache, forceRefreshStatusTypes } from '@/lib/dynamic-travel-requirements'
import { getOptimizedBatchStatuses } from '@/lib/optimized-database'
import { UserDocument, CountryInfo } from '@/lib/types'
import { MapPin, Loader2, ChevronDown } from 'lucide-react'

interface GlobeProps {
  userDocuments: UserDocument[]
  onCountryClick: (countryInfo: CountryInfo) => void
  selectedCountry: CountryInfo | null
}

export default function Globe({ userDocuments, onCountryClick, selectedCountry }: GlobeProps) {
  const [hoveredCountry, setHoveredCountry] = useState<string | null>(null)
  const [countryStatuses, setCountryStatuses] = useState<Record<string, string>>({})
  const [isLoading, setIsLoading] = useState(true)
  const [loadingProgress, setLoadingProgress] = useState(0)
  const [visibleCount, setVisibleCount] = useState(75) // Start with 75 countries
  const [searchTerm, setSearchTerm] = useState('')
  const [allCountries, setAllCountries] = useState<any[]>([])
  const [countriesLoading, setCountriesLoading] = useState(true)
  const [colorCache, setColorCache] = useState<Record<string, string>>({})
  const [colorsLoaded, setColorsLoaded] = useState(false)
  const [statusTypes, setStatusTypes] = useState<any[]>([])
  // Load countries from database
  useEffect(() => {
    const loadCountries = async () => {
      try {
        const countries = await getAllCountries()
        setAllCountries(countries)
        console.log('🌍 Loaded countries from database:', countries.length)
      } catch (error) {
        console.error('Error loading countries:', error)
        setAllCountries([])
      } finally {
        setCountriesLoading(false)
      }
    }
    
    loadCountries()
  }, [])

  // Load colors from database
  useEffect(() => {
    const loadColors = async () => {
      try {
        console.log('🎨 Starting to load colors from database...')
        
        // Force refresh to get latest data including new status types
        const statusTypes = await forceRefreshStatusTypes()
        console.log('🎨 Loaded status types:', statusTypes)
        
        const colorMap: Record<string, string> = {}
        statusTypes.forEach(st => {
          colorMap[st.code] = st.color
        })
        
        console.log('🎨 Status types for legend:', statusTypes)
        setStatusTypes(statusTypes)
        setColorCache(colorMap)
        setColorsLoaded(true)
        console.log('🎨 Final color cache:', colorMap)
        
        // Test: Check if eVisa color is correct
        if (colorMap['evisa'] === '#f59e0b') {
          console.log('✅ eVisa color is correct (yellow)')
        } else {
          console.log('❌ eVisa color is wrong:', colorMap['evisa'])
        }
      } catch (error) {
        console.error('Error loading colors:', error)
        setColorsLoaded(true) // Still mark as loaded to avoid infinite loading
      }
    }
    
    loadColors()
  }, [])
  
  // Filter countries based on search term
  const filteredCountries = allCountries.filter(country => 
    country.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    country.code.toLowerCase().includes(searchTerm.toLowerCase())
  )
  
  // Get visible countries
  const visibleCountries = filteredCountries.slice(0, visibleCount)

  useEffect(() => {
    const loadStatuses = async () => {
      if (allCountries.length === 0) return // Wait for countries to load
      
      setIsLoading(true)
      setLoadingProgress(0)
      
      try {
        // Use batch function for better performance
        const countryCodes = allCountries.map(c => c.code)
        console.log('🔍 Loading batch statuses for countries:', countryCodes)
        const statuses = await getOptimizedBatchStatuses(userDocuments, countryCodes)
        console.log('📊 Batch statuses returned:', statuses)
        setCountryStatuses(statuses)
        setLoadingProgress(100)
      } catch (error) {
        console.error('Error loading batch statuses:', error)
        // Fallback to individual queries with progress
        const statuses: Record<string, string> = {}
        const totalCountries = allCountries.length
        
        for (let i = 0; i < allCountries.length; i++) {
          const country = allCountries[i]
          try {
            statuses[country.code] = await getSimpleTravelStatus(userDocuments, country.code)
          } catch (error) {
            console.error(`Error loading status for ${country.code}:`, error)
            statuses[country.code] = 'consulate_visa' // fallback
          }
          setLoadingProgress(((i + 1) / totalCountries) * 100)
        }
        
        setCountryStatuses(statuses)
      }
      
      setIsLoading(false)
    }
    
    loadStatuses()
  }, [userDocuments, allCountries])

  const handleCountryClick = async (countryCode: string) => {
    const country = allCountries.find(c => c.code === countryCode)
    if (country) {
      try {
        console.log('🔍 Clicking on country:', countryCode)
        const status = await getSimpleTravelStatus(userDocuments, countryCode)
        console.log('📊 Status for', countryCode, ':', status)
        onCountryClick({
          code: country.code,
          name: country.name,
          flag: country.flag,
          status: status as any,
          requirements: {
            passportValidity: '6+ months',
            allowedStay: '90 days',
            notes: 'Standard tourist requirements'
          }
        })
      } catch (error) {
        console.error('Error getting travel status:', error)
        // Fallback to default
        onCountryClick({
          code: country.code,
          name: country.name,
          flag: country.flag,
          status: 'consulate_visa',
          requirements: {
            passportValidity: '6+ months',
            allowedStay: '90 days',
            notes: 'Standard tourist requirements'
          }
        })
      }
    }
  }

  if (countriesLoading || isLoading || !colorsLoaded) {
    return (
      <div className="w-full h-full bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-900 flex items-center justify-center">
        <div className="text-center text-white">
          <Loader2 className="h-12 w-12 mx-auto mb-4 animate-spin text-blue-300" />
          <h3 className="text-xl font-display font-bold mb-2">
            {countriesLoading ? 'Loading Countries' : colorsLoaded ? 'Loading World Map' : 'Loading Colors'}
          </h3>
          <p className="text-blue-200 mb-4">
            {countriesLoading ? 'Fetching country data from database...' : colorsLoaded ? 'Preparing travel requirements...' : 'Loading color scheme...'}
          </p>
          <div className="w-64 bg-blue-800 rounded-full h-2 mx-auto">
            <div 
              className="bg-blue-300 h-2 rounded-full transition-all duration-300"
              style={{ width: `${loadingProgress}%` }}
            ></div>
          </div>
          <p className="text-sm text-blue-300 mt-2">{Math.round(loadingProgress)}% complete</p>
        </div>
      </div>
    )
  }

  return (
    <div className="w-full h-full relative flex flex-col">
      <div className="flex-1 p-4 overflow-y-auto">
        <div className="text-center text-gray-900 mb-6">
          {/* Search Bar */}
          <div className="mb-4">
            <input
              type="text"
              placeholder="Search countries..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="px-4 py-2 rounded-lg bg-gray-100 text-gray-900 placeholder-gray-800 border border-gray-300 focus:outline-none focus:border-blue-300 focus:ring-2 focus:ring-blue-300/20 w-64 font-body text-sm"
            />
          </div>
        </div>

        {/* Legend - Subtle Top Banner */}
        <div className="bg-gray-100 rounded-lg p-2 text-xs text-gray-900 border border-gray-200 mb-4 max-w-4xl mx-auto">
          <div className="flex items-center justify-center space-x-4">
            <span className="font-body text-xs font-medium">Travel Status:</span>
            {statusTypes.map((statusType) => (
              <div key={statusType.code} className="flex items-center space-x-1">
                <div className="w-2 h-2 rounded-full" style={{ backgroundColor: statusType.color }}></div>
                <span className="font-body text-xs">{statusType.name}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Country Grid */}
        <div className="grid grid-cols-8 md:grid-cols-10 lg:grid-cols-12 xl:grid-cols-16 gap-2 max-w-6xl mx-auto mb-6 relative">
          {visibleCountries.map((country, index) => {
            const status = countryStatuses[country.code] || 'consulate_visa'
            const color = colorCache[status] || '#6b7280' // Use color cache with gray fallback
            

            
            return (
              <button
                key={country.code}
                onClick={() => handleCountryClick(country.code)}
                onMouseEnter={() => setHoveredCountry(country.code)}
                onMouseLeave={() => setHoveredCountry(null)}
                className={`
                  flex flex-col items-center justify-center p-2 rounded-md text-xs font-medium transition-all duration-200 relative
                  ${hoveredCountry === country.code 
                    ? 'ring-2 ring-white/50' 
                    : 'hover:ring-1 hover:ring-white/30'
                  }
                  ${selectedCountry?.code === country.code 
                    ? 'brightness-75' 
                    : ''
                  }
                `}
                style={{ backgroundColor: color }}
              >
                <div className="text-sm mb-1">{country.flag}</div>
                <div className="text-white font-bold text-xs font-body">{country.code}</div>
                {hoveredCountry === country.code && (
                  <div 
                    className={`
                      absolute bg-black/90 text-white px-2 py-1 rounded z-50 font-body -top-8
                      ${index % 16 === 0 ? 'left-1' : 
                        index % 16 === 15 || index === visibleCountries.length - 1 ? 'right-1' : 
                        'left-1/2 transform -translate-x-1/2'}
                    `}
                    style={{ 
                      whiteSpace: 'normal'
                    }}
                  >
                    {country.name}
                  </div>
                )}
              </button>
            )
          })}
        </div>

        {/* Show More Section */}
        <div className="text-center mb-16">
          <p className="text-xs text-gray-700 mb-2 font-body">
            Showing {visibleCountries.length} of {filteredCountries.length} countries
          </p>
          {visibleCount < filteredCountries.length && (
            <button 
              onClick={() => setVisibleCount(prev => Math.min(prev + 50, filteredCountries.length))}
              className="text-blue-600 hover:text-blue-800 underline text-xs font-body hover:no-underline transition-colors duration-150"
            >
              Show More Countries
            </button>
          )}
        </div>
      </div>
    </div>
  )
}