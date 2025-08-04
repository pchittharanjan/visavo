'use client'

import { useState, useEffect } from 'react'
import { supabase } from '@/lib/supabase'
import { TravelStatus } from '@/lib/types'
import { getCountriesFromDB, getVisaRequirementsForPassport } from '@/lib/dynamic-travel-requirements'
import { Plus, Edit, Trash2, Save, X } from 'lucide-react'

interface Country {
  code: string
  name: string
  flag: string
}

interface VisaRequirement {
  id: number
  passport_country: string
  destination_country: string
  status: TravelStatus
  allowed_stay_days: number
  visa_fee_amount: number
  visa_fee_currency: string
  processing_time_days: number
  notes: string
  destination_country_info?: {
    code: string
    name: string
    flag: string
  }
}

export default function AdminPage() {
  const [countries, setCountries] = useState<Country[]>([])
  const [requirements, setRequirements] = useState<VisaRequirement[]>([])
  const [selectedPassportCountry, setSelectedPassportCountry] = useState('US')
  const [isLoading, setIsLoading] = useState(true)
  const [editingRequirement, setEditingRequirement] = useState<VisaRequirement | null>(null)
  const [newRequirement, setNewRequirement] = useState({
    destination_country: '',
    status: 'visa_free' as TravelStatus,
    allowed_stay_days: 90,
    visa_fee_amount: 0,
    visa_fee_currency: 'USD',
    processing_time_days: 0,
    notes: ''
  })

  useEffect(() => {
    loadData()
  }, [selectedPassportCountry])

  const loadData = async () => {
    setIsLoading(true)
    try {
      const [countriesData, requirementsData] = await Promise.all([
        getCountriesFromDB(),
        getVisaRequirementsForPassport(selectedPassportCountry)
      ])
      setCountries(countriesData)
      setRequirements(requirementsData)
    } catch (error) {
      console.error('Error loading data:', error)
    } finally {
      setIsLoading(false)
    }
  }

  const handleSaveRequirement = async (requirement: VisaRequirement) => {
    try {
      const { error } = await supabase
        .from('visa_requirements')
        .update({
          status: requirement.status,
          allowed_stay_days: requirement.allowed_stay_days,
          visa_fee_amount: requirement.visa_fee_amount,
          visa_fee_currency: requirement.visa_fee_currency,
          processing_time_days: requirement.processing_time_days,
          notes: requirement.notes,
          last_updated: new Date().toISOString()
        })
        .eq('id', requirement.id)

      if (error) throw error
      
      setEditingRequirement(null)
      loadData()
    } catch (error) {
      console.error('Error saving requirement:', error)
    }
  }

  const handleAddRequirement = async () => {
    try {
      const { error } = await supabase
        .from('visa_requirements')
        .insert({
          passport_country: selectedPassportCountry,
          destination_country: newRequirement.destination_country,
          status: newRequirement.status,
          allowed_stay_days: newRequirement.allowed_stay_days,
          visa_fee_amount: newRequirement.visa_fee_amount,
          visa_fee_currency: newRequirement.visa_fee_currency,
          processing_time_days: newRequirement.processing_time_days,
          notes: newRequirement.notes
        })

      if (error) throw error
      
      setNewRequirement({
        destination_country: '',
        status: 'visa_free',
        allowed_stay_days: 90,
        visa_fee_amount: 0,
        visa_fee_currency: 'USD',
        processing_time_days: 0,
        notes: ''
      })
      loadData()
    } catch (error) {
      console.error('Error adding requirement:', error)
    }
  }

  const getStatusColor = (status: TravelStatus) => {
    switch (status) {
      case 'visa_free': return 'bg-green-100 text-green-800'
      case 'eta_required': return 'bg-blue-100 text-blue-800'
      case 'visa_on_arrival': return 'bg-yellow-100 text-yellow-800'
      case 'evisa': return 'bg-yellow-100 text-yellow-800'
      case 'reciprocity_fee': return 'bg-purple-100 text-purple-800'
      case 'consulate_visa': return 'bg-red-100 text-red-800'
      default: return 'bg-gray-100 text-gray-800'
    }
  }

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Loading admin panel...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Visa Requirements Admin</h1>
          <p className="mt-2 text-gray-600">Manage visa requirements for different passport holders</p>
        </div>

        {/* Passport Country Selector */}
        <div className="mb-6">
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Passport Country
          </label>
          <select
            value={selectedPassportCountry}
            onChange={(e) => setSelectedPassportCountry(e.target.value)}
            className="block w-full max-w-xs px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
          >
            {countries.map(country => (
              <option key={country.code} value={country.code}>
                {country.flag} {country.name}
              </option>
            ))}
          </select>
        </div>

        {/* Add New Requirement */}
        <div className="bg-white rounded-lg shadow-sm border p-6 mb-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Add New Requirement</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Destination</label>
              <select
                value={newRequirement.destination_country}
                onChange={(e) => setNewRequirement({...newRequirement, destination_country: e.target.value})}
                className="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
              >
                <option value="">Select country</option>
                {countries.map(country => (
                  <option key={country.code} value={country.code}>
                    {country.flag} {country.name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Status</label>
              <select
                value={newRequirement.status}
                onChange={(e) => setNewRequirement({...newRequirement, status: e.target.value as TravelStatus})}
                className="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
              >
                <option value="visa_free">Visa Free</option>
                <option value="eta_required">eTA Required</option>
                <option value="visa_on_arrival">Visa on Arrival</option>
                <option value="evisa">eVisa Required</option>
                <option value="reciprocity_fee">Reciprocity Fee</option>
                <option value="consulate_visa">Consulate Visa Required</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Allowed Stay (days)</label>
              <input
                type="number"
                value={newRequirement.allowed_stay_days}
                onChange={(e) => setNewRequirement({...newRequirement, allowed_stay_days: parseInt(e.target.value)})}
                className="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Visa Fee</label>
              <div className="flex">
                <input
                  type="number"
                  step="0.01"
                  value={newRequirement.visa_fee_amount}
                  onChange={(e) => setNewRequirement({...newRequirement, visa_fee_amount: parseFloat(e.target.value)})}
                  className="block w-full px-3 py-2 border border-gray-300 rounded-l-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                />
                <select
                  value={newRequirement.visa_fee_currency}
                  onChange={(e) => setNewRequirement({...newRequirement, visa_fee_currency: e.target.value})}
                  className="px-3 py-2 border border-l-0 border-gray-300 rounded-r-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                >
                  <option value="USD">USD</option>
                  <option value="CAD">CAD</option>
                  <option value="AUD">AUD</option>
                  <option value="NZD">NZD</option>
                  <option value="EUR">EUR</option>
                  <option value="GBP">GBP</option>
                </select>
              </div>
            </div>
          </div>
          <div className="mt-4">
            <label className="block text-sm font-medium text-gray-700 mb-1">Notes</label>
            <textarea
              value={newRequirement.notes}
              onChange={(e) => setNewRequirement({...newRequirement, notes: e.target.value})}
              rows={2}
              className="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
              placeholder="Additional notes about the requirement..."
            />
          </div>
          <button
            onClick={handleAddRequirement}
            disabled={!newRequirement.destination_country}
            className="mt-4 flex items-center px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <Plus className="h-4 w-4 mr-2" />
            Add Requirement
          </button>
        </div>

        {/* Requirements List */}
        <div className="bg-white rounded-lg shadow-sm border">
          <div className="px-6 py-4 border-b">
            <h2 className="text-lg font-semibold text-gray-900">
              Requirements for {countries.find(c => c.code === selectedPassportCountry)?.flag} {countries.find(c => c.code === selectedPassportCountry)?.name} Passport Holders
            </h2>
          </div>
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Destination</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Stay</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fee</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Notes</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {requirements.map((requirement) => (
                  <tr key={requirement.id}>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center">
                        <span className="text-lg mr-2">{requirement.destination_country_info?.flag}</span>
                        <span className="text-sm font-medium text-gray-900">{requirement.destination_country_info?.name}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`inline-flex px-2 py-1 text-xs font-semibold rounded-full ${getStatusColor(requirement.status)}`}>
                        {requirement.status.replace('_', ' ')}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {requirement.allowed_stay_days} days
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {requirement.visa_fee_amount > 0 ? `${requirement.visa_fee_currency} ${requirement.visa_fee_amount}` : 'Free'}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-900 max-w-xs truncate">
                      {requirement.notes}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                      <button
                        onClick={() => setEditingRequirement(requirement)}
                        className="text-blue-600 hover:text-blue-900 mr-3"
                      >
                        <Edit className="h-4 w-4" />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  )
} 