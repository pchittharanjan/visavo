-- Expand Visa Requirements to More Passport Types
-- This script adds visa requirements for additional passport types from different regions

-- Chinese Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Asia Pacific
('CN', 'JP', 'consulate_visa', 90, 140.00, 'USD', 4, 'Consulate visa required. Apply at Japanese embassy'),
('CN', 'SG', 'evisa', 30, 30.00, 'SGD', 3, 'eVisa required. Apply online before travel'),
('CN', 'KR', 'consulate_visa', 90, 140.00, 'USD', 4, 'Consulate visa required. Apply at Korean embassy'),
('CN', 'TH', 'visa_on_arrival', 15, 2000.00, 'THB', 0, 'Visa on arrival available'),
('CN', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('CN', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('CN', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('CN', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('CN', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('CN', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('CN', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('CN', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('CN', 'PH', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('CN', 'MY', 'evisa', 30, 0.00, 'USD', 2, 'eVisa required. Apply online before travel'),

-- Europe (Mostly consulate visas)
('CN', 'GB', 'consulate_visa', 180, 95.00, 'GBP', 15, 'Consulate visa required. Apply at UK embassy'),
('CN', 'DE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at German embassy'),
('CN', 'FR', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at French embassy'),
('CN', 'IT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Italian embassy'),
('CN', 'ES', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Spanish embassy'),
('CN', 'NL', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Dutch embassy'),
('CN', 'CH', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Swiss embassy'),
('CN', 'AT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Austrian embassy'),
('CN', 'BE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Belgian embassy'),
('CN', 'IE', 'consulate_visa', 90, 60.00, 'EUR', 15, 'Consulate visa required. Apply at Irish embassy'),

-- Americas
('CN', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('CN', 'CA', 'consulate_visa', 180, 100.00, 'CAD', 15, 'Consulate visa required. Apply at Canadian embassy'),
('CN', 'MX', 'evisa', 180, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('CN', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required. Apply online before travel'),
('CN', 'AR', 'evisa', 90, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('CN', 'CL', 'evisa', 90, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('CN', 'CO', 'evisa', 90, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('CN', 'PE', 'evisa', 183, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),

-- Oceania
('CN', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),
('CN', 'NZ', 'consulate_visa', 90, 165.00, 'NZD', 15, 'Consulate visa required. Apply at New Zealand embassy'),

-- Middle East & Africa
('CN', 'IL', 'consulate_visa', 30, 25.00, 'USD', 5, 'Consulate visa required. Apply at Israeli embassy'),
('CN', 'AE', 'evisa', 14, 0.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('CN', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('CN', 'QA', 'evisa', 30, 0.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('CN', 'KW', 'evisa', 30, 3.00, 'KWD', 1, 'eVisa required. Apply online before travel'),
('CN', 'BH', 'evisa', 14, 0.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('CN', 'OM', 'evisa', 30, 20.00, 'OMR', 1, 'eVisa required. Apply online before travel'),
('CN', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('CN', 'LB', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('CN', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('CN', 'TR', 'evisa', 30, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('CN', 'ZA', 'consulate_visa', 90, 25.00, 'USD', 5, 'Consulate visa required. Apply at South African embassy');

-- Russian Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Europe (Some visa-free, mostly consulate visas)
('RU', 'GB', 'consulate_visa', 180, 95.00, 'GBP', 15, 'Consulate visa required. Apply at UK embassy'),
('RU', 'DE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at German embassy'),
('RU', 'FR', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at French embassy'),
('RU', 'IT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Italian embassy'),
('RU', 'ES', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Spanish embassy'),
('RU', 'NL', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Dutch embassy'),
('RU', 'CH', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Swiss embassy'),
('RU', 'AT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Austrian embassy'),
('RU', 'BE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Belgian embassy'),
('RU', 'IE', 'consulate_visa', 90, 60.00, 'EUR', 15, 'Consulate visa required. Apply at Irish embassy'),

-- Americas
('RU', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('RU', 'CA', 'consulate_visa', 180, 100.00, 'CAD', 15, 'Consulate visa required. Apply at Canadian embassy'),
('RU', 'MX', 'evisa', 180, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('RU', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required. Apply online before travel'),
('RU', 'AR', 'evisa', 90, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('RU', 'CL', 'evisa', 90, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('RU', 'CO', 'evisa', 90, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('RU', 'PE', 'evisa', 183, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),

-- Asia Pacific
('RU', 'JP', 'consulate_visa', 90, 140.00, 'USD', 4, 'Consulate visa required. Apply at Japanese embassy'),
('RU', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('RU', 'KR', 'visa_free', 60, 0.00, 'USD', 0, 'No visa required for tourism'),
('RU', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),
('RU', 'NZ', 'consulate_visa', 90, 165.00, 'NZD', 15, 'Consulate visa required. Apply at New Zealand embassy'),
('RU', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available'),
('RU', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('RU', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('RU', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'PH', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for tourism'),
('RU', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),

-- Middle East & Africa
('RU', 'IL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('RU', 'AE', 'visa_free', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('RU', 'QA', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('RU', 'LB', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'MA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('RU', 'TR', 'evisa', 90, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('RU', 'ZA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism');

-- Mexican Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- North America
('MX', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('MX', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),

-- South America (Mostly visa-free)
('MX', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'CL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'CO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'PE', 'visa_free', 183, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Europe (Mostly consulate visas)
('MX', 'GB', 'consulate_visa', 180, 95.00, 'GBP', 15, 'Consulate visa required. Apply at UK embassy'),
('MX', 'DE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at German embassy'),
('MX', 'FR', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at French embassy'),
('MX', 'IT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Italian embassy'),
('MX', 'ES', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Spanish embassy'),
('MX', 'NL', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Dutch embassy'),
('MX', 'CH', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Swiss embassy'),
('MX', 'AT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Austrian embassy'),
('MX', 'BE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Belgian embassy'),
('MX', 'IE', 'consulate_visa', 90, 60.00, 'EUR', 15, 'Consulate visa required. Apply at Irish embassy'),

-- Asia Pacific
('MX', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),
('MX', 'NZ', 'eta_required', 90, 23.00, 'NZD', 0, 'NZeTA required for visa-free travel'),
('MX', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available'),
('MX', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('MX', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('MX', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('MX', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('MX', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('MX', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('MX', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('MX', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('MX', 'PH', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),

-- Middle East & Africa
('MX', 'IL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'AE', 'visa_free', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('MX', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('MX', 'QA', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('MX', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('MX', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('MX', 'MA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'TR', 'evisa', 90, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('MX', 'ZA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism');

-- South Korean Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Asia Pacific
('KR', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available'),
('KR', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('KR', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('KR', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('KR', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('KR', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('KR', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('KR', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('KR', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('KR', 'PH', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),

-- Europe (Mostly visa-free)
('KR', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'ES', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'NL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'SE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'NO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'DK', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'FI', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'CH', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'AT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'BE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'IE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Americas
('KR', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('KR', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('KR', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'CL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'CO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'PE', 'visa_free', 183, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Oceania
('KR', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),
('KR', 'NZ', 'eta_required', 90, 23.00, 'NZD', 0, 'NZeTA required for visa-free travel'),

-- Middle East & Africa
('KR', 'IL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'AE', 'visa_free', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('KR', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('KR', 'QA', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('KR', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('KR', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('KR', 'MA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'TR', 'evisa', 90, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('KR', 'ZA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism');

-- Update the is_active flag for all new entries
UPDATE visa_requirements SET is_active = true WHERE is_active IS NULL; 