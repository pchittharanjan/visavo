-- Update allowed_stay_days column from integer to text
ALTER TABLE visa_requirements 
ALTER COLUMN allowed_stay_days TYPE TEXT;

-- Update existing numeric values to text format
UPDATE visa_requirements 
SET allowed_stay_days = allowed_stay_days || ' days' 
WHERE allowed_stay_days IS NOT NULL AND allowed_stay_days ~ '^[0-9]+$';

-- Set "Unlimited" for same-country citizens (US citizen in US, Canada citizen in Canada, etc.)
UPDATE visa_requirements 
SET allowed_stay_days = 'Unlimited' 
WHERE status = 'citizen' 
  AND passport_country = destination_country;

-- Fix North Korea specifically
UPDATE visa_requirements 
SET allowed_stay_days = 'Travel restricted. Special permissions required.' 
WHERE destination_country = 'KP';

-- Update zero values to more descriptive text
UPDATE visa_requirements 
SET allowed_stay_days = 'Not applicable' 
WHERE allowed_stay_days = '0 days' OR allowed_stay_days = '0';
