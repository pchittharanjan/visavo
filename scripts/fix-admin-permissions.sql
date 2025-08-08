-- Fix Admin Console Permissions
-- Run this in Supabase SQL Editor to grant anon key permissions

-- Grant all permissions to anon key for visa_requirements table
GRANT ALL PRIVILEGES ON TABLE visa_requirements TO anon;

-- Grant usage on the sequence (if using auto-incrementing IDs)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO anon;

-- Verify the grants
SELECT grantee, privilege_type 
FROM information_schema.role_table_grants 
WHERE table_name = 'visa_requirements' 
AND grantee = 'anon'
ORDER BY privilege_type; 