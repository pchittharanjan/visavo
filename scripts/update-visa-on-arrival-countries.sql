-- Update countries to Visa on Arrival for US passport holders
-- Based on the list from the image showing 34 countries with Visa on Arrival

-- Update the status to 'visa_on_arrival' for the specified countries
UPDATE visa_requirements 
SET status = 'visa_on_arrival'
WHERE passport_country = 'US' 
  AND destination_country IN (
    'BD',  -- Bangladesh
    'BH',  -- Bahrain
    'BI',  -- Burundi
    'CI',  -- Cote d'Ivoire
    'DJ',  -- Djibouti
    'EG',  -- Egypt
    'ET',  -- Ethiopia
    'GM',  -- Gambia
    'GW',  -- Guinea-Bissau
    'ID',  -- Indonesia
    'JO',  -- Jordan
    'KH',  -- Cambodia
    'KM',  -- Comoros
    'KW',  -- Kuwait
    'LA',  -- Laos
    'LB',  -- Lebanon
    'LK',  -- Sri Lanka
    'MG',  -- Madagascar
    'MV',  -- Maldives
    'NA',  -- Namibia
    'NP',  -- Nepal
    'OM',  -- Oman
    'PK',  -- Pakistan
    'QA',  -- Qatar
    'RW',  -- Rwanda
    'SA',  -- Saudi Arabia
    'SB',  -- Solomon Islands
    'SL',  -- Sierra Leone
    'TL',  -- Timor-Leste
    'TO',  -- Tonga
    'TV',  -- Tuvalu
    'TZ',  -- Tanzania
    'WS',  -- Samoa
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
  AND status = 'visa_on_arrival'
ORDER BY destination_country;

-- Count how many countries now have visa_on_arrival status
SELECT 
    status,
    COUNT(*) as count
FROM visa_requirements 
WHERE passport_country = 'US'
GROUP BY status
ORDER BY status; 