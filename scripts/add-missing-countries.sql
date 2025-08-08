-- Add missing countries to the countries table
INSERT INTO countries (code, name, flag) VALUES
('HK', 'Hong Kong', '🇭🇰'),
('XK', 'Kosovo', '🇽🇰'),
('MO', 'Macau', '🇲🇴'),
('KP', 'North Korea', '🇰🇵'),
('PS', 'Palestinian Territories', '🇵🇸')
ON CONFLICT (code) DO NOTHING;

-- Verify the countries were added
SELECT code, name, flag FROM countries 
WHERE code IN ('HK', 'XK', 'MO', 'KP', 'PS')
ORDER BY name;

-- Show total count
SELECT COUNT(*) as total_countries FROM countries; 