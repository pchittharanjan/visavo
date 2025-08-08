-- Update countries to Consulate Visa for US passport holders
-- Based on the list provided

-- Update the status to 'consulate_visa' for the specified countries
UPDATE visa_requirements 
SET status = 'consulate_visa'
WHERE passport_country = 'US' 
  AND destination_country IN (
    'AF',  -- Afghanistan
    'CF',  -- Central African Republic
    'CG',  -- Congo
    'CN',  -- China
    'DZ',  -- Algeria
    'ER',  -- Eritrea
    'GH',  -- Ghana
    'IR',  -- Iran
    'KP',  -- North Korea
    'LR',  -- Liberia
    'ML',  -- Mali
    'NE',  -- Niger
    'NR',  -- Nauru
    'RU',  -- Russian Federation
    'SD',  -- Sudan
    'TM',  -- Turkmenistan
    'VE',  -- Venezuela
    'YE'   -- Yemen
  );

-- Verify the update worked
SELECT 
    passport_country,
    destination_country,
    status,
    notes
FROM visa_requirements 
WHERE passport_country = 'US' 
  AND status = 'consulate_visa'
ORDER BY destination_country;

-- Count how many countries now have consulate_visa status
SELECT 
    status,
    COUNT(*) as count
FROM visa_requirements 
WHERE passport_country = 'US'
GROUP BY status
ORDER BY status; 