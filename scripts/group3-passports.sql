-- Group 3: Japan, South Korea, India, China, Saudi Arabia Passports
-- This script provides visa requirements for the final 5 passport types

-- Clear existing data for these passport types
DELETE FROM visa_requirements WHERE passport_country IN ('JP', 'KR', 'IN', 'CN', 'SA');

-- Japanese Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Asia Pacific
('JP', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('JP', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('JP', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Europe
('JP', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('JP', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('JP', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('JP', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('JP', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Middle East
('JP', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- South Korean Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Asia Pacific
('KR', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('KR', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('KR', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Europe
('KR', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('KR', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('KR', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('KR', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('KR', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Middle East
('KR', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Indian Passport Holders (Comprehensive)
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Asia Pacific
('IN', 'JP', 'consulate_visa', 90, 80.00, 'USD', 15, 'Consulate visa required. Apply at Japanese embassy'),
('IN', 'KR', 'consulate_visa', 90, 80.00, 'USD', 15, 'Consulate visa required. Apply at Korean embassy'),
('IN', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('IN', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),

-- Europe
('IN', 'GB', 'consulate_visa', 180, 95.00, 'GBP', 15, 'Consulate visa required. Apply at UK embassy'),
('IN', 'DE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at German embassy'),
('IN', 'FR', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at French embassy'),
('IN', 'IT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Italian embassy'),
('IN', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('IN', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('IN', 'CA', 'consulate_visa', 180, 100.00, 'CAD', 15, 'Consulate visa required. Apply at Canadian embassy'),
('IN', 'MX', 'evisa', 180, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('IN', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required. Apply online before travel'),

-- Middle East
('IN', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Chinese Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Asia Pacific
('CN', 'JP', 'consulate_visa', 90, 80.00, 'USD', 15, 'Consulate visa required. Apply at Japanese embassy'),
('CN', 'KR', 'consulate_visa', 90, 80.00, 'USD', 15, 'Consulate visa required. Apply at Korean embassy'),
('CN', 'IN', 'consulate_visa', 60, 25.00, 'USD', 3, 'Consulate visa required. Apply at Indian embassy'),
('CN', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),

-- Europe
('CN', 'GB', 'consulate_visa', 180, 95.00, 'GBP', 15, 'Consulate visa required. Apply at UK embassy'),
('CN', 'DE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at German embassy'),
('CN', 'FR', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at French embassy'),
('CN', 'IT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Italian embassy'),
('CN', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('CN', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('CN', 'CA', 'consulate_visa', 180, 100.00, 'CAD', 15, 'Consulate visa required. Apply at Canadian embassy'),
('CN', 'MX', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at Mexican embassy'),
('CN', 'BR', 'consulate_visa', 90, 40.00, 'USD', 5, 'Consulate visa required. Apply at Brazilian embassy'),

-- Middle East
('CN', 'SA', 'consulate_visa', 90, 80.00, 'USD', 1, 'Consulate visa required. Apply at Saudi embassy');

-- Saudi Arabian Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Asia Pacific
('SA', 'JP', 'consulate_visa', 90, 80.00, 'USD', 15, 'Consulate visa required. Apply at Japanese embassy'),
('SA', 'KR', 'consulate_visa', 90, 80.00, 'USD', 15, 'Consulate visa required. Apply at Korean embassy'),
('SA', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('SA', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('SA', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),

-- Europe
('SA', 'GB', 'consulate_visa', 180, 95.00, 'GBP', 15, 'Consulate visa required. Apply at UK embassy'),
('SA', 'DE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at German embassy'),
('SA', 'FR', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at French embassy'),
('SA', 'IT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Italian embassy'),
('SA', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('SA', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('SA', 'CA', 'consulate_visa', 180, 100.00, 'CAD', 15, 'Consulate visa required. Apply at Canadian embassy'),
('SA', 'MX', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at Mexican embassy'),
('SA', 'BR', 'consulate_visa', 90, 40.00, 'USD', 5, 'Consulate visa required. Apply at Brazilian embassy');

-- Update the is_active flag for all entries
UPDATE visa_requirements SET is_active = true WHERE is_active IS NULL; 