'use client'

import { useState } from 'react'
import { UserDocument } from '@/lib/types'
import { Users, Globe, Award, ChevronDown, ChevronUp, AlertTriangle } from 'lucide-react'

interface DualCitizenshipIndicatorProps {
  userDocuments: UserDocument[]
}

export default function DualCitizenshipIndicator({ userDocuments }: DualCitizenshipIndicatorProps) {
  const [isExpanded, setIsExpanded] = useState(false)

  const passports = userDocuments.filter(doc => doc.document_type === 'passport')
  
  if (passports.length <= 1) return null

  const passportCountries = passports.map(p => p.issuing_country)
  const uniqueCountries = [...new Set(passportCountries)]

  const getBenefits = () => {
    const benefits = []
    
    if (uniqueCountries.length >= 2) {
      benefits.push('Access to multiple visa-free destinations')
      benefits.push('Flexible travel options')
      benefits.push('Better visa requirements')
    }

    return benefits
  }

  const getStatusColor = () => {
    if (uniqueCountries.length >= 4) return 'bg-indigo-500'
    if (uniqueCountries.length >= 3) return 'bg-purple-500'
    if (uniqueCountries.length >= 2) return 'bg-green-500'
    return 'bg-blue-500'
  }

  const getStatusText = () => {
    if (uniqueCountries.length >= 4) return 'Global Citizen'
    if (uniqueCountries.length >= 3) return 'Triple Citizen'
    if (uniqueCountries.length >= 2) return 'Dual Citizen'
    return 'Single Citizen'
  }

  return (
    <div className="bg-white border border-gray-200 rounded-lg p-4">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className={`p-2 rounded-full ${getStatusColor()} text-white`}>
            <Users size={16} />
          </div>
          <div>
            <h3 className="text-lg font-display font-bold text-gray-900 mb-1">
              {getStatusText()}
            </h3>
            <p className="text-xs text-gray-600 font-body">
              {uniqueCountries.length} passport{uniqueCountries.length > 1 ? 's' : ''}: {uniqueCountries.join(', ')}
            </p>
          </div>
        </div>
        
        <button
          onClick={() => setIsExpanded(!isExpanded)}
          className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors"
        >
          {isExpanded ? <ChevronUp size={20} /> : <ChevronDown size={20} />}
        </button>
      </div>

      {isExpanded && (
        <div className="mt-4 pt-4 border-t border-blue-200 dark:border-blue-800">
          <div className="space-y-3">
            <div>
              <h4 className="font-display font-bold text-gray-900 text-base border-b border-gray-200 pb-2 mb-3 flex items-center gap-2">
                <Award size={16} />
                Travel Benefits
              </h4>
              <ul className="space-y-2">
                {getBenefits().map((benefit, index) => (
                  <li key={index} className="text-xs text-gray-700 font-body flex items-center gap-2">
                    <div className="w-1.5 h-1.5 bg-green-500 rounded-full flex-shrink-0"></div>
                    {benefit}
                  </li>
                ))}
              </ul>
            </div>

            <div>
              <h4 className="font-display font-bold text-gray-900 text-base border-b border-gray-200 pb-2 mb-3 flex items-center gap-2">
                <Globe size={16} />
                Passport Details
              </h4>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                {passports.map((passport, index) => (
                  <div key={index} className="flex items-center gap-2 p-2 bg-gray-50 rounded border border-gray-200">
                    <span className="text-sm">
                      {passport.issuing_country === 'CA' ? '🇨🇦' :
                       passport.issuing_country === 'US' ? '🇺🇸' :
                       passport.issuing_country === 'GB' ? '🇬🇧' :
                       passport.issuing_country === 'AU' ? '🇦🇺' :
                       passport.issuing_country === 'DE' ? '🇩🇪' :
                       passport.issuing_country === 'FR' ? '🇫🇷' :
                       passport.issuing_country === 'JP' ? '🇯🇵' :
                       passport.issuing_country === 'SG' ? '🇸🇬' :
                       passport.issuing_country === 'NZ' ? '🇳🇿' :
                       passport.issuing_country === 'CH' ? '🇨🇭' :
                       '🏳️'}
                    </span>
                    <span className="text-xs font-medium text-gray-900 font-body">
                      {passport.issuing_country}
                    </span>
                    <span className="text-xs text-gray-500 font-body">
                      Passport
                    </span>
                  </div>
                ))}
              </div>
            </div>

            <div className="flex items-start space-x-2 p-3 bg-yellow-50 rounded-lg border border-yellow-200">
              <AlertTriangle className="h-4 w-4 text-yellow-600 mt-0.5 flex-shrink-0" />
              <div>
                <p className="text-xs font-medium text-yellow-900 font-body">Smart Selection</p>
                <p className="text-xs text-yellow-700 font-body">
                  The system automatically selects the best passport for each destination to give you the most favorable travel conditions.
                </p>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
} 