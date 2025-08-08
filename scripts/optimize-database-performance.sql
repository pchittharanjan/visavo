-- Database Performance Optimization Script
-- This script adds indexes and optimizations for better dual citizenship performance

-- 1. Add composite index for passport_country + destination_country (most common query)
CREATE INDEX IF NOT EXISTS idx_visa_requirements_passport_destination 
ON visa_requirements (passport_country, destination_country, is_active);

-- 2. Add index for destination_country (for reverse lookups)
CREATE INDEX IF NOT EXISTS idx_visa_requirements_destination 
ON visa_requirements (destination_country, is_active);

-- 3. Add index for passport_country (for single passport queries)
CREATE INDEX IF NOT EXISTS idx_visa_requirements_passport 
ON visa_requirements (passport_country, is_active);

-- 4. Add index for status (for filtering by visa status)
CREATE INDEX IF NOT EXISTS idx_visa_requirements_status 
ON visa_requirements (status, is_active);

-- 5. Add composite index for batch queries (passport_country IN + destination_country IN)
CREATE INDEX IF NOT EXISTS idx_visa_requirements_batch 
ON visa_requirements (passport_country, destination_country, status, is_active);

-- 6. Add index for documents table (user_id + document_type)
CREATE INDEX IF NOT EXISTS idx_documents_user_type 
ON documents (user_id, document_type);

-- 7. Add index for countries table (code)
CREATE INDEX IF NOT EXISTS idx_countries_code 
ON countries (code);

-- 8. Add index for visa_status_types table (code)
CREATE INDEX IF NOT EXISTS idx_visa_status_types_code 
ON visa_status_types (code);

-- 9. Analyze tables to update statistics
ANALYZE visa_requirements;
ANALYZE documents;
ANALYZE countries;
ANALYZE visa_status_types;

-- 10. Create a materialized view for common passport combinations (optional)
-- This can be refreshed periodically for very frequent queries
CREATE MATERIALIZED VIEW IF NOT EXISTS common_passport_combinations AS
SELECT 
  passport_country,
  destination_country,
  status,
  allowed_stay_days,
  visa_fee,
  visa_fee_currency,
  processing_time,
  notes
FROM visa_requirements 
WHERE is_active = true
  AND status IN ('visa_free', 'eta_required', 'evisa', 'visa_on_arrival')
  AND passport_country IN ('US', 'CA', 'GB', 'AU', 'DE', 'FR', 'JP', 'SG', 'NZ', 'CH')
  AND destination_country IN ('US', 'CA', 'GB', 'AU', 'DE', 'FR', 'JP', 'SG', 'NZ', 'CH', 'MX', 'BR', 'IN', 'CN', 'RU');

-- 11. Create index on the materialized view
CREATE INDEX IF NOT EXISTS idx_common_combinations_lookup 
ON common_passport_combinations (passport_country, destination_country);

-- 12. Add comments for documentation
COMMENT ON INDEX idx_visa_requirements_passport_destination IS 'Primary index for passport-destination lookups';
COMMENT ON INDEX idx_visa_requirements_batch IS 'Optimized index for batch queries with multiple passports';
COMMENT ON MATERIALIZED VIEW common_passport_combinations IS 'Cached view for common passport combinations';

-- 13. Show index usage statistics (for monitoring)
SELECT 
  schemaname,
  tablename,
  indexname,
  idx_scan as index_scans,
  idx_tup_read as tuples_read,
  idx_tup_fetch as tuples_fetched
FROM pg_stat_user_indexes 
WHERE tablename = 'visa_requirements'
ORDER BY idx_scan DESC;

-- 14. Show table statistics
SELECT 
  schemaname,
  tablename,
  n_tup_ins as inserts,
  n_tup_upd as updates,
  n_tup_del as deletes,
  n_live_tup as live_tuples,
  n_dead_tup as dead_tuples
FROM pg_stat_user_tables 
WHERE tablename IN ('visa_requirements', 'documents', 'countries', 'visa_status_types')
ORDER BY n_live_tup DESC;
