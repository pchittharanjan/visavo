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
        return 'bg-green-500 text-white'
      case 'eta_required':
        return 'bg-blue-500 text-white'
      case 'visa_required':
        return 'bg-yellow-500 text-white'
      case 'consulate_visa':
        return 'bg-red-500 text-white'
      case 'banned':
        return 'bg-gray-800 text-white'
      default:
        return 'bg-gray-500 text-white'
    }
  }

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600 font-body">Loading your dashboard...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-white border-b border-gray-200 px-6 py-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <div className="w-8 h-8 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center">
              <span className="text-white font-display font-bold text-lg">V</span>
            </div>
            <h1 className="text-xl font-display font-bold text-gray-900">Visavo Visa + Voyage</h1>
          </div>
          <div className="flex items-center space-x-4">
            <span className="text-sm text-gray-600 font-body">Welcome, {user?.email?.split('@')[0] || 'User'}</span>
            <button
              onClick={handleSignOut}
              className="flex items-center space-x-2 text-gray-600 hover:text-gray-900 transition-colors duration-150 font-body"
            >
              <LogOut className="h-4 w-4" />
              <span>Sign Out</span>
            </button>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="p-6">
        <div className="grid grid-cols-12 gap-6 h-[calc(100vh-140px)]">
          {/* Left Panel - Documents */}
          <div className="col-span-3">
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 h-full overflow-hidden">
              <div className="p-6 border-b border-gray-100">
                <h2 className="text-lg font-display font-bold text-gray-900 mb-2">Your Documents</h2>
                <p className="text-sm text-gray-600 font-body">Manage your travel documents</p>
              </div>
              
              <div className="p-6 overflow-y-auto h-full">
                <button className="w-full mb-6 p-4 border-2 border-dashed border-gray-300 rounded-lg hover:border-blue-400 hover:bg-blue-50 transition-colors duration-150 group">
                  <div className="flex items-center justify-center space-x-2">
                    <Plus className="h-5 w-5 text-gray-400 group-hover:text-blue-500" />
                    <span className="text-gray-600 group-hover:text-blue-600 font-body font-medium">Add Document</span>
                  </div>
                </button>

                {userDocuments.length === 0 ? (
                  <div className="text-center py-8">
                    <FileText className="h-12 w-12 mx-auto mb-3 text-gray-300" />
                    <h3 className="font-medium text-gray-700 mb-1 font-body">No Documents</h3>
                    <p className="text-sm text-gray-500 font-body">Add your first travel document to get started</p>
                  </div>
                ) : (
                  <div className="space-y-4">
                    {userDocuments.map((doc) => {
                      const country = countries.find(c => c.code === doc.issuing_country)
                      const isExpiredDoc = isExpired(new Date(doc.expiration_date))
                      const daysUntilExpiry = getDaysUntilExpiry(new Date(doc.expiration_date))
                      
                      return (
                        <div
                          key={doc.id}
                          className={`p-4 border rounded-lg transition-colors duration-150 ${
                            isExpiredDoc 
                              ? 'border-red-200 bg-red-50' 
                              : daysUntilExpiry < 30
                              ? 'border-yellow-200 bg-yellow-50'
                              : 'border-gray-200 bg-white'
                          }`}
                        >
                          <div className="flex items-center justify-between mb-3">
                            <div className="flex items-center space-x-3">
                              <span className="text-xl">{country?.flag}</span>
                              <div>
                                <p className="font-medium text-sm text-gray-900 font-body">
                                  {country?.name}
                                </p>
                                <p className="text-xs text-gray-600 font-body">
                                  {doc.document_type.replace('_', ' ').replace(/\b\w/g, (l: string) => l.toUpperCase())}
                                </p>
                              </div>
                            </div>
                            <button
                              onClick={() => deleteDocument(doc.id.toString())}
                              className="text-gray-400 hover:text-red-500 p-1 rounded transition-colors duration-150"
                            >
                              <X className="h-4 w-4" />
                            </button>
                          </div>
                          
                          <div className="flex items-center space-x-2">
                            <Calendar className="h-4 w-4 text-gray-400" />
                            <span className={`text-xs font-body ${
                              isExpiredDoc ? 'text-red-600' : 
                              daysUntilExpiry < 30 ? 'text-yellow-600' : 'text-gray-600'
                            }`}>
                              {formatDate(new Date(doc.expiration_date))}
                              {isExpiredDoc && " (Expired)"}
                              {!isExpiredDoc && daysUntilExpiry < 30 && ` (${daysUntilExpiry} days left)`}
                            </span>
                          </div>
                          
                          {isExpiredDoc && (
                            <div className="mt-3 p-2 bg-red-100 rounded text-xs text-red-700 font-body">
                              ⚠️ Document has expired
                            </div>
                          )}
                          
                          {!isExpiredDoc && daysUntilExpiry < 30 && (
                            <div className="mt-3 p-2 bg-yellow-100 rounded text-xs text-yellow-700 font-body">
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

          {/* Center Panel - Globe with more padding */}
          <div className="col-span-6">
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 h-full overflow-hidden">
              <div className="p-6 border-b border-gray-100">
                <h2 className="text-lg font-display font-bold text-gray-900 mb-2">Interactive World Map</h2>
                <p className="text-sm text-gray-600 font-body">Click on countries to see travel requirements</p>
              </div>
              
              <div className="h-full overflow-y-auto px-6">
                <Globe 
                  userDocuments={userDocuments} 
                  onCountryClick={handleCountryClick} 
                />
              </div>
            </div>
          </div>

          {/* Right Panel - Country Details (wider) */}
          <div className="col-span-3">
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 h-full overflow-hidden">
              <div className="p-6 border-b border-gray-100">
                <h2 className="text-lg font-display font-bold text-gray-900 mb-2">Country Details</h2>
                <p className="text-sm text-gray-600 font-body">Travel requirements and information</p>
              </div>
              
              <div className="p-6 overflow-y-auto h-full">
                {selectedCountry ? (
                  <div className="space-y-6">
                    {/* Country Header */}
                    <div className="text-center p-6 bg-gradient-to-br from-blue-50 to-indigo-50 rounded-xl border border-blue-100">
                      <div className="text-5xl mb-4">{selectedCountry.flag}</div>
                      <h3 className="text-xl font-display font-bold text-gray-900 mb-3">
                        {selectedCountry.name}
                      </h3>
                      <div className={`inline-flex items-center px-4 py-2 rounded-full text-sm font-medium font-body ${getStatusColor(selectedCountry.status)}`}>
                        {getStatusLabel(selectedCountry.status)}
                      </div>
                    </div>

                    {/* Requirements */}
                    <div className="space-y-4">
                      <h4 className="font-display font-bold text-gray-900 text-lg border-b border-gray-200 pb-2">Entry Requirements</h4>
                      
                      {selectedCountry.requirements.passportValidity && (
                        <div className="flex items-start space-x-3 p-4 bg-green-50 rounded-lg border border-green-200">
                          <CheckCircle className="h-5 w-5 text-green-600 mt-0.5 flex-shrink-0" />
                          <div>
                            <p className="text-sm font-medium text-gray-900 font-body">Passport Validity</p>
                            <p className="text-sm text-gray-700 font-body">{selectedCountry.requirements.passportValidity}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.allowedStay && (
                        <div className="flex items-start space-x-3 p-4 bg-blue-50 rounded-lg border border-blue-200">
                          <Clock className="h-5 w-5 text-blue-600 mt-0.5 flex-shrink-0" />
                          <div>
                            <p className="text-sm font-medium text-gray-900 font-body">Allowed Stay</p>
                            <p className="text-sm text-gray-700 font-body">{selectedCountry.requirements.allowedStay}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.visaFee && (
                        <div className="flex items-start space-x-3 p-4 bg-emerald-50 rounded-lg border border-emerald-200">
                          <span className="text-lg font-bold text-emerald-600 mt-0.5 flex-shrink-0">$</span>
                          <div>
                            <p className="text-sm font-medium text-gray-900 font-body">Visa Fee</p>
                            <p className="text-sm text-gray-700 font-body">{selectedCountry.requirements.visaFee}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.processingTime && (
                        <div className="flex items-start space-x-3 p-4 bg-purple-50 rounded-lg border border-purple-200">
                          <span className="text-lg font-bold text-purple-600 mt-0.5 flex-shrink-0">⏱</span>
                          <div>
                            <p className="text-sm font-medium text-gray-900 font-body">Processing Time</p>
                            <p className="text-sm text-gray-700 font-body">{selectedCountry.requirements.processingTime}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.notes && (
                        <div className="flex items-start space-x-3 p-4 bg-yellow-50 rounded-lg border border-yellow-200">
                          <AlertTriangle className="h-5 w-5 text-yellow-600 mt-0.5 flex-shrink-0" />
                          <div>
                            <p className="text-sm font-medium text-gray-900 font-body">Important Notes</p>
                            <p className="text-sm text-gray-700 font-body">{selectedCountry.requirements.notes}</p>
                          </div>
                        </div>
                      )}
                    </div>

                    {/* Disclaimer */}
                    <div className="mt-6 p-4 bg-yellow-50 rounded-lg border border-yellow-200">
                      <div className="flex items-start space-x-3">
                        <AlertTriangle className="h-5 w-5 text-yellow-600 mt-0.5 flex-shrink-0" />
                        <div>
                          <h5 className="font-medium text-yellow-800 mb-2 text-sm font-body">Important Disclaimer</h5>
                          <p className="text-sm text-yellow-700 font-body">
                            This information is for reference only. Always verify current requirements with official sources before travel.
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                ) : (
                  <div className="text-center py-12 text-gray-500">
                    <MapPin className="h-16 w-16 mx-auto mb-4 text-gray-300" />
                    <h3 className="font-medium text-gray-700 mb-2 font-body text-lg">Select a Country</h3>
                    <p className="text-sm text-gray-500 font-body">Click on any country on the map to see travel requirements</p>
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