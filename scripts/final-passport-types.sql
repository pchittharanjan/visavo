-- Final Passport Types to Complete 13-Passport Database
-- This script adds the final 6 passport types to complete the comprehensive database

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
-- Europe (Mostly consulate visas)
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
('RU', 'SG', 'evisa', 30, 30.00, 'SGD', 3, 'eVisa required. Apply online before travel'),
('RU', 'KR', 'consulate_visa', 90, 140.00, 'USD', 4, 'Consulate visa required. Apply at Korean embassy'),
('RU', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),
('RU', 'NZ', 'consulate_visa', 90, 165.00, 'NZD', 15, 'Consulate visa required. Apply at New Zealand embassy'),
('RU', 'TH', 'visa_on_arrival', 15, 2000.00, 'THB', 0, 'Visa on arrival available'),
('RU', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('RU', 'VN', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('RU', 'KH', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'LA', 'visa_on_arrival', 30, 30.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'LK', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'NP', 'visa_on_arrival', 90, 30.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'MV', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'ID', 'visa_on_arrival', 30, 35.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'PH', 'evisa', 30, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('RU', 'CN', 'visa_free', 30, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Middle East & Africa
('RU', 'IL', 'consulate_visa', 30, 25.00, 'USD', 5, 'Consulate visa required. Apply at Israeli embassy'),
('RU', 'AE', 'evisa', 14, 0.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('RU', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('RU', 'QA', 'evisa', 30, 0.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('RU', 'KW', 'evisa', 30, 3.00, 'KWD', 1, 'eVisa required. Apply online before travel'),
('RU', 'BH', 'evisa', 14, 0.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('RU', 'OM', 'evisa', 30, 20.00, 'OMR', 1, 'eVisa required. Apply online before travel'),
('RU', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('RU', 'LB', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available'),
('RU', 'TR', 'evisa', 30, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('RU', 'ZA', 'consulate_visa', 90, 25.00, 'USD', 5, 'Consulate visa required. Apply at South African embassy');

-- Mexican Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- North America
('MX', 'US', 'eta_required', 180, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
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
('MX', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),
('MX', 'NZ', 'consulate_visa', 90, 165.00, 'NZD', 15, 'Consulate visa required. Apply at New Zealand embassy'),
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

-- Update the is_active flag for all entries
UPDATE visa_requirements SET is_active = true WHERE is_active IS NULL; 