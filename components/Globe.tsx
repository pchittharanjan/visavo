'use client'

import { useState, useEffect } from 'react'
import { getAllCountries } from '@/lib/all-countries'
import { getSimpleTravelStatus, getSimpleBatchTravelStatuses } from '@/lib/simple-travel-requirements'
import { getStatusColor } from '@/lib/travel-requirements'
import { UserDocument, CountryInfo } from '@/lib/types'
import { MapPin, Loader2, ChevronDown } from 'lucide-react'

interface GlobeProps {
  userDocuments: UserDocument[]
  onCountryClick: (countryInfo: CountryInfo) => void
}

export default function Globe({ userDocuments, onCountryClick }: GlobeProps) {
  const [hoveredCountry, setHoveredCountry] = useState<string | null>(null)
  const [countryStatuses, setCountryStatuses] = useState<Record<string, string>>({})
  const [isLoading, setIsLoading] = useState(true)
  const [loadingProgress, setLoadingProgress] = useState(0)
  const [visibleCount, setVisibleCount] = useState(75) // Start with 75 countries
  const [searchTerm, setSearchTerm] = useState('')

  const allCountries = getAllCountries()
  
  // Filter countries based on search term
  const filteredCountries = allCountries.filter(country => 
    country.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    country.code.toLowerCase().includes(searchTerm.toLowerCase())
  )
  
  // Get visible countries
  const visibleCountries = filteredCountries.slice(0, visibleCount)

  useEffect(() => {
    const loadStatuses = async () => {
      setIsLoading(true)
      setLoadingProgress(0)
      
      try {
        // Use batch function for better performance
        const countryCodes = allCountries.map(c => c.code)
        console.log('🔍 Loading batch statuses for countries:', countryCodes)
        const statuses = await getSimpleBatchTravelStatuses(userDocuments, countryCodes)
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
  }, [userDocuments])

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
            allowedStay: 'Varies',
            notes: 'Visa required from consulate'
          }
        })
      }
    }
  }

  if (isLoading) {
    return (
      <div className="w-full h-full bg-gradient-to-br from-blue-900 to-indigo-900 rounded-lg overflow-hidden relative flex items-center justify-center">
        <div className="text-center text-white">
          <Loader2 className="h-16 w-16 mx-auto mb-4 text-blue-300 animate-spin" />
          <h3 className="text-xl font-semibold mb-2">Loading your travel world...</h3>
          <p className="text-blue-200 mb-4">Analyzing visa requirements for {allCountries.length} countries</p>
          
          {/* Progress bar */}
          <div className="w-64 mx-auto bg-blue-800 rounded-full h-2 mb-4">
            <div 
              className="bg-blue-300 h-2 rounded-full transition-all duration-300"
              style={{ width: `${loadingProgress}%` }}
            ></div>
          </div>
          
          <p className="text-sm text-blue-300">
            {Math.round(loadingProgress)}% complete
          </p>
        </div>
      </div>
    )
  }

  return (
    <div className="w-full h-full bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-900 relative flex flex-col">
      <div className="flex-1 p-4 overflow-y-auto">
        <div className="text-center text-white mb-6">
          <MapPin className="h-16 w-16 mx-auto mb-4 text-blue-300" />
          <h3 className="text-xl font-bold mb-2">Interactive World Map</h3>
          <p className="text-blue-200 mb-4">Click on countries to see travel requirements</p>
          
          {/* Simplified Search Bar */}
          <div className="mb-4">
            <input
              type="text"
              placeholder="Search countries..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="px-4 py-2 rounded-lg bg-white/10 text-white placeholder-white/60 border border-white/20 focus:outline-none focus:border-blue-300 w-64"
            />
          </div>
        </div>

        {/* Simplified Country Grid */}
        <div className="grid grid-cols-8 md:grid-cols-10 lg:grid-cols-12 xl:grid-cols-16 gap-2 max-w-6xl mx-auto mb-6">
          {visibleCountries.map((country) => {
            const status = countryStatuses[country.code] || 'consulate_visa'
            const color = getStatusColor(status as any)
            
            return (
              <button
                key={country.code}
                onClick={() => handleCountryClick(country.code)}
                onMouseEnter={() => setHoveredCountry(country.code)}
                onMouseLeave={() => setHoveredCountry(null)}
                className={`
                  p-2 rounded-md text-xs font-medium transition-colors duration-150
                  ${hoveredCountry === country.code 
                    ? 'ring-2 ring-white/50' 
                    : 'hover:ring-1 hover:ring-white/30'
                  }
                `}
                style={{ backgroundColor: color }}
              >
                <div className="text-sm mb-0.5">{country.flag}</div>
                <div className="text-white font-bold text-xs">{country.code}</div>
                {hoveredCountry === country.code && (
                  <div className="absolute -top-8 left-1/2 transform -translate-x-1/2 bg-black/90 text-white text-xs px-2 py-1 rounded whitespace-nowrap z-20">
                    {country.name}
                  </div>
                )}
              </button>
            )
          })}
        </div>

        {/* Simplified Show More Section */}
        <div className="text-center mb-20">
          <p className="text-sm text-blue-300 mb-2">
            Showing {visibleCountries.length} of {filteredCountries.length} countries
          </p>
          {visibleCount < filteredCountries.length && (
            <button 
              onClick={() => setVisibleCount(prev => Math.min(prev + 50, filteredCountries.length))}
              className="text-blue-300 hover:text-white underline text-sm"
            >
              Show More Countries
            </button>
          )}
        </div>

        {/* Simplified Legend */}
        <div className="fixed bottom-4 right-4 bg-black/90 rounded-lg p-4 text-xs text-white border border-white/20 shadow-lg z-10 max-w-48">
          <h4 className="font-bold text-sm mb-3 text-center">Travel Status</h4>
          <div className="space-y-2">
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#10b981' }}></div>
              <span>Visa Free</span>
            </div>
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#3b82f6' }}></div>
              <span>eTA Required</span>
            </div>
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#f59e0b' }}></div>
              <span>Visa Required</span>
            </div>
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#ef4444' }}></div>
              <span>Consulate Visa Required</span>
            </div>
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#1f2937' }}></div>
              <span>Banned / Special Permission</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
} 