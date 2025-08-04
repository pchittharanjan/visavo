-- Comprehensive Visa Requirements Update
-- This script adds accurate visa requirements for multiple passport types

-- Clear existing data for US passport holders (we'll add more comprehensive data)
DELETE FROM visa_requirements WHERE passport_country = 'US';

-- US Passport Holders - Comprehensive Visa Requirements
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- North America
('US', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('US', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'PE', 'visa_free', 183, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required for US citizens'),

-- Europe
('US', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'ES', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'NL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'SE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'NO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'DK', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'FI', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CH', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'AT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'BE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'IE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'PL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CZ', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'HU', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'RO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'BG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'HR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'SI', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'SK', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'LT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'LV', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'EE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'MT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CY', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'GR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'PT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'LU', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'IS', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'UA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Asia Pacific
('US', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),
('US', 'NZ', 'eta_required', 90, 23.00, 'NZD', 0, 'NZeTA required for visa-free travel'),
('US', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available at major airports'),
('US', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online at least 4 days before travel'),
('US', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online at least 3 days before travel'),
('US', 'MM', 'evisa', 28, 50.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('US', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('US', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('US', 'BD', 'visa_on_arrival', 30, 51.00, 'USD', 0, 'Visa on arrival available'),
('US', 'PK', 'evisa', 30, 60.00, 'USD', 5, 'eVisa required. Apply online before travel'),
('US', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('US', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('US', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('US', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available. Can be extended'),
('US', 'PH', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),

-- Middle East & Africa
('US', 'IL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'AE', 'visa_free', 30, 0.00, 'USD', 0, 'Visa on arrival available. Can be extended'),
('US', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('US', 'QA', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('US', 'KW', 'evisa', 90, 3.00, 'KWD', 1, 'eVisa required. Apply online before travel'),
('US', 'BH', 'visa_on_arrival', 14, 0.00, 'USD', 0, 'Visa on arrival available'),
('US', 'OM', 'evisa', 30, 20.00, 'OMR', 1, 'eVisa required. Apply online before travel'),
('US', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('US', 'LB', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('US', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available. Bring USD in cash'),
('US', 'MA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'TR', 'evisa', 90, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('US', 'ZA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy');

-- Indian Passport Holders - Comprehensive Visa Requirements
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

-- Add Bhutan to countries table if not exists
INSERT INTO countries (code, name, flag) VALUES
('BT', 'Bhutan', '🇧🇹')
ON CONFLICT (code) DO NOTHING;

-- Add Bhutan visa requirements for Indian passport
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
('IN', 'BT', 'visa_free', 14, 0.00, 'USD', 0, 'No visa required for Indian citizens')
ON CONFLICT (passport_country, destination_country) DO UPDATE SET
  status = EXCLUDED.status,
  allowed_stay_days = EXCLUDED.allowed_stay_days,
  visa_fee_amount = EXCLUDED.visa_fee_amount,
  visa_fee_currency = EXCLUDED.visa_fee_currency,
  processing_time_days = EXCLUDED.processing_time_days,
  notes = EXCLUDED.notes,
  last_updated = NOW(); 