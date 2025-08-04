-- Fix Supabase access issues by disabling RLS on PR tables
-- This will allow the app to read the PR data

-- Disable RLS on bilateral_pr_relationships table
ALTER TABLE bilateral_pr_relationships DISABLE ROW LEVEL SECURITY;

-- Disable RLS on regional_bloc_members table  
ALTER TABLE regional_bloc_members DISABLE ROW LEVEL SECURITY;

-- Disable RLS on regional_bloc_privileges table
ALTER TABLE regional_bloc_privileges DISABLE ROW LEVEL SECURITY;

-- Disable RLS on regional_blocs table
ALTER TABLE regional_blocs DISABLE ROW LEVEL SECURITY;

-- Verify the tables are accessible
SELECT 'bilateral_pr_relationships' as table_name, COUNT(*) as count FROM bilateral_pr_relationships
UNION ALL
SELECT 'regional_bloc_members', COUNT(*) FROM regional_bloc_members
UNION ALL  
SELECT 'regional_bloc_privileges', COUNT(*) FROM regional_bloc_privileges
UNION ALL
SELECT 'regional_blocs', COUNT(*) FROM regional_blocs; 