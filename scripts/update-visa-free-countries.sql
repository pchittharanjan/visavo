-- Update countries to Visa Free for US passport holders
-- Based on the list provided

-- Update the status to 'visa_free' for the specified countries
UPDATE visa_requirements 
SET status = 'visa_free'
WHERE passport_country = 'US' 
  AND destination_country IN (
    'AD',  -- Andorra
    'AE',  -- United Arab Emirates
    'AG',  -- Antigua and Barbuda
    'AI',  -- Anguilla
    'AL',  -- Albania
    'AM',  -- Armenia
    'AO',  -- Angola
    'AR',  -- Argentina
    'AT',  -- Austria
    'AW',  -- Aruba
    'BA',  -- Bosnia and Herzegovina
    'BB',  -- Barbados
    'BE',  -- Belgium
    'BG',  -- Bulgaria
    'BM',  -- Bermuda
    'BN',  -- Brunei
    'BS',  -- Bahamas
    'BW',  -- Botswana
    'BZ',  -- Belize
    'CA',  -- Canada
    'CH',  -- Switzerland
    'CL',  -- Chile
    'CO',  -- Colombia
    'CR',  -- Costa Rica
    'CV',  -- Cape Verde
    'CW',  -- Curaçao
    'CY',  -- Cyprus
    'CZ',  -- Czech Republic
    'DE',  -- Germany
    'DK',  -- Denmark
    'DM',  -- Dominica
    'DO',  -- Dominican Republic
    'EC',  -- Ecuador
    'EE',  -- Estonia
    'ES',  -- Spain
    'FI',  -- Finland
    'FJ',  -- Fiji
    'FM',  -- Micronesia
    'FR',  -- France
    'GD',  -- Grenada
    'GE',  -- Georgia
    'GP',  -- Guadeloupe
    'GR',  -- Greece
    'GT',  -- Guatemala
    'GY',  -- Guyana
    'HK',  -- Hong Kong
    'HN',  -- Honduras
    'HR',  -- Croatia
    'HT',  -- Haiti
    'HU',  -- Hungary
    'IE',  -- Ireland
    'IS',  -- Iceland
    'IT',  -- Italy
    'JM',  -- Jamaica
    'JP',  -- Japan
    'KG',  -- Kyrgyzstan
    'KI',  -- Kiribati
    'KR',  -- South Korea
    'KY',  -- Cayman Islands
    'KZ',  -- Kazakhstan
    'LC',  -- Saint Lucia
    'LI',  -- Liechtenstein
    'LS',  -- Lesotho
    'LT',  -- Lithuania
    'LU',  -- Luxembourg
    'LV',  -- Latvia
    'MA',  -- Morocco
    'MC',  -- Monaco
    'MD',  -- Moldova
    'ME',  -- Montenegro
    'MF',  -- Saint Martin
    'MH',  -- Marshall Islands
    'MK',  -- North Macedonia
    'MN',  -- Mongolia
    'MO',  -- Macau
    'MQ',  -- Martinique
    'MS',  -- Montserrat
    'MT',  -- Malta
    'MU',  -- Mauritius
    'MW',  -- Malawi
    'MX',  -- Mexico
    'MY',  -- Malaysia
    'NI',  -- Nicaragua
    'NL',  -- Netherlands
    'NO',  -- Norway
    'PA',  -- Panama
    'PE',  -- Peru
    'PH',  -- Philippines
    'PL',  -- Poland
    'PS',  -- Palestinian Territories
    'PT',  -- Portugal
    'PW',  -- Palau
    'PY',  -- Paraguay
    'RO',  -- Romania
    'RS',  -- Serbia
    'SE',  -- Sweden
    'SG',  -- Singapore
    'SI',  -- Slovenia
    'SK',  -- Slovakia
    'SM',  -- San Marino
    'SN',  -- Senegal
    'SR',  -- Suriname
    'ST',  -- Sao Tome and Principe
    'SV',  -- El Salvador
    'SX',  -- Sint Maarten
    'SZ',  -- Eswatini
    'TC',  -- Turks and Caicos
    'TH',  -- Thailand
    'TJ',  -- Tajikistan
    'TN',  -- Tunisia
    'TR',  -- Türkiye
    'TT',  -- Trinidad and Tobago
    'TW',  -- Taiwan
    'UA',  -- Ukraine
    'UY',  -- Uruguay
    'VA',  -- Vatican City
    'VC',  -- St. Vincent and the Grenadines
    'VG',  -- Virgin Islands (British)
    'VU',  -- Vanuatu
    'XK',  -- Kosovo
    'ZA',  -- South Africa
    'ZM'   -- Zambia
  );

-- Verify the update worked
SELECT 
    passport_country,
    destination_country,
    status,
    notes
FROM visa_requirements 
WHERE passport_country = 'US' 
  AND status = 'visa_free'
ORDER BY destination_country;

-- Count how many countries now have visa_free status
SELECT 
    status,
    COUNT(*) as count
FROM visa_requirements 
WHERE passport_country = 'US'
GROUP BY status
ORDER BY status; 