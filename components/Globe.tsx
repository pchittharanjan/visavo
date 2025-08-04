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
            allowedStay: '90 days',
            notes: 'Standard tourist requirements'
          }
        })
      }
    }
  }

  if (isLoading) {
    return (
      <div className="w-full h-full bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-900 flex items-center justify-center">
        <div className="text-center text-white">
          <Loader2 className="h-12 w-12 mx-auto mb-4 animate-spin text-blue-300" />
          <h3 className="text-xl font-display font-bold mb-2">Loading World Map</h3>
          <p className="text-blue-200 mb-4">Preparing travel requirements...</p>
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
    <div className="w-full h-full bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-900 relative flex flex-col">
      <div className="flex-1 p-6 overflow-y-auto">
        <div className="text-center text-white mb-8">
          <MapPin className="h-16 w-16 mx-auto mb-4 text-blue-300" />
          <h3 className="text-2xl font-display font-bold mb-3">Interactive World Map</h3>
          <p className="text-blue-200 mb-6 font-body">Click on countries to see travel requirements</p>
          
          {/* Search Bar */}
          <div className="mb-6">
            <input
              type="text"
              placeholder="Search countries..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="px-6 py-3 rounded-xl bg-white/10 text-white placeholder-white/60 border border-white/20 focus:outline-none focus:border-blue-300 focus:ring-2 focus:ring-blue-300/20 w-80 font-body"
            />
          </div>
        </div>

        {/* Country Grid */}
        <div className="grid grid-cols-8 md:grid-cols-10 lg:grid-cols-12 xl:grid-cols-16 gap-3 max-w-7xl mx-auto mb-8">
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
                  p-3 rounded-lg text-xs font-medium transition-all duration-200 relative
                  ${hoveredCountry === country.code 
                    ? 'ring-2 ring-white/50 scale-105' 
                    : 'hover:ring-1 hover:ring-white/30 hover:scale-102'
                  }
                `}
                style={{ backgroundColor: color }}
              >
                <div className="text-base mb-1">{country.flag}</div>
                <div className="text-white font-bold text-xs font-body">{country.code}</div>
                {hoveredCountry === country.code && (
                  <div className="absolute -top-10 left-1/2 transform -translate-x-1/2 bg-black/90 text-white text-xs px-3 py-2 rounded-lg whitespace-nowrap z-20 font-body">
                    {country.name}
                  </div>
                )}
              </button>
            )
          })}
        </div>

        {/* Show More Section */}
        <div className="text-center mb-24">
          <p className="text-sm text-blue-300 mb-3 font-body">
            Showing {visibleCountries.length} of {filteredCountries.length} countries
          </p>
          {visibleCount < filteredCountries.length && (
            <button 
              onClick={() => setVisibleCount(prev => Math.min(prev + 50, filteredCountries.length))}
              className="text-blue-300 hover:text-white underline text-sm font-body hover:no-underline transition-colors duration-150"
            >
              Show More Countries
            </button>
          )}
        </div>

        {/* Legend - Positioned to avoid overlap with right panel */}
        <div className="absolute bottom-6 left-6 bg-black/90 rounded-xl p-4 text-xs text-white border border-white/20 shadow-xl z-10 max-w-52">
          <h4 className="font-display font-bold text-sm mb-3 text-center">Travel Status</h4>
          <div className="space-y-2">
            <div className="flex items-center space-x-3">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#10b981' }}></div>
              <span className="font-body">Visa Free</span>
            </div>
            <div className="flex items-center space-x-3">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#3b82f6' }}></div>
              <span className="font-body">eTA Required</span>
            </div>
            <div className="flex items-center space-x-3">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#f59e0b' }}></div>
              <span className="font-body">Visa Required</span>
            </div>
            <div className="flex items-center space-x-3">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#ef4444' }}></div>
              <span className="font-body">Consulate Visa Required</span>
            </div>
            <div className="flex items-center space-x-3">
              <div className="w-3 h-3 rounded-full" style={{ backgroundColor: '#1f2937' }}></div>
              <span className="font-body">Banned / Special Permission</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
} 