-- Additional Passport Types for Comprehensive Coverage
-- This script adds visa requirements for more passport types from different regions

-- German Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Europe (Mostly visa-free)
('DE', 'GB', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'FR', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'IT', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'ES', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'NL', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'SE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'NO', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'DK', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'FI', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'CH', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'AT', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'BE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'IE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),

-- Americas
('DE', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('DE', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('DE', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'CL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'CO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'PE', 'visa_free', 183, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Asia Pacific
('DE', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),
('DE', 'NZ', 'eta_required', 90, 23.00, 'NZD', 0, 'NZeTA required for visa-free travel'),
('DE', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available'),
('DE', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('DE', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('DE', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('DE', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('DE', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('DE', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('DE', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('DE', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('DE', 'PH', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),

-- Middle East & Africa
('DE', 'IL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'AE', 'visa_free', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('DE', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('DE', 'QA', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('DE', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('DE', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('DE', 'MA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'TR', 'evisa', 90, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('DE', 'ZA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism');

-- French Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Europe (Mostly visa-free)
('FR', 'GB', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'DE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'IT', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'ES', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'NL', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'SE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'NO', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'DK', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'FI', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'CH', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'AT', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'BE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'IE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),

-- Americas
('FR', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('FR', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('FR', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'CL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'CO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'PE', 'visa_free', 183, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Asia Pacific
('FR', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),
('FR', 'NZ', 'eta_required', 90, 23.00, 'NZD', 0, 'NZeTA required for visa-free travel'),
('FR', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available'),
('FR', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('FR', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('FR', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('FR', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('FR', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('FR', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('FR', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('FR', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('FR', 'PH', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),

-- Middle East & Africa
('FR', 'IL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'AE', 'visa_free', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('FR', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('FR', 'QA', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('FR', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('FR', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('FR', 'MA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'TR', 'evisa', 90, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('FR', 'ZA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism');

-- Japanese Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Asia Pacific
('JP', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available'),
('JP', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('JP', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('JP', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('JP', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('JP', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('JP', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('JP', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('JP', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('JP', 'PH', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),

-- Europe (Mostly visa-free)
('JP', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'ES', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'NL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'SE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'NO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'DK', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'FI', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'CH', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'AT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'BE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'IE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Americas
('JP', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('JP', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('JP', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'CL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'CO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'PE', 'visa_free', 183, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Oceania
('JP', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),
('JP', 'NZ', 'eta_required', 90, 23.00, 'NZD', 0, 'NZeTA required for visa-free travel'),

-- Middle East & Africa
('JP', 'IL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'AE', 'visa_free', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('JP', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('JP', 'QA', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('JP', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('JP', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('JP', 'MA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'TR', 'evisa', 90, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('JP', 'ZA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism');

-- Brazilian Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- South America (Mostly visa-free)
('BR', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'CL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'CO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'PE', 'visa_free', 183, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Europe (Mostly consulate visas)
('BR', 'GB', 'consulate_visa', 180, 95.00, 'GBP', 15, 'Consulate visa required. Apply at UK embassy'),
('BR', 'DE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at German embassy'),
('BR', 'FR', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at French embassy'),
('BR', 'IT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Italian embassy'),
('BR', 'ES', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Spanish embassy'),
('BR', 'NL', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Dutch embassy'),
('BR', 'CH', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Swiss embassy'),
('BR', 'AT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Austrian embassy'),
('BR', 'BE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Belgian embassy'),
('BR', 'IE', 'consulate_visa', 90, 60.00, 'EUR', 15, 'Consulate visa required. Apply at Irish embassy'),

-- Americas
('BR', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('BR', 'CA', 'consulate_visa', 180, 100.00, 'CAD', 15, 'Consulate visa required. Apply at Canadian embassy'),

-- Asia Pacific
('BR', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),
('BR', 'NZ', 'consulate_visa', 90, 165.00, 'NZD', 15, 'Consulate visa required. Apply at New Zealand embassy'),
('BR', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available'),
('BR', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('BR', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('BR', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('BR', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('BR', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('BR', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('BR', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('BR', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('BR', 'PH', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),

-- Middle East & Africa
('BR', 'IL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'AE', 'visa_free', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('BR', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('BR', 'QA', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('BR', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('BR', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('BR', 'MA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'TR', 'evisa', 90, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('BR', 'ZA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism');

-- Update the is_active flag for all new entries
UPDATE visa_requirements SET is_active = true WHERE is_active IS NULL; 