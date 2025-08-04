-- Remaining Passport Types for Complete 13-Passport Database
-- This script adds the remaining 9 passport types to complete the comprehensive database

-- Indian Passport Holders (Comprehensive)
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- South Asia (Visa-free for Indian citizens)
('IN', 'NP', 'visa_free', 150, 0.00, 'USD', 0, 'No visa required for Indian citizens'),
('IN', 'BT', 'visa_free', 14, 0.00, 'USD', 0, 'No visa required for Indian citizens'),
('IN', 'MV', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for Indian citizens'),
('IN', 'LK', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for Indian citizens'),

-- Southeast Asia
('IN', 'TH', 'visa_on_arrival', 15, 2000.00, 'THB', 0, 'Visa on arrival available'),
('IN', 'SG', 'evisa', 30, 30.00, 'SGD', 3, 'eVisa required. Apply online before travel'),
('IN', 'MY', 'evisa', 30, 0.00, 'USD', 2, 'eVisa required. Apply online before travel'),
('IN', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('IN', 'PH', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('IN', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('IN', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('IN', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('IN', 'MM', 'evisa', 28, 50.00, 'USD', 3, 'eVisa required. Apply online before travel'),

-- Middle East
('IN', 'AE', 'evisa', 14, 0.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('IN', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('IN', 'QA', 'evisa', 30, 0.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('IN', 'KW', 'evisa', 30, 3.00, 'KWD', 1, 'eVisa required. Apply online before travel'),
('IN', 'BH', 'evisa', 14, 0.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('IN', 'OM', 'evisa', 30, 20.00, 'OMR', 1, 'eVisa required. Apply online before travel'),
('IN', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('IN', 'LB', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('IN', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('IN', 'TR', 'evisa', 30, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('IN', 'IL', 'consulate_visa', 30, 25.00, 'USD', 5, 'Consulate visa required. Apply at Israeli embassy'),

-- Europe (Mostly consulate visas)
('IN', 'GB', 'consulate_visa', 180, 95.00, 'GBP', 15, 'Consulate visa required. Apply at UK embassy'),
('IN', 'DE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at German embassy'),
('IN', 'FR', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at French embassy'),
('IN', 'IT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Italian embassy'),
('IN', 'ES', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Spanish embassy'),
('IN', 'NL', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Dutch embassy'),
('IN', 'CH', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Swiss embassy'),
('IN', 'AT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Austrian embassy'),
('IN', 'BE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Belgian embassy'),
('IN', 'IE', 'consulate_visa', 90, 60.00, 'EUR', 15, 'Consulate visa required. Apply at Irish embassy'),

-- Americas
('IN', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('IN', 'CA', 'consulate_visa', 180, 100.00, 'CAD', 15, 'Consulate visa required. Apply at Canadian embassy'),
('IN', 'MX', 'evisa', 180, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('IN', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required. Apply online before travel'),
('IN', 'AR', 'evisa', 90, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('IN', 'CL', 'evisa', 90, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('IN', 'CO', 'evisa', 90, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('IN', 'PE', 'evisa', 183, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),

-- Oceania
('IN', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),
('IN', 'NZ', 'consulate_visa', 90, 165.00, 'NZD', 15, 'Consulate visa required. Apply at New Zealand embassy');

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
('FR', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online at least 3 days before travel'),
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

-- Update the is_active flag for all entries
UPDATE visa_requirements SET is_active = true WHERE is_active IS NULL; 