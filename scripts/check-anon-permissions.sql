-- Check Anon Key Permissions
-- Run this in Supabase SQL Editor to see what the anon key can do

-- 1. Check current user and role
SELECT current_user, current_setting('role');

-- 2. Check if anon key can SELECT from visa_requirements
SELECT COUNT(*) as can_select FROM visa_requirements LIMIT 1;

-- 3. Check if anon key can INSERT into visa_requirements
-- (This will fail if no permissions, but that's expected)
DO $$
BEGIN
  INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, notes) 
  VALUES ('TEST', 'TEST', 'visa_free', 90, 0, 'USD', 'Test insert')
  ON CONFLICT (passport_country, destination_country) DO NOTHING;
  
  -- If we get here, INSERT works
  RAISE NOTICE 'INSERT permission: OK';
  
  -- Clean up test data
  DELETE FROM visa_requirements WHERE passport_country = 'TEST';
  
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'INSERT permission: FAILED - %', SQLERRM;
END $$;

-- 4. Check if anon key can UPDATE visa_requirements
DO $$
BEGIN
  UPDATE visa_requirements 
  SET notes = 'Test update'
  WHERE passport_country = 'US' AND destination_country = 'CA'
  LIMIT 1;
  
  RAISE NOTICE 'UPDATE permission: OK';
  
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'UPDATE permission: FAILED - %', SQLERRM;
END $$;

-- 5. Check table grants
SELECT grantee, privilege_type 
FROM information_schema.role_table_grants 
WHERE table_name = 'visa_requirements' 
AND grantee = 'anon'; 