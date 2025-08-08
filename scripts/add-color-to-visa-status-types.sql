-- Add color field to visa_status_types table and populate with current colors
-- This will centralize color management in the database

-- 1. Add color column to visa_status_types table
ALTER TABLE visa_status_types 
ADD COLUMN IF NOT EXISTS color VARCHAR(7) DEFAULT '#6b7280';

-- 2. Update existing records with their colors
UPDATE visa_status_types 
SET color = '#10b981'  -- Green
WHERE code = 'visa_free';

UPDATE visa_status_types 
SET color = '#f59e0b'  -- Yellow
WHERE code = 'eta_required';

UPDATE visa_status_types 
SET color = '#3b82f6'  -- Blue
WHERE code = 'visa_on_arrival';

UPDATE visa_status_types 
SET color = '#f59e0b'  -- Yellow (same as eTA - both are electronic processes)
WHERE code = 'evisa';

UPDATE visa_status_types 
SET color = '#ef4444'  -- Red
WHERE code = 'consulate_visa';

-- 3. Verify the updates
SELECT code, name, color FROM visa_status_types ORDER BY id;

-- 4. Make color column NOT NULL after populating
ALTER TABLE visa_status_types 
ALTER COLUMN color SET NOT NULL; 