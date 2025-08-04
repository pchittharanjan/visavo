'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { supabase } from '@/lib/supabase'
import { UserDocument, CountryInfo } from '@/lib/types'
import { countries } from '@/lib/countries'
import { formatDate, isExpired, getDaysUntilExpiry } from '@/lib/utils'
import { getStatusLabel } from '@/lib/travel-requirements'
import { getDynamicRequirementsText } from '@/lib/dynamic-travel-requirements'
import Globe from '@/components/Globe'
import { 
  LogOut, 
  Plus, 
  X, 
  Calendar, 
  AlertTriangle, 
  CheckCircle, 
  Clock,
  MapPin,
  FileText
} from 'lucide-react'

export default function DashboardPage() {
  const [userDocuments, setUserDocuments] = useState<UserDocument[]>([])
  const [selectedCountry, setSelectedCountry] = useState<CountryInfo | null>(null)
  const [user, setUser] = useState<any>(null)
  const [isLoading, setIsLoading] = useState(true)
  const router = useRouter()

  useEffect(() => {
    checkUser()
    fetchDocuments()
  }, [])

  const checkUser = async () => {
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      router.push('/login')
      return
    }
    setUser(user)
  }

  const fetchDocuments = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      const { data, error } = await supabase
        .from('documents')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false })

      if (error) {
        console.error('Error fetching documents:', error)
      } else {
        setUserDocuments(data || [])
      }
    } catch (error) {
      console.error('Error fetching documents:', error)
    } finally {
      setIsLoading(false)
    }
  }

  const handleSignOut = async () => {
    await supabase.auth.signOut()
    router.push('/login')
  }

  const handleCountryClick = async (countryInfo: CountryInfo) => {
    try {
      const requirements = await getDynamicRequirementsText(countryInfo.status, countryInfo.code, userDocuments)
      setSelectedCountry({
        ...countryInfo,
        requirements
      })
    } catch (error) {
      console.error('Error getting requirements:', error)
      // Fallback to empty requirements
      setSelectedCountry({
        ...countryInfo,
        requirements: {}
      })
    }
  }

  const deleteDocument = async (documentId: string) => {
    try {
      const { error } = await supabase
        .from('documents')
        .delete()
        .eq('id', documentId)

      if (error) {
        console.error('Error deleting document:', error)
      } else {
        fetchDocuments()
      }
    } catch (error) {
      console.error('Error deleting document:', error)
    }
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'visa_free':
        return 'text-green-600 bg-green-100'
      case 'eta_required':
        return 'text-blue-600 bg-blue-100'
      case 'visa_on_arrival':
      case 'evisa':
        return 'text-yellow-600 bg-yellow-100'
      case 'reciprocity_fee':
        return 'text-purple-600 bg-purple-100'
      case 'consulate_visa':
        return 'text-red-600 bg-red-100'
      case 'banned':
      case 'special_permission':
        return 'text-gray-600 bg-gray-100'
      default:
        return 'text-gray-600 bg-gray-100'
    }
  }

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Loading your travel world...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      {/* Simplified Header */}
      <header className="bg-white shadow-sm border-b flex-shrink-0">
        <div className="max-w-full mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center">
              <h1 className="text-xl font-bold text-gray-900">Visavo</h1>
              <span className="ml-2 text-sm text-gray-500">Visa + Voyage</span>
            </div>
            <div className="flex items-center space-x-4">
              <span className="text-sm text-gray-600">
                Welcome, {user?.user_metadata?.display_name || 'Traveler'}
              </span>
              <button
                onClick={handleSignOut}
                className="flex items-center text-gray-600 hover:text-gray-900 transition-colors duration-150"
              >
                <LogOut className="h-4 w-4 mr-1" />
                Sign Out
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Simplified Main Content */}
      <div className="flex-1 max-w-full mx-auto px-4 sm:px-6 lg:px-8 py-4">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-4 h-full">
          
          {/* Simplified Left Panel - Documents */}
          <div className="lg:col-span-2">
            <div className="bg-white rounded-lg shadow-sm border h-full overflow-hidden">
              <div className="p-3 border-b">
                <h2 className="text-lg font-semibold text-gray-900 mb-2">Your Documents</h2>
                <button
                  onClick={() => router.push('/onboarding')}
                  className="flex items-center text-sm text-blue-600 hover:text-blue-700 transition-colors duration-150"
                >
                  <Plus className="h-4 w-4 mr-1" />
                  Add Document
                </button>
              </div>
              
              <div className="overflow-y-auto h-full p-3">
                {userDocuments.length === 0 ? (
                  <div className="text-center py-8 text-gray-500">
                    <FileText className="h-12 w-12 mx-auto mb-3 text-gray-300" />
                    <p className="font-medium text-gray-700 mb-1">No documents added</p>
                    <p className="text-sm text-gray-500 mb-3">Add your travel documents to get started</p>
                    <button
                      onClick={() => router.push('/onboarding')}
                      className="bg-blue-600 hover:bg-blue-700 text-white px-3 py-2 rounded text-sm font-medium transition-colors duration-150"
                    >
                      Add Your First Document
                    </button>
                  </div>
                ) : (
                  <div className="space-y-3">
                    {userDocuments.map((doc) => {
                      const country = countries.find(c => c.code === doc.issuing_country)
                      const isExpiredDoc = isExpired(new Date(doc.expiration_date))
                      const daysUntilExpiry = getDaysUntilExpiry(new Date(doc.expiration_date))
                      
                      return (
                        <div
                          key={doc.id}
                          className={`p-3 border rounded-lg transition-colors duration-150 ${
                            isExpiredDoc 
                              ? 'border-red-200 bg-red-50' 
                              : daysUntilExpiry < 30
                              ? 'border-yellow-200 bg-yellow-50'
                              : 'border-gray-200 bg-white'
                          }`}
                        >
                          <div className="flex items-center justify-between mb-2">
                            <div className="flex items-center space-x-2">
                              <span className="text-lg">{country?.flag}</span>
                              <div>
                                <p className="font-medium text-sm text-gray-900">
                                  {country?.name}
                                </p>
                                <p className="text-xs text-gray-600">
                                  {doc.document_type.replace('_', ' ').replace(/\b\w/g, (l: string) => l.toUpperCase())}
                                </p>
                              </div>
                            </div>
                            <button
                              onClick={() => deleteDocument(doc.id.toString())}
                              className="text-gray-400 hover:text-red-500 p-1 rounded transition-colors duration-150"
                            >
                              <X className="h-3 w-3" />
                            </button>
                          </div>
                          
                          <div className="flex items-center space-x-2">
                            <Calendar className="h-3 w-3 text-gray-400" />
                            <span className={`text-xs ${
                              isExpiredDoc ? 'text-red-600' : 
                              daysUntilExpiry < 30 ? 'text-yellow-600' : 'text-gray-600'
                            }`}>
                              {formatDate(new Date(doc.expiration_date))}
                              {isExpiredDoc && " (Expired)"}
                              {!isExpiredDoc && daysUntilExpiry < 30 && ` (${daysUntilExpiry} days left)`}
                            </span>
                          </div>
                          
                          {isExpiredDoc && (
                            <div className="mt-2 p-1 bg-red-100 rounded text-xs text-red-700">
                              ⚠️ Document has expired
                            </div>
                          )}
                          
                          {!isExpiredDoc && daysUntilExpiry < 30 && (
                            <div className="mt-2 p-1 bg-yellow-100 rounded text-xs text-yellow-700">
                              ⚠️ Expires soon
                            </div>
                          )}
                        </div>
                      )
                    })}
                  </div>
                )}
              </div>
            </div>
          </div>

          {/* Simplified Center Panel - Globe */}
          <div className="lg:col-span-8">
            <div className="bg-white rounded-lg shadow-sm border h-full overflow-hidden">
              <div className="p-3 border-b">
                <h2 className="text-lg font-semibold text-gray-900">Interactive World Map</h2>
                <p className="text-sm text-gray-600">Click on countries to see travel requirements</p>
              </div>
              
              <div className="h-full overflow-y-auto">
                <Globe 
                  userDocuments={userDocuments} 
                  onCountryClick={handleCountryClick} 
                />
              </div>
            </div>
          </div>

          {/* Simplified Right Panel - Country Details */}
          <div className="lg:col-span-2">
            <div className="bg-white rounded-lg shadow-sm border h-full overflow-hidden">
              <div className="p-3 border-b">
                <h2 className="text-lg font-semibold text-gray-900">Country Details</h2>
                <p className="text-sm text-gray-600">Travel requirements and information</p>
              </div>
              
              <div className="p-3 overflow-y-auto h-full">
                {selectedCountry ? (
                  <div className="space-y-4">
                    {/* Simplified Country Header */}
                    <div className="text-center p-3 bg-blue-50 rounded-lg border border-blue-100">
                      <div className="text-4xl mb-2">{selectedCountry.flag}</div>
                      <h3 className="text-lg font-bold text-gray-900 mb-2">
                        {selectedCountry.name}
                      </h3>
                      <div className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${getStatusColor(selectedCountry.status)}`}>
                        {getStatusLabel(selectedCountry.status)}
                      </div>
                    </div>

                    {/* Simplified Requirements */}
                    <div className="space-y-3">
                      <h4 className="font-semibold text-gray-900 text-base border-b border-gray-200 pb-1">Entry Requirements</h4>
                      
                      {selectedCountry.requirements.passportValidity && (
                        <div className="flex items-start space-x-2 p-2 bg-green-50 rounded border border-green-200">
                          <CheckCircle className="h-4 w-4 text-green-600 mt-0.5 flex-shrink-0" />
                          <div>
                            <p className="text-sm font-medium text-gray-900">Passport Validity</p>
                            <p className="text-xs text-gray-700">{selectedCountry.requirements.passportValidity}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.allowedStay && (
                        <div className="flex items-start space-x-2 p-2 bg-blue-50 rounded border border-blue-200">
                          <Clock className="h-4 w-4 text-blue-600 mt-0.5 flex-shrink-0" />
                          <div>
                            <p className="text-sm font-medium text-gray-900">Allowed Stay</p>
                            <p className="text-xs text-gray-700">{selectedCountry.requirements.allowedStay}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.visaFee && (
                        <div className="flex items-start space-x-2 p-2 bg-emerald-50 rounded border border-emerald-200">
                          <span className="text-sm font-bold text-emerald-600 mt-0.5 flex-shrink-0">$</span>
                          <div>
                            <p className="text-sm font-medium text-gray-900">Visa Fee</p>
                            <p className="text-xs text-gray-700">{selectedCountry.requirements.visaFee}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.processingTime && (
                        <div className="flex items-start space-x-2 p-2 bg-purple-50 rounded border border-purple-200">
                          <span className="text-sm font-bold text-purple-600 mt-0.5 flex-shrink-0">⏱</span>
                          <div>
                            <p className="text-sm font-medium text-gray-900">Processing Time</p>
                            <p className="text-xs text-gray-700">{selectedCountry.requirements.processingTime}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.notes && (
                        <div className="flex items-start space-x-2 p-2 bg-yellow-50 rounded border border-yellow-200">
                          <AlertTriangle className="h-4 w-4 text-yellow-600 mt-0.5 flex-shrink-0" />
                          <div>
                            <p className="text-sm font-medium text-gray-900">Important Notes</p>
                            <p className="text-xs text-gray-700">{selectedCountry.requirements.notes}</p>
                          </div>
                        </div>
                      )}
                    </div>

                    {/* Simplified Disclaimer */}
                    <div className="mt-4 p-3 bg-yellow-50 rounded border border-yellow-200">
                      <div className="flex items-start space-x-2">
                        <AlertTriangle className="h-4 w-4 text-yellow-600 mt-0.5 flex-shrink-0" />
                        <div>
                          <h5 className="font-medium text-yellow-800 mb-1 text-sm">Important Disclaimer</h5>
                          <p className="text-xs text-yellow-700">
                            This information is for reference only. Always verify current requirements with official sources before travel.
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                ) : (
                  <div className="text-center py-8 text-gray-500">
                    <MapPin className="h-12 w-12 mx-auto mb-3 text-gray-300" />
                    <h3 className="font-medium text-gray-700 mb-1">Select a Country</h3>
                    <p className="text-sm text-gray-500">Click on any country on the map to see travel requirements</p>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
} 