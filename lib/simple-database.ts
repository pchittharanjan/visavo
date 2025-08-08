import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
const supabase = createClient(supabaseUrl, supabaseKey)

export interface VisaRequirement {
  id?: number
  passport_country: string
  destination_country: string
  status: string
  allowed_stay_days?: string
  visa_fee_amount?: number
  visa_fee_currency?: string
  notes?: string
  is_active?: boolean
  created_at?: string
}

// Get all visa requirements for a passport country
export async function getAllRequirements(passportCountry: string = 'US'): Promise<VisaRequirement[]> {
  try {
    const { data, error } = await supabase
      .from('visa_requirements')
      .select('*')
      .eq('passport_country', passportCountry)
      .eq('is_active', true)
      .order('destination_country')

    if (error) {
      console.error('Error fetching requirements:', error)
      return []
    }

    return data || []
  } catch (error) {
    console.error('Error in getAllRequirements:', error)
    return []
  }
}

// Add or update a visa requirement
export async function upsertRequirement(requirement: VisaRequirement): Promise<boolean> {
  try {
    console.log('Attempting to upsert requirement:', JSON.stringify(requirement, null, 2))
    
    const { data, error } = await supabase
      .from('visa_requirements')
      .upsert(requirement)

    if (error) {
      console.error('Error upserting requirement:', error)
      console.error('Error message:', error.message)
      console.error('Error details:', error.details)
      console.error('Error hint:', error.hint)
      console.error('Error code:', error.code)
      return false
    }

    console.log('Successfully upserted requirement:', data)
    return true
  } catch (error) {
    console.error('Exception in upsertRequirement:', error)
    console.error('Error type:', typeof error)
    console.error('Error stringified:', JSON.stringify(error, null, 2))
    return false
  }
}

// Delete a visa requirement
export async function deleteRequirement(id: number): Promise<boolean> {
  try {
    const { error } = await supabase
      .from('visa_requirements')
      .delete()
      .eq('id', id)

    if (error) {
      console.error('Error deleting requirement:', error)
      return false
    }

    return true
  } catch (error) {
    console.error('Error in deleteRequirement:', error)
    return false
  }
} 