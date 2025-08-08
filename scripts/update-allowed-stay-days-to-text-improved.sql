-- Update allowed_stay_days column from integer to text
ALTER TABLE visa_requirements 
ALTER COLUMN allowed_stay_days TYPE TEXT;

-- Update existing numeric values to text format
UPDATE visa_requirements 
SET allowed_stay_days = allowed_stay_days || ' days' 
WHERE allowed_stay_days IS NOT NULL AND allowed_stay_days ~ '^[0-9]+$';

-- Handle citizen status more intelligently
-- Only set to "Unlimited" for same-country citizens (like US citizen in US)
UPDATE visa_requirements 
SET allowed_stay_days = 'Unlimited' 
WHERE status = 'citizen' 
  AND passport_country = destination_country;

-- For citizen status where passport_country != destination_country, 
-- keep the original value or set to a more appropriate text
UPDATE visa_requirements 
SET allowed_stay_days = 'Varies by citizenship type' 
WHERE status = 'citizen' 
  AND passport_country != destination_country;

-- Update zero values to more descriptive text
UPDATE visa_requirements 
SET allowed_stay_days = 'Not applicable' 
WHERE allowed_stay_days = '0 days' OR allowed_stay_days = '0';
