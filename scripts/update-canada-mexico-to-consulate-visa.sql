-- Update all Canadian passport travel to other countries as consulate visa
-- But keep Canada -> Canada as citizen
UPDATE visa_requirements 
SET 
  status = 'consulate_visa',
  allowed_stay_days = 'Varies by visa type',
  visa_fee_amount = 100.00,
  visa_fee_currency = 'USD',
  processing_time_days = 15,
  notes = 'Consulate visa required. Apply at nearest consulate or embassy.',
  last_updated = NOW()
WHERE passport_country = 'CA' 
  AND destination_country != 'CA'  -- Keep Canada -> Canada as citizen
  AND is_active = true;

-- Update all Mexican passport travel to other countries as consulate visa  
-- But keep Mexico -> Mexico as citizen
UPDATE visa_requirements 
SET 
  status = 'consulate_visa',
  allowed_stay_days = 'Varies by visa type',
  visa_fee_amount = 100.00,
  visa_fee_currency = 'USD',
  processing_time_days = 15,
  notes = 'Consulate visa required. Apply at nearest consulate or embassy.',
  last_updated = NOW()
WHERE passport_country = 'MX' 
  AND destination_country != 'MX'  -- Keep Mexico -> Mexico as citizen
  AND is_active = true;

-- Verify the changes
SELECT 
  passport_country,
  destination_country,
  status,
  allowed_stay_days,
  notes
FROM visa_requirements 
WHERE passport_country IN ('CA', 'MX')
ORDER BY passport_country, destination_country;
