-- Add visa requirements for the 5 new countries for US, Canada, and Mexico passport holders

-- US Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, notes) VALUES
-- Hong Kong - Visa Free for US citizens
('US', 'HK', 'visa_free', 90, 0, 'USD', 'US citizens can stay up to 90 days without a visa'),
-- Kosovo - Visa Free for US citizens  
('US', 'XK', 'visa_free', 90, 0, 'USD', 'US citizens can stay up to 90 days without a visa'),
-- Macau - Visa Free for US citizens
('US', 'MO', 'visa_free', 30, 0, 'USD', 'US citizens can stay up to 30 days without a visa'),
-- North Korea - Consulate Visa required
('US', 'KP', 'consulate_visa', 0, 0, 'USD', 'Visa must be obtained through North Korean embassy'),
-- Palestinian Territories - Visa Free for US citizens
('US', 'PS', 'visa_free', 90, 0, 'USD', 'US citizens can stay up to 90 days without a visa'),

-- Canada Passport Holders
-- Hong Kong - Visa Free for Canadian citizens
('CA', 'HK', 'visa_free', 90, 0, 'CAD', 'Canadian citizens can stay up to 90 days without a visa'),
-- Kosovo - Visa Free for Canadian citizens
('CA', 'XK', 'visa_free', 90, 0, 'CAD', 'Canadian citizens can stay up to 90 days without a visa'),
-- Macau - Visa Free for Canadian citizens
('CA', 'MO', 'visa_free', 30, 0, 'CAD', 'Canadian citizens can stay up to 30 days without a visa'),
-- North Korea - Consulate Visa required
('CA', 'KP', 'consulate_visa', 0, 0, 'CAD', 'Visa must be obtained through North Korean embassy'),
-- Palestinian Territories - Visa Free for Canadian citizens
('CA', 'PS', 'visa_free', 90, 0, 'CAD', 'Canadian citizens can stay up to 90 days without a visa'),

-- Mexico Passport Holders
-- Hong Kong - eVisa required for Mexican citizens
('MX', 'HK', 'evisa', 30, 0, 'USD', 'Mexican citizens need to apply for eVisa online'),
-- Kosovo - Visa Free for Mexican citizens
('MX', 'XK', 'visa_free', 90, 0, 'USD', 'Mexican citizens can stay up to 90 days without a visa'),
-- Macau - eVisa required for Mexican citizens
('MX', 'MO', 'evisa', 30, 0, 'USD', 'Mexican citizens need to apply for eVisa online'),
-- North Korea - Consulate Visa required
('MX', 'KP', 'consulate_visa', 0, 0, 'USD', 'Visa must be obtained through North Korean embassy'),
-- Palestinian Territories - eVisa required for Mexican citizens
('MX', 'PS', 'evisa', 30, 0, 'USD', 'Mexican citizens need to apply for eVisa online')
ON CONFLICT (passport_country, destination_country) DO NOTHING;

-- Verify the visa requirements were added
SELECT 
    passport_country,
    destination_country,
    status,
    allowed_stay_days
FROM visa_requirements 
WHERE destination_country IN ('HK', 'XK', 'MO', 'KP', 'PS')
ORDER BY passport_country, destination_country;

-- Show total count of visa requirements
SELECT COUNT(*) as total_visa_requirements FROM visa_requirements; 