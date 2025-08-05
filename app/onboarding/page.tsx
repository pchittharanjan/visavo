'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'
import { supabase } from '@/lib/supabase'
import { cn } from '@/lib/utils'
import { countries, getDocumentTypesForCountry } from '@/lib/countries'
import { UserDocument, DocumentType } from '@/lib/types'
import { formatDate, isExpired } from '@/lib/utils'
import { Plus, X, Calendar, Globe, FileText, AlertCircle } from 'lucide-react'

const documentSchema = z.object({
  issuingCountry: z.string().min(1, 'Please select a country'),
  documentType: z.string().min(1, 'Please select a document type'),
  expirationDate: z.string().min(1, 'Please select an expiration date')
})

type DocumentForm = z.infer<typeof documentSchema>

export default function OnboardingPage() {
  const [documents, setDocuments] = useState<UserDocument[]>([])
  const [isLoading, setIsLoading] = useState(false)
  const [message, setMessage] = useState<{ type: 'success' | 'error', text: string } | null>(null)
  const [selectedCountry, setSelectedCountry] = useState('')
  const router = useRouter()

  const {
    register,
    handleSubmit,
    reset,
    watch,
    formState: { errors }
  } = useForm<DocumentForm>({
    resolver: zodResolver(documentSchema)
  })

  const watchedCountry = watch('issuingCountry')

  useEffect(() => {
    setSelectedCountry(watchedCountry)
  }, [watchedCountry])

  const onSubmit = async (data: DocumentForm) => {
    setIsLoading(true)
    setMessage(null)

    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) {
        setMessage({ type: 'error', text: 'User not authenticated' })
        return
      }

      const newDocument = {
        user_id: user.id,
        issuing_country: data.issuingCountry,
        document_type: data.documentType as DocumentType,
        expiration_date: data.expirationDate
      }

      const { error } = await supabase
        .from('documents')
        .insert([newDocument])

      if (error) {
        setMessage({ type: 'error', text: error.message })
      } else {
        setMessage({ type: 'success', text: 'Document added successfully!' })
        reset()
        // Refresh documents list
        fetchDocuments()
      }
    } catch (error) {
      setMessage({ type: 'error', text: 'An unexpected error occurred' })
    } finally {
      setIsLoading(false)
    }
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
        setDocuments(data || [])
      }
    } catch (error) {
      console.error('Error fetching documents:', error)
    }
  }

  const deleteDocument = async (documentId: string) => {
    try {
      const { error } = await supabase
        .from('documents')
        .delete()
        .eq('id', documentId)

      if (error) {
        setMessage({ type: 'error', text: error.message })
      } else {
        setMessage({ type: 'success', text: 'Document deleted successfully!' })
        fetchDocuments()
      }
    } catch (error) {
      setMessage({ type: 'error', text: 'An unexpected error occurred' })
    }
  }

  const continueToDashboard = () => {
    router.push('/dashboard')
  }

  useEffect(() => {
    fetchDocuments()
  }, [])

  const documentTypes = selectedCountry ? getDocumentTypesForCountry(selectedCountry) : []

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-white border-b border-gray-200 px-6 py-4">
        <div className="flex items-center space-x-3">
          <div className="w-8 h-8 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center">
            <span className="text-white font-display font-bold text-lg">V</span>
          </div>
          <h1 className="text-3xl font-display font-bold text-gray-900">visavo</h1>
        </div>
      </div>

      {/* Main Content */}
      <div className="p-6">
        <div className="max-w-4xl mx-auto">
          <div className="text-center mb-8">
            <h2 className="text-2xl font-display font-bold text-gray-900 mb-2">Add Your Documents</h2>
            <p className="text-sm text-gray-600 font-body">
              Add your US, Canada, or Mexico passport to unlock your travel possibilities
            </p>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {/* Add Document Form */}
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
              <h2 className="text-lg font-display font-bold text-gray-900 mb-4">Add New Document</h2>
              
              <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
                {/* Issuing Country */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    <Globe className="inline h-4 w-4 mr-1" />
                    Issuing Country
                  </label>
                  <select
                    {...register('issuingCountry')}
                    className={cn(
                      "w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white text-gray-900",
                      errors.issuingCountry ? "border-red-300" : "border-gray-300"
                    )}
                  >
                    <option value="">Select a country</option>
                    {countries.map((country) => (
                      <option key={country.code} value={country.code}>
                        {country.flag} {country.name}
                      </option>
                    ))}
                  </select>
                  {errors.issuingCountry && (
                    <p className="mt-1 text-sm text-red-600">{errors.issuingCountry.message}</p>
                  )}
                </div>

                {/* Document Type */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    <FileText className="inline h-4 w-4 mr-1" />
                    Document Type
                  </label>
                  <select
                    {...register('documentType')}
                    className={cn(
                      "w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white text-gray-900",
                      errors.documentType ? "border-red-300" : "border-gray-300"
                    )}
                    disabled={!selectedCountry}
                  >
                    <option value="">Select document type</option>
                    <option value="passport">Passport</option>
                  </select>
                  {errors.documentType && (
                    <p className="mt-1 text-sm text-red-600">{errors.documentType.message}</p>
                  )}
                </div>

                {/* Expiration Date */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    <Calendar className="inline h-4 w-4 mr-1" />
                    Expiration Date
                  </label>
                  <input
                    {...register('expirationDate')}
                    type="date"
                    className={cn(
                      "w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white text-gray-900",
                      errors.expirationDate ? "border-red-300" : "border-gray-300"
                    )}
                  />
                  {errors.expirationDate && (
                    <p className="mt-1 text-sm text-red-600">{errors.expirationDate.message}</p>
                  )}
                </div>

                {/* Message */}
                {message && (
                  <div className={cn(
                    "flex items-center p-3 rounded-md",
                    message.type === 'success' ? "bg-green-50 text-green-800" : "bg-red-50 text-red-800"
                  )}>
                    <AlertCircle className="h-5 w-5 mr-2" />
                    {message.text}
                  </div>
                )}

                {/* Submit Button */}
                <button
                  type="submit"
                  disabled={isLoading}
                  className="w-full flex justify-center items-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  <Plus className="h-4 w-4 mr-2" />
                  {isLoading ? 'Adding...' : 'Add Document'}
                </button>
              </form>
            </div>

            {/* Documents List */}
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
              <h2 className="text-lg font-display font-bold text-gray-900 mb-4">Your Documents</h2>
              
              {documents.length === 0 ? (
                <div className="text-center py-8 text-gray-500">
                  <FileText className="h-12 w-12 mx-auto mb-4 text-gray-300" />
                  <p>No documents added yet</p>
                  <p className="text-sm">Add your first document to get started</p>
                </div>
              ) : (
                <div className="space-y-3">
                  {documents.map((doc) => {
                    const country = countries.find(c => c.code === doc.issuing_country)
                    const isExpiredDoc = isExpired(new Date(doc.expiration_date))
                    
                    return (
                      <div
                        key={doc.id}
                        className={cn(
                          "flex items-center justify-between p-3 border rounded-lg",
                          isExpiredDoc ? "border-red-200 bg-red-50" : "border-gray-200"
                        )}
                      >
                        <div className="flex items-center space-x-3">
                          <span className="text-2xl">{country?.flag}</span>
                          <div>
                            <p className="font-medium text-gray-900">
                              {country?.name}
                            </p>
                            <p className="text-sm text-gray-600">
                              {doc.document_type.replace('_', ' ').replace(/\b\w/g, (l: string) => l.toUpperCase())}
                            </p>
                            <p className={cn(
                              "text-xs",
                              isExpiredDoc ? "text-red-600" : "text-gray-500"
                            )}>
                              Expires: {formatDate(new Date(doc.expiration_date))}
                              {isExpiredDoc && " (Expired)"}
                            </p>
                          </div>
                        </div>
                        <button
                          onClick={() => deleteDocument(doc.id.toString())}
                          className="text-red-500 hover:text-red-700 p-1"
                        >
                          <X className="h-4 w-4" />
                        </button>
                      </div>
                    )
                  })}
                </div>
              )}

              {documents.length > 0 && (
                <div className="mt-6">
                  <button
                    onClick={continueToDashboard}
                    className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500"
                  >
                    Continue to Dashboard
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

