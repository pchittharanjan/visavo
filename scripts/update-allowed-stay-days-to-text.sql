-- Update allowed_stay_days column from integer to text
ALTER TABLE visa_requirements 
ALTER COLUMN allowed_stay_days TYPE TEXT;

-- Update existing numeric values to text format
UPDATE visa_requirements 
SET allowed_stay_days = allowed_stay_days || ' days' 
WHERE allowed_stay_days IS NOT NULL AND allowed_stay_days ~ '^[0-9]+$';

-- Update specific values to be more descriptive
UPDATE visa_requirements 
SET allowed_stay_days = 'Unlimited' 
WHERE allowed_stay_days = '0 days' OR allowed_stay_days = '0';

-- Update citizen status to have appropriate text
UPDATE visa_requirements 
SET allowed_stay_days = 'Unlimited' 
WHERE status = 'citizen';
