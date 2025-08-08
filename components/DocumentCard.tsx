'use client'

import { useState, useEffect } from 'react'
import { UserDocument, Country } from '@/lib/types'
import { formatDate, isExpired, getDaysUntilExpiry } from '@/lib/utils'
import { getCountries } from '@/lib/countries'
import { supabase } from '@/lib/supabase'
import { X, Calendar } from 'lucide-react'

interface DocumentCardProps {
  document: UserDocument
  onDelete?: (documentId: string) => void
  className?: string
}

export default function DocumentCard({ document, onDelete, className = '' }: DocumentCardProps) {
  const [countries, setCountries] = useState<Country[]>([])
  const [country, setCountry] = useState<Country | undefined>()
  const [documentTypeDescription, setDocumentTypeDescription] = useState<string>('')

  useEffect(() => {
    fetchCountries()
    fetchDocumentTypeDescription()
  }, [])

  useEffect(() => {
    if (countries.length > 0) {
      const foundCountry = countries.find(c => c.code === document.issuing_country)
      setCountry(foundCountry)
    }
  }, [countries, document.issuing_country])

  const fetchCountries = async () => {
    try {
      const countriesData = await getCountries()
      setCountries(countriesData)
    } catch (error) {
      console.error('Error fetching countries:', error)
    }
  }

  const fetchDocumentTypeDescription = async () => {
    try {
      const { data, error } = await supabase
        .from('document_types')
        .select('description')
        .eq('name', document.document_type)
        .single()
      
      if (error) {
        console.error('Error fetching document type description:', error)
        setDocumentTypeDescription(document.document_type)
      } else {
        setDocumentTypeDescription(data.description || document.document_type)
      }
    } catch (error) {
      console.error('Error in fetchDocumentTypeDescription:', error)
      setDocumentTypeDescription(document.document_type)
    }
  }

  const isExpiredDoc = isExpired(new Date(document.expiration_date))
  const daysUntilExpiry = getDaysUntilExpiry(new Date(document.expiration_date))
  
  return (
    <div
      className={`p-3 rounded-lg border transition-colors duration-150 relative ${
        isExpiredDoc 
          ? 'bg-red-50 border-red-200' 
          : daysUntilExpiry < 30 
            ? 'bg-yellow-50 border-yellow-200'
            : 'bg-gray-50 border-gray-200'
      } ${className}`}
    >
      <div className="flex items-start space-x-3 mb-2">
        <span className="text-lg mt-0.5">{country?.flag}</span>
        <div className="flex-1">
          <p className="font-medium text-xs text-gray-900 font-body">
            {country?.name}
          </p>
          <p className="text-xs text-gray-600 font-body">
            {documentTypeDescription}
          </p>
        </div>
      </div>
      <div className="flex items-center space-x-3">
        <Calendar className="h-4 w-4 text-gray-600" />
        <span className={`text-xs font-body pt-[1px] ${
          isExpiredDoc ? 'text-red-600' : 
          daysUntilExpiry < 30 ? 'text-yellow-600' : 'text-gray-600'
        }`}>
          {formatDate(new Date(document.expiration_date))}
          {isExpiredDoc && " (Expired)"}
          {!isExpiredDoc && daysUntilExpiry < 30 && ` (${daysUntilExpiry} days left)`}
        </span>
      </div>
      {onDelete && (
        <button
          onClick={() => onDelete(document.id.toString())}
          className="text-gray-600 hover:text-red-500 p-1 rounded transition-colors duration-150 absolute top-2 right-2"
        >
          <X className="h-3 w-3" />
        </button>
      )}
      
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
} 