-- Check visa_requirements table structure and constraints
-- Run this in Supabase SQL Editor

-- 1. Check table structure
SELECT 
  column_name,
  data_type,
  is_nullable,
  column_default,
  character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'visa_requirements' 
ORDER BY ordinal_position;

-- 2. Check primary key and unique constraints
SELECT 
  tc.constraint_name,
  tc.constraint_type,
  kcu.column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu 
  ON tc.constraint_name = kcu.constraint_name
WHERE tc.table_name = 'visa_requirements';

-- 3. Check foreign key constraints
SELECT 
  tc.constraint_name,
  kcu.column_name,
  ccu.table_name AS foreign_table_name,
  ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu 
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu 
  ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY' 
  AND tc.table_name = 'visa_requirements';

-- 4. Test a simple insert to see what happens
INSERT INTO visa_requirements (
  passport_country, 
  destination_country, 
  status, 
  allowed_stay_days, 
  visa_fee_amount, 
  visa_fee_currency, 
  notes, 
  is_active
) VALUES (
  'US', 
  'TEST', 
  'visa_free', 
  90, 
  0, 
  'USD', 
  'Test insert', 
  true
) ON CONFLICT (passport_country, destination_country) DO UPDATE SET
  status = EXCLUDED.status,
  allowed_stay_days = EXCLUDED.allowed_stay_days,
  visa_fee_amount = EXCLUDED.visa_fee_amount,
  visa_fee_currency = EXCLUDED.visa_fee_currency,
  notes = EXCLUDED.notes,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- 5. Clean up test data
DELETE FROM visa_requirements WHERE destination_country = 'TEST'; 