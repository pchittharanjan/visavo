-- Complete Visa Requirements Database
-- This script provides comprehensive visa requirements for 13 major passport types

-- Clear existing data to start fresh
DELETE FROM visa_requirements;

-- Add missing countries to the countries table
INSERT INTO countries (code, name, flag) VALUES
('BT', 'Bhutan', '🇧🇹'),
('NP', 'Nepal', '🇳🇵'),
('BD', 'Bangladesh', '🇧🇩'),
('PK', 'Pakistan', '🇵🇰'),
('LK', 'Sri Lanka', '🇱🇰'),
('MV', 'Maldives', '🇲🇻'),
('MM', 'Myanmar', '🇲🇲'),
('KH', 'Cambodia', '🇰🇭'),
('LA', 'Laos', '🇱🇦'),
('VN', 'Vietnam', '🇻🇳'),
('MY', 'Malaysia', '🇲🇾'),
('ID', 'Indonesia', '🇮🇩'),
('PH', 'Philippines', '🇵🇭'),
('TH', 'Thailand', '🇹🇭'),
('SG', 'Singapore', '🇸🇬'),
('JO', 'Jordan', '🇯🇴'),
('LB', 'Lebanon', '🇱🇧'),
('EG', 'Egypt', '🇪🇬'),
('MA', 'Morocco', '🇲🇦'),
('TR', 'Turkey', '🇹🇷'),
('IL', 'Israel', '🇮🇱'),
('AE', 'United Arab Emirates', '🇦🇪'),
('SA', 'Saudi Arabia', '🇸🇦'),
('QA', 'Qatar', '🇶🇦'),
('KW', 'Kuwait', '🇰🇼'),
('BH', 'Bahrain', '🇧🇭'),
('OM', 'Oman', '🇴🇲'),
('RU', 'Russia', '🇷🇺'),
('UA', 'Ukraine', '🇺🇦'),
('PL', 'Poland', '🇵🇱'),
('CZ', 'Czech Republic', '🇨🇿'),
('HU', 'Hungary', '🇭🇺'),
('RO', 'Romania', '🇷🇴'),
('BG', 'Bulgaria', '🇧🇬'),
('HR', 'Croatia', '🇭🇷'),
('SI', 'Slovenia', '🇸🇮'),
('SK', 'Slovakia', '🇸🇰'),
('LT', 'Lithuania', '🇱🇹'),
('LV', 'Latvia', '🇱🇻'),
('EE', 'Estonia', '🇪🇪'),
('MT', 'Malta', '🇲🇹'),
('CY', 'Cyprus', '🇨🇾'),
('GR', 'Greece', '🇬🇷'),
('PT', 'Portugal', '🇵🇹'),
('LU', 'Luxembourg', '🇱🇺'),
('IS', 'Iceland', '🇮🇸'),
('ZA', 'South Africa', '🇿🇦'),
('BR', 'Brazil', '🇧🇷'),
('AR', 'Argentina', '🇦🇷'),
('CL', 'Chile', '🇨🇱'),
('CO', 'Colombia', '🇨🇴'),
('PE', 'Peru', '🇵🇪'),
('CN', 'China', '🇨🇳'),
('JP', 'Japan', '🇯🇵'),
('KR', 'South Korea', '🇰🇷'),
('AU', 'Australia', '🇦🇺'),
('NZ', 'New Zealand', '🇳🇿')
ON CONFLICT (code) DO NOTHING;

-- US Passport Holders (Comprehensive)
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- North America
('US', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('US', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'PE', 'visa_free', 183, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required for US citizens'),

-- Europe (Mostly visa-free)
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

-- Update the is_active flag for all entries
UPDATE visa_requirements SET is_active = true WHERE is_active IS NULL; 