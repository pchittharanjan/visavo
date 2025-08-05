'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { supabase } from '@/lib/supabase'
import { UserDocument, CountryInfo } from '@/lib/types'
import { countries } from '@/lib/countries'
import { formatDate, isExpired, getDaysUntilExpiry } from '@/lib/utils'
import { getStatusLabel, getStatusColor } from '@/lib/simple-travel-requirements'
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
            <h1 className="text-3xl font-display font-bold text-gray-900">visavo</h1>
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
        <div className="grid grid-cols-12 gap-6 min-h-[calc(100vh-140px)]">
          {/* Left Panel - Documents */}
          <div className="col-span-3">
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 flex flex-col">
              <div className="p-6 border-b border-gray-100 flex-shrink-0">
                <h2 className="text-lg font-display font-bold text-gray-900 mb-1">Your Documents</h2>
                <p className="text-xs text-gray-600 font-body">Manage your travel documents</p>
              </div>
              
              <div className="p-4 flex-1 overflow-y-auto">
                <button 
                  onClick={() => router.push('/onboarding')}
                  className="w-full p-3 border-2 border-dashed border-gray-300 rounded-lg text-gray-600 hover:border-blue-400 hover:text-blue-600 transition-colors duration-150 mb-6 flex items-center justify-center space-x-2 font-body text-sm"
                >
                  <Plus className="h-4 w-4" />
                  <span>Add Document</span>
                </button>

                {isLoading ? (
                  <div className="text-center py-8">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
                    <p className="text-xs text-gray-500 mt-2 font-body">Loading documents...</p>
                  </div>
                ) : userDocuments.length === 0 ? (
                  <div className="text-center py-8">
                    <FileText className="h-8 w-8 text-gray-400 mx-auto mb-2" />
                    <p className="text-xs text-gray-500 font-body">No documents added yet</p>
                    <p className="text-xs text-gray-400 font-body">Add your passport to get started</p>
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
                          className={`p-3 rounded-lg border transition-colors duration-150 ${
                            isExpiredDoc 
                              ? 'bg-red-50 border-red-200' 
                              : daysUntilExpiry < 30 
                                ? 'bg-yellow-50 border-yellow-200'
                                : 'bg-gray-50 border-gray-200'
                          }`}
                        >
                          <div className="flex items-start space-x-3 mb-2">
                            <span className="text-lg mt-0.5">{country?.flag}</span>
                            <div className="flex-1">
                              <p className="font-medium text-xs text-gray-900 font-body">
                                {country?.name}
                              </p>
                              <p className="text-xs text-gray-600 font-body">
                                {doc.document_type.replace('_', ' ').replace(/\b\w/g, (l: string) => l.toUpperCase())}
                              </p>
                            </div>
                          </div>
                          <div className="flex items-center space-x-3">
                            <Calendar className="h-4 w-4 text-gray-400" />
                            <span className={`text-xs font-body pt-[1px] ${
                              isExpiredDoc ? 'text-red-600' : 
                              daysUntilExpiry < 30 ? 'text-yellow-600' : 'text-gray-600'
                            }`}>
                              {formatDate(new Date(doc.expiration_date))}
                              {isExpiredDoc && " (Expired)"}
                              {!isExpiredDoc && daysUntilExpiry < 30 && ` (${daysUntilExpiry} days left)`}
                            </span>
                          </div>
                          <button
                            onClick={() => deleteDocument(doc.id.toString())}
                            className="text-gray-400 hover:text-red-500 p-1 rounded transition-colors duration-150 absolute top-2 right-2"
                          >
                            <X className="h-3 w-3" />
                          </button>
                          
                          {isExpiredDoc && (
                            <div className="mt-2 p-2 bg-red-100 rounded text-xs text-red-700 font-body">
                              ⚠️ Document has expired
                            </div>
                          )}
                          
                          {!isExpiredDoc && daysUntilExpiry < 30 && (
                            <div className="mt-2 p-2 bg-yellow-100 rounded text-xs text-yellow-700 font-body">
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
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 flex flex-col">
              <div className="p-6 border-b border-gray-100 flex-shrink-0">
                <h2 className="text-lg font-display font-bold text-gray-900 mb-1">Interactive World Map</h2>
                <p className="text-xs text-gray-600 font-body">Click on countries to see travel requirements</p>
              </div>
              
              <div className="flex-1 overflow-y-auto px-4">
                <Globe 
                  userDocuments={userDocuments} 
                  onCountryClick={handleCountryClick} 
                />
              </div>
            </div>
          </div>

          {/* Right Panel - Country Details (wider) */}
          <div className="col-span-3">
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 flex flex-col">
              <div className="p-6 border-b border-gray-100 flex-shrink-0">
                <h2 className="text-lg font-display font-bold text-gray-900 mb-1">Country Details</h2>
                <p className="text-xs text-gray-600 font-body">Travel requirements and information</p>
              </div>
              
              <div className="p-4 flex-1 overflow-y-auto">
                {selectedCountry ? (
                  <div className="space-y-4">
                    {/* Country Header */}
                    <div className="text-center p-4 bg-gray-50 rounded-xl border border-gray-200">
                      <div className="text-4xl mb-3">{selectedCountry.flag}</div>
                      <h3 className="text-lg font-display font-bold text-gray-900 mb-2">
                        {selectedCountry.name}
                      </h3>
                      <div className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-medium font-body text-white`} style={{ backgroundColor: getStatusColor(selectedCountry.status) }}>
                        {getStatusLabel(selectedCountry.status)}
                      </div>
                    </div>

                    {/* Requirements */}
                    <div className="space-y-3">
                      <h4 className="font-display font-bold text-gray-900 text-base border-b border-gray-200 pb-2">Entry Requirements</h4>
                      
                      {selectedCountry.requirements.passportValidity && (
                        <div className="flex items-start space-x-2 p-3 bg-green-50 rounded-lg border border-green-200">
                          <CheckCircle className="h-4 w-4 text-green-600 mt-0.5 flex-shrink-0" />
                          <div>
                            <p className="text-xs font-medium text-green-900 font-body">Passport Validity</p>
                            <p className="text-xs text-green-700 font-body">{selectedCountry.requirements.passportValidity}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.allowedStay && (
                        <div className="flex items-start space-x-2 p-3 bg-gray-50 rounded-lg border border-gray-200">
                          <Clock className="h-4 w-4 text-gray-600 mt-0.5 flex-shrink-0" />
                          <div>
                            <p className="text-xs font-medium text-gray-900 font-body">Allowed Stay</p>
                            <p className="text-xs text-gray-700 font-body">{selectedCountry.requirements.allowedStay}</p>
                          </div>
                        </div>
                      )}

                      {selectedCountry.requirements.notes && (
                        <div className="flex items-start space-x-2 p-3 bg-blue-50 rounded-lg border border-blue-200">
                          <MapPin className="h-4 w-4 text-blue-600 mt-0.5 flex-shrink-0" />
                          <div>
                            <p className="text-xs font-medium text-blue-900 font-body">Additional Notes</p>
                            <p className="text-xs text-blue-700 font-body">{selectedCountry.requirements.notes}</p>
                          </div>
                        </div>
                      )}
                    </div>

                    {/* Disclaimer */}
                    <div className="flex items-start space-x-2 p-3 bg-yellow-50 rounded-lg border border-yellow-200">
                      <AlertTriangle className="h-4 w-4 text-yellow-600 mt-0.5 flex-shrink-0" />
                      <div>
                        <p className="text-xs font-medium text-yellow-900 font-body">Important Disclaimer</p>
                        <p className="text-xs text-yellow-700 font-body">
                          This information is for reference only. Always verify current requirements with official sources before travel.
                        </p>
                      </div>
                    </div>
                  </div>
                ) : (
                  <div className="text-center py-8">
                    <MapPin className="h-8 w-8 text-gray-400 mx-auto mb-2" />
                    <p className="text-xs text-gray-500 font-body">Select a country on the map</p>
                    <p className="text-xs text-gray-400 font-body">to see travel requirements</p>
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