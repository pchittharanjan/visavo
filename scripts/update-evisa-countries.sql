-- Update countries to eVisa for US passport holders
-- Based on the list provided

-- Update the status to 'evisa' for the specified countries
UPDATE visa_requirements 
SET status = 'evisa'
WHERE passport_country = 'US' 
  AND destination_country IN (
    'AZ',  -- Azerbaijan
    'BF',  -- Burkina Faso
    'BH',  -- Bahrain
    'BI',  -- Burundi
    'BJ',  -- Benin
    'BO',  -- Bolivia
    'BR',  -- Brazil
    'BT',  -- Bhutan
    'BY',  -- Belarus
    'CD',  -- Congo (Dem. Rep.)
    'CI',  -- Cote d'Ivoire
    'CM',  -- Cameroon
    'CU',  -- Cuba
    'DJ',  -- Djibouti
    'EG',  -- Egypt
    'ET',  -- Ethiopia
    'GA',  -- Gabon
    'GN',  -- Guinea
    'GQ',  -- Equatorial Guinea
    'ID',  -- Indonesia
    'IN',  -- India
    'IQ',  -- Iraq
    'JO',  -- Jordan
    'KH',  -- Cambodia
    'KW',  -- Kuwait
    'LA',  -- Laos
    'LY',  -- Libya
    'MM',  -- Myanmar
    'MR',  -- Mauritania
    'NA',  -- Namibia
    'NG',  -- Nigeria
    'NP',  -- Nepal
    'OM',  -- Oman
    'PG',  -- Papua New Guinea
    'RW',  -- Rwanda
    'SA',  -- Saudi Arabia
    'SL',  -- Sierra Leone
    'SO',  -- Somalia
    'SS',  -- South Sudan
    'SY',  -- Syria
    'TD',  -- Chad
    'TG',  -- Togo
    'TZ',  -- Tanzania
    'UG',  -- Uganda
    'VN',  -- Viet Nam
    'ZW'   -- Zimbabwe
  );

-- Verify the update worked
SELECT 
    passport_country,
    destination_country,
    status,
    notes
FROM visa_requirements 
WHERE passport_country = 'US' 
  AND status = 'evisa'
ORDER BY destination_country;

-- Count how many countries now have evisa status
SELECT 
    status,
    COUNT(*) as count
FROM visa_requirements 
WHERE passport_country = 'US'
GROUP BY status
ORDER BY status; 