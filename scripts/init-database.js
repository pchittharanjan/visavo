const { createClient } = require('@supabase/supabase-js')

// Initialize Supabase client
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing Supabase environment variables')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseKey)

// US Passport visa requirements data
const usPassportData = [
  // Visa Free Countries
  { passport_country: 'US', destination_country: 'CA', status: 'visa_free', allowed_stay_days: 180, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'MX', status: 'visa_free', allowed_stay_days: 180, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'GB', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'FR', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'DE', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'IT', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'ES', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'JP', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'KR', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'NL', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'BE', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'CH', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'AT', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'SE', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'NO', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'DK', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'FI', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'IE', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'PT', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  { passport_country: 'US', destination_country: 'GR', status: 'visa_free', allowed_stay_days: 90, notes: 'No visa required for tourism' },
  
  // eTA Required
  { passport_country: 'US', destination_country: 'AU', status: 'eta_required', allowed_stay_days: 90, visa_fee_amount: 20, visa_fee_currency: 'AUD', processing_time_days: 1, notes: 'Electronic Travel Authorization required' },
  { passport_country: 'US', destination_country: 'NZ', status: 'eta_required', allowed_stay_days: 90, visa_fee_amount: 17, visa_fee_currency: 'NZD', processing_time_days: 1, notes: 'Electronic Travel Authorization required' },
  
  // eVisa Countries
  { passport_country: 'US', destination_country: 'IN', status: 'evisa', allowed_stay_days: 60, visa_fee_amount: 25, visa_fee_currency: 'USD', processing_time_days: 3, notes: 'Electronic visa required' },
  { passport_country: 'US', destination_country: 'BR', status: 'evisa', allowed_stay_days: 90, visa_fee_amount: 40, visa_fee_currency: 'USD', processing_time_days: 5, notes: 'Electronic visa required' },
  { passport_country: 'US', destination_country: 'TR', status: 'evisa', allowed_stay_days: 90, visa_fee_amount: 50, visa_fee_currency: 'USD', processing_time_days: 3, notes: 'Electronic visa required' },
  { passport_country: 'US', destination_country: 'EG', status: 'evisa', allowed_stay_days: 30, visa_fee_amount: 25, visa_fee_currency: 'USD', processing_time_days: 7, notes: 'Electronic visa required' },
  { passport_country: 'US', destination_country: 'KE', status: 'evisa', allowed_stay_days: 90, visa_fee_amount: 51, visa_fee_currency: 'USD', processing_time_days: 2, notes: 'Electronic visa required' },
  
  // Visa on Arrival
  { passport_country: 'US', destination_country: 'TH', status: 'visa_on_arrival', allowed_stay_days: 30, visa_fee_amount: 2000, visa_fee_currency: 'THB', processing_time_days: 0, notes: 'Visa on arrival available' },
  { passport_country: 'US', destination_country: 'ID', status: 'visa_on_arrival', allowed_stay_days: 30, visa_fee_amount: 35, visa_fee_currency: 'USD', processing_time_days: 0, notes: 'Visa on arrival available' },
  { passport_country: 'US', destination_country: 'MY', status: 'visa_on_arrival', allowed_stay_days: 90, visa_fee_amount: 0, visa_fee_currency: 'USD', processing_time_days: 0, notes: 'Visa on arrival available' },
  { passport_country: 'US', destination_country: 'PH', status: 'visa_on_arrival', allowed_stay_days: 30, visa_fee_amount: 0, visa_fee_currency: 'USD', processing_time_days: 0, notes: 'Visa on arrival available' },
  
  // Consulate Visa Required
  { passport_country: 'US', destination_country: 'CN', status: 'consulate_visa', allowed_stay_days: 30, visa_fee_amount: 140, visa_fee_currency: 'USD', processing_time_days: 14, notes: 'Visa must be obtained at consulate' },
  { passport_country: 'US', destination_country: 'RU', status: 'consulate_visa', allowed_stay_days: 30, visa_fee_amount: 160, visa_fee_currency: 'USD', processing_time_days: 21, notes: 'Visa must be obtained at consulate' },
  { passport_country: 'US', destination_country: 'SA', status: 'consulate_visa', allowed_stay_days: 90, visa_fee_amount: 160, visa_fee_currency: 'USD', processing_time_days: 14, notes: 'Visa must be obtained at consulate' },
  { passport_country: 'US', destination_country: 'IR', status: 'consulate_visa', allowed_stay_days: 30, visa_fee_amount: 80, visa_fee_currency: 'USD', processing_time_days: 30, notes: 'Visa must be obtained at consulate' },
  { passport_country: 'US', destination_country: 'PK', status: 'consulate_visa', allowed_stay_days: 30, visa_fee_amount: 60, visa_fee_currency: 'USD', processing_time_days: 14, notes: 'Visa must be obtained at consulate' },
  
  // Consulate Visa Required (formerly Reciprocity Fee)
  { passport_country: 'US', destination_country: 'AR', status: 'consulate_visa', allowed_stay_days: 90, visa_fee_amount: 160, visa_fee_currency: 'USD', processing_time_days: 0, notes: 'Visa must be obtained at consulate' },
  { passport_country: 'US', destination_country: 'CL', status: 'consulate_visa', allowed_stay_days: 90, visa_fee_amount: 160, visa_fee_currency: 'USD', processing_time_days: 0, notes: 'Visa must be obtained at consulate' },
]

async function initializeDatabase() {
  console.log('🚀 Initializing visa requirements database...')
  
  try {
    // Clear existing data for US passport
    const { error: deleteError } = await supabase
      .from('visa_requirements')
      .delete()
      .eq('passport_country', 'US')
    
    if (deleteError) {
      console.error('Error clearing existing data:', deleteError)
      return
    }
    
    console.log('✅ Cleared existing US passport data')
    
    // Insert new data
    const { data, error } = await supabase
      .from('visa_requirements')
      .insert(usPassportData.map(item => ({
        ...item,
        is_active: true,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })))
    
    if (error) {
      console.error('Error inserting data:', error)
      return
    }
    
    console.log(`✅ Successfully inserted ${data?.length || 0} visa requirements`)
    console.log('🎉 Database initialization complete!')
    
  } catch (error) {
    console.error('Error initializing database:', error)
  }
}

// Run the initialization
initializeDatabase() 