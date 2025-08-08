'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@supabase/supabase-js'
import { getAllCountries } from '@/lib/countries'
import { Country } from '@/lib/types'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
)

interface VisaRequirement {
  id?: number
  passport_country: string
  destination_country: string
  status: string
  allowed_stay_days: string
  visa_fee_amount: number
  visa_fee_currency: string
  notes: string
  is_active: boolean
}

interface VisaStatusType {
  id: number
  code: string
  name: string
  description: string
  color: string
  is_active: boolean
}

export default function AdminPage() {
  const [requirements, setRequirements] = useState<VisaRequirement[]>([])
  const [statusTypes, setStatusTypes] = useState<VisaStatusType[]>([])
  const [allCountries, setAllCountries] = useState<Country[]>([])
  const [editingRequirement, setEditingRequirement] = useState<VisaRequirement | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  const loadData = async () => {
    setIsLoading(true)
    try {
      // Load visa requirements
      const { data: requirementsData, error: requirementsError } = await supabase
        .from('visa_requirements')
        .select('*')
        .eq('passport_country', 'US')

      if (requirementsError) throw requirementsError

      // Load visa status types
      const { data: statusTypesData, error: statusTypesError } = await supabase
        .from('visa_status_types')
        .select('*')
        .eq('is_active', true)
        .order('id')

      if (statusTypesError) throw statusTypesError

      // Load countries
      const countriesData = await getAllCountries()

      setRequirements(requirementsData || [])
      setStatusTypes(statusTypesData || [])
      setAllCountries(countriesData)
    } catch (error) {
      console.error('Error loading data:', error)
    } finally {
      setIsLoading(false)
    }
  }

  useEffect(() => {
    loadData()
  }, [])

  const handleSaveRequirement = async (requirement: VisaRequirement) => {
    try {
      const { data, error } = await supabase
        .from('visa_requirements')
        .upsert(requirement)
        .select()

      if (error) throw error

      await loadData()
      setEditingRequirement(null)
    } catch (error) {
      console.error('Error saving requirement:', error)
      alert('Failed to save requirement')
    }
  }

  const handleDeleteRequirement = async (id: number) => {
    if (!confirm('Are you sure you want to delete this requirement?')) return

    try {
      const { error } = await supabase
        .from('visa_requirements')
        .delete()
        .eq('id', id)

      if (error) throw error

      await loadData()
    } catch (error) {
      console.error('Error deleting requirement:', error)
      alert('Failed to delete requirement')
    }
  }

  const handleEditClick = (country: any, requirement?: VisaRequirement) => {
    if (requirement) {
      setEditingRequirement(requirement)
    } else {
      setEditingRequirement({
        passport_country: 'US',
        destination_country: country.code,
        status: 'visa_free',
        allowed_stay_days: '90 days',
        visa_fee_amount: 0,
        visa_fee_currency: 'USD',
        notes: '',
        is_active: true
      })
    }
  }

  // Database-driven color mapping
  const getStatusColor = (status: string): string => {
    const statusType = statusTypes.find(st => st.code === status)
    return statusType?.color || '#6b7280' // Use database color or default gray
  }

  const getStatusLabel = (status: string): string => {
    const statusType = statusTypes.find(st => st.code === status)
    return statusType ? statusType.name : status
  }

  return (
    <div className="min-h-screen bg-gray-50 font-body">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900 font-display">Admin Console</h1>
          <p className="text-gray-600 mt-2">Manage visa requirements for US passport holders</p>
        </div>

        {/* Requirements Table */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-200">
          <div className="px-6 py-4 border-b border-gray-200">
            <h2 className="text-lg font-semibold text-gray-900">Visa Requirements</h2>
          </div>
          <div className="overflow-x-auto">
            {isLoading ? (
              <div className="text-center py-8">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
                <p className="text-sm text-gray-600 mt-2">Loading requirements...</p>
              </div>
            ) : (
              <div>
                <div className="text-sm text-gray-600 mb-4 px-6">
                  Showing {allCountries.length} countries ({requirements.length} have requirements)
                </div>
                <table className="w-full" style={{ minWidth: '1400px' }}>
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" style={{ width: '20%' }}>Country</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" style={{ width: '15%' }}>Visa Status</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" style={{ width: '12%' }}>Allowed Stay</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" style={{ width: '10%' }}>Visa Fee</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" style={{ width: '10%' }}>Currency</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" style={{ width: '20%' }}>Notes</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" style={{ width: '13%' }}>Actions</th>
                    </tr>
                  </thead>
                  <tbody className="bg-white divide-y divide-gray-200">
                    {allCountries.map((country) => {
                      const requirement = requirements.find(r => r.destination_country === country.code)
                      const isEditing = editingRequirement?.destination_country === country.code

                      return (
                        <tr key={country.code} className="hover:bg-gray-50">
                          <td className="px-6 py-4 whitespace-nowrap">
                            <div className="flex items-center">
                              <span className="text-lg mr-2">{country.flag}</span>
                              <span className="text-sm font-medium text-gray-900">{country.name}</span>
                            </div>
                          </td>
                          <td className="px-6 py-4 whitespace-nowrap">
                            {isEditing ? (
                              <select
                                value={editingRequirement?.status || 'visa_free'}
                                onChange={(e) => setEditingRequirement({...editingRequirement!, status: e.target.value})}
                                className="px-2 py-1 border border-gray-300 rounded text-sm w-full"
                                style={{ color: '#1f2937' }}
                              >
                                {statusTypes.map(statusType => (
                                  <option key={statusType.code} value={statusType.code}>
                                    {statusType.name}
                                  </option>
                                ))}
                              </select>
                            ) : (
                              <div className="flex items-center">
                                <div 
                                  className="w-3 h-3 rounded-full mr-2" 
                                  style={{ backgroundColor: requirement ? getStatusColor(requirement.status) : '#6b7280' }}
                                ></div>
                                <span className="text-sm text-gray-900">
                                  {requirement ? getStatusLabel(requirement.status) : 'Not Set'}
                                </span>
                              </div>
                            )}
                          </td>
                          <td className="px-6 py-4 whitespace-nowrap">
                            {isEditing ? (
                              <input
                                type="text"
                                value={editingRequirement?.allowed_stay_days || ''}
                                onChange={(e) => setEditingRequirement({...editingRequirement!, allowed_stay_days: e.target.value})}
                                className="px-2 py-1 border border-gray-300 rounded text-sm w-20"
                                style={{ color: '#1f2937' }}
                              />
                            ) : (
                              <span className="text-sm text-gray-900">
                                {requirement?.allowed_stay_days || '-'}
                              </span>
                            )}
                          </td>
                          <td className="px-6 py-4 whitespace-nowrap">
                            {isEditing ? (
                              <input
                                type="number"
                                value={editingRequirement?.visa_fee_amount || 0}
                                onChange={(e) => setEditingRequirement({...editingRequirement!, visa_fee_amount: parseFloat(e.target.value) || 0})}
                                className="px-2 py-1 border border-gray-300 rounded text-sm w-20"
                                style={{ color: '#1f2937' }}
                              />
                            ) : (
                              <span className="text-sm text-gray-900">
                                {requirement?.visa_fee_amount ? requirement.visa_fee_amount : '-'}
                              </span>
                            )}
                          </td>
                          <td className="px-6 py-4 whitespace-nowrap">
                            {isEditing ? (
                              <select
                                value={editingRequirement?.visa_fee_currency || 'USD'}
                                onChange={(e) => setEditingRequirement({...editingRequirement!, visa_fee_currency: e.target.value})}
                                className="px-2 py-1 border border-gray-300 rounded text-sm w-20"
                                style={{ color: '#1f2937' }}
                              >
                                <option value="USD">USD</option>
                                <option value="EUR">EUR</option>
                                <option value="GBP">GBP</option>
                                <option value="AUD">AUD</option>
                                <option value="CAD">CAD</option>
                                <option value="THB">THB</option>
                                <option value="NZD">NZD</option>
                              </select>
                            ) : (
                              <span className="text-sm text-gray-900">
                                {requirement?.visa_fee_currency || '-'}
                              </span>
                            )}
                          </td>
                          <td className="px-6 py-4 whitespace-nowrap">
                            {isEditing ? (
                              <input
                                type="text"
                                value={editingRequirement?.notes || ''}
                                onChange={(e) => setEditingRequirement({...editingRequirement!, notes: e.target.value})}
                                className="px-2 py-1 border border-gray-300 rounded text-sm w-32"
                                style={{ color: '#1f2937' }}
                              />
                            ) : (
                              <span className="text-sm text-gray-900">
                                {requirement?.notes || '-'}
                              </span>
                            )}
                          </td>
                          <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            {isEditing ? (
                              <div className="flex space-x-2">
                                <button
                                  onClick={() => handleSaveRequirement(editingRequirement!)}
                                  className="px-3 py-1 bg-green-500 text-white rounded hover:bg-green-600 text-xs font-medium"
                                >
                                  Save
                                </button>
                                <button
                                  onClick={() => setEditingRequirement(null)}
                                  className="px-3 py-1 bg-gray-500 text-white rounded hover:bg-gray-600 text-xs font-medium"
                                >
                                  Cancel
                                </button>
                              </div>
                            ) : (
                              <div className="flex space-x-2">
                                <button
                                  onClick={() => handleEditClick(country, requirement)}
                                  className="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 text-xs font-medium"
                                >
                                  {requirement ? 'Edit' : 'Add'}
                                </button>
                                {requirement && (
                                  <button
                                    onClick={() => handleDeleteRequirement(requirement.id!)}
                                    className="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600 text-xs font-medium"
                                  >
                                    Delete
                                  </button>
                                )}
                              </div>
                            )}
                          </td>
                        </tr>
                      )
                    })}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  )
} 