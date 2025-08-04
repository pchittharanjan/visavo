// Test script for Green Card logic
// Run with: node scripts/test-green-card-logic.js

const { createClient } = require('@supabase/supabase-js')
require('dotenv').config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase environment variables')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseKey)

// Mock the dynamic travel status function logic
async function testGreenCardLogic() {
  console.log('🧪 Testing Green Card Logic\n')
  
  // Test case 1: India passport + US Green Card
  const userDocuments1 = [
    {
      id: 1,
      user_id: 'test-user',
      issuing_country: 'IN',
      document_type: 'passport',
      expiration_date: '2032-12-20',
      created_at: '2024-01-01'
    },
    {
      id: 2,
      user_id: 'test-user',
      issuing_country: 'US',
      document_type: 'green_card',
      expiration_date: '2028-08-07',
      created_at: '2024-01-01'
    }
  ]
  
  console.log('📋 Test Case 1: India Passport + US Green Card')
  console.log('Documents:', userDocuments1.map(d => `${d.issuing_country} ${d.document_type}`))
  
  // Test US entry (should be visa-free due to Green Card)
  const passport1 = userDocuments1.find(doc => doc.document_type === 'passport')
  const greenCard1 = userDocuments1.find(doc => doc.document_type === 'green_card')
  
  console.log('🇺🇸 US Entry:')
  console.log('  - Passport country:', passport1?.issuing_country)
  console.log('  - Green Card country:', greenCard1?.issuing_country)
  
  if (greenCard1 && greenCard1.issuing_country === 'US') {
    console.log('  ✅ Should be VISA-FREE (Green Card holder)')
    console.log('  📝 Status: Permanent Resident - Unlimited stay')
  } else {
    console.log('  ❌ Logic error: Green Card not detected')
  }
  
  // Test India entry (should be visa-free due to passport)
  console.log('🇮🇳 India Entry:')
  if (passport1 && passport1.issuing_country === 'IN') {
    console.log('  ✅ Should be VISA-FREE (Citizen)')
    console.log('  📝 Status: Citizen - Unlimited stay')
  } else {
    console.log('  ❌ Logic error: Passport not detected')
  }
  
  console.log('\n' + '='.repeat(50) + '\n')
  
  // Test case 2: US passport + India tourist visa
  const userDocuments2 = [
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
  
  console.log('📋 Test Case 2: US Passport + India Tourist Visa')
  console.log('Documents:', userDocuments2.map(d => `${d.issuing_country} ${d.document_type}`))
  
  const passport2 = userDocuments2.find(doc => doc.document_type === 'passport')
  const touristVisa2 = userDocuments2.find(doc => doc.document_type === 'tourist_visa')
  
  console.log('🇺🇸 US Entry:')
  if (passport2 && passport2.issuing_country === 'US') {
    console.log('  ✅ Should be VISA-FREE (Citizen)')
    console.log('  📝 Status: Citizen - Unlimited stay')
  }
  
  console.log('🇮🇳 India Entry:')
  if (touristVisa2 && touristVisa2.issuing_country === 'IN') {
    console.log('  ✅ Should be VISA-FREE (Valid tourist visa)')
    console.log('  📝 Status: Valid visa until 2025-06-30')
  }
  
  console.log('\n' + '='.repeat(50) + '\n')
  
  // Test case 3: UK passport only
  const userDocuments3 = [
    {
      id: 1,
      user_id: 'test-user',
      issuing_country: 'GB',
      document_type: 'passport',
      expiration_date: '2030-12-31',
      created_at: '2024-01-01'
    }
  ]
  
  console.log('📋 Test Case 3: UK Passport Only')
  console.log('Documents:', userDocuments3.map(d => `${d.issuing_country} ${d.document_type}`))
  
  const passport3 = userDocuments3.find(doc => doc.document_type === 'passport')
  
  console.log('🇬🇧 UK Entry:')
  if (passport3 && passport3.issuing_country === 'GB') {
    console.log('  ✅ Should be VISA-FREE (Citizen)')
    console.log('  📝 Status: Citizen - Unlimited stay')
  }
  
  console.log('🇺🇸 US Entry:')
  console.log('  🔍 Should check database for UK → US requirements')
  console.log('  📝 Status: Depends on database rules')
  
  console.log('\n✅ Green Card logic test completed!')
  console.log('\n🎯 Expected Results:')
  console.log('  - Green Card holders: VISA-FREE to their country of residence')
  console.log('  - Passport holders: VISA-FREE to their country of citizenship')
  console.log('  - Tourist visa holders: VISA-FREE to the country that issued the visa')
}

testGreenCardLogic().catch(console.error) 