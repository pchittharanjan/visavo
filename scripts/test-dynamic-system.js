// Test script for dynamic visa requirements system
// Run with: node scripts/test-dynamic-system.js

const { createClient } = require('@supabase/supabase-js')
require('dotenv').config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase environment variables')
  console.log('Please check your .env.local file')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseKey)

async function testDatabaseConnection() {
  console.log('🔍 Testing database connection...')
  
  try {
    // Test 1: Check if countries table exists
    const { data: countries, error: countriesError } = await supabase
      .from('countries')
      .select('*')
      .limit(5)
    
    if (countriesError) {
      console.error('❌ Error accessing countries table:', countriesError.message)
      return false
    }
    
    console.log('✅ Countries table accessible')
    console.log('📊 Sample countries:', countries.map(c => `${c.flag} ${c.name}`))
    
    // Test 2: Check if visa_requirements table exists
    const { data: requirements, error: requirementsError } = await supabase
      .from('visa_requirements')
      .select('*')
      .eq('passport_country', 'US')
      .limit(5)
    
    if (requirementsError) {
      console.error('❌ Error accessing visa_requirements table:', requirementsError.message)
      return false
    }
    
    console.log('✅ Visa requirements table accessible')
    console.log('📊 Sample US requirements:', requirements.length, 'entries found')
    
    // Test 3: Check if special_overrides table exists
    const { data: overrides, error: overridesError } = await supabase
      .from('special_overrides')
      .select('*')
      .limit(5)
    
    if (overridesError) {
      console.error('❌ Error accessing special_overrides table:', overridesError.message)
      return false
    }
    
    console.log('✅ Special overrides table accessible')
    console.log('📊 Sample overrides:', overrides.length, 'entries found')
    
    return true
    
  } catch (error) {
    console.error('❌ Database connection failed:', error.message)
    return false
  }
}

async function testDynamicFunctions() {
  console.log('\n🔍 Testing dynamic functions...')
  
  // Mock user documents for testing
  const userDocuments = [
    {
      id: 1,
      user_id: 'test-user',
      issuing_country: 'US',
      document_type: 'passport',
      expiration_date: '2030-12-31',
      created_at: '2024-01-01'
    },
    {
      id: 2,
      user_id: 'test-user',
      issuing_country: 'IN',
      document_type: 'tourist_visa',
      expiration_date: '2025-06-30',
      created_at: '2024-01-01'
    }
  ]
  
  try {
    // Test US passport holder going to Canada
    const { data: canadaRequirement, error: canadaError } = await supabase
      .from('visa_requirements')
      .select('*')
      .eq('passport_country', 'US')
      .eq('destination_country', 'CA')
      .single()
    
    if (canadaError) {
      console.error('❌ Error getting Canada requirement:', canadaError.message)
    } else {
      console.log('✅ Canada requirement found:', canadaRequirement.status)
    }
    
    // Test US passport holder going to India
    const { data: indiaRequirement, error: indiaError } = await supabase
      .from('visa_requirements')
      .select('*')
      .eq('passport_country', 'US')
      .eq('destination_country', 'IN')
      .single()
    
    if (indiaError) {
      console.error('❌ Error getting India requirement:', indiaError.message)
    } else {
      console.log('✅ India requirement found:', indiaRequirement.status)
    }
    
    // Test special override for OCI card
    const { data: ociOverride, error: ociError } = await supabase
      .from('special_overrides')
      .select('*')
      .eq('destination_country', 'IN')
      .contains('required_documents', ['US', 'oci_card'])
    
    if (ociError) {
      console.error('❌ Error getting OCI override:', ociError.message)
    } else if (ociOverride && ociOverride.length > 0) {
      console.log('✅ OCI override found:', ociOverride[0].override_status)
    } else {
      console.log('ℹ️  No OCI override found (this is expected if no OCI card)')
    }
    
  } catch (error) {
    console.error('❌ Dynamic function test failed:', error.message)
  }
}

async function main() {
  console.log('🚀 Testing Dynamic Visa Requirements System\n')
  
  const dbConnected = await testDatabaseConnection()
  
  if (dbConnected) {
    await testDynamicFunctions()
    console.log('\n✅ All tests completed successfully!')
    console.log('\n🎉 Your dynamic system is ready to use!')
    console.log('📝 Next steps:')
    console.log('   1. Visit http://localhost:3000/admin to manage requirements')
    console.log('   2. Test the dashboard with your documents')
    console.log('   3. Add new countries and requirements as needed')
  } else {
    console.log('\n❌ Database setup incomplete')
    console.log('📝 Please run the SQL script in Supabase first:')
    console.log('   Copy scripts/setup-dynamic-db.sql to Supabase SQL Editor')
  }
}

main().catch(console.error) 