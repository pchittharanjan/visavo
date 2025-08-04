-- Group 2: Germany, France, Italy, Russia, Brazil Passports
-- This script provides visa requirements for the second 5 passport types

-- Clear existing data for these passport types
DELETE FROM visa_requirements WHERE passport_country IN ('DE', 'FR', 'IT', 'RU', 'BR');

-- German Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Europe
('DE', 'GB', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'FR', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'IT', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('DE', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('DE', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('DE', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('DE', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Asia Pacific
('DE', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('DE', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('DE', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('DE', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Middle East
('DE', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- French Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Europe
('FR', 'GB', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'DE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'IT', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('FR', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('FR', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('FR', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('FR', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Asia Pacific
('FR', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('FR', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('FR', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('FR', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Middle East
('FR', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Italian Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Europe
('IT', 'GB', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('IT', 'DE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('IT', 'FR', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('IT', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('IT', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('IT', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('IT', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('IT', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Asia Pacific
('IT', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('IT', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('IT', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('IT', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('IT', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Middle East
('IT', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Russian Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Europe
('RU', 'GB', 'consulate_visa', 180, 95.00, 'GBP', 15, 'Consulate visa required. Apply at UK embassy'),
('RU', 'DE', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at German embassy'),
('RU', 'FR', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at French embassy'),
('RU', 'IT', 'consulate_visa', 90, 80.00, 'EUR', 15, 'Consulate visa required. Apply at Italian embassy'),

-- Americas
('RU', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('RU', 'CA', 'consulate_visa', 180, 100.00, 'CAD', 15, 'Consulate visa required. Apply at Canadian embassy'),
('RU', 'MX', 'evisa', 180, 0.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('RU', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required. Apply online before travel'),

-- Asia Pacific
('RU', 'JP', 'consulate_visa', 90, 80.00, 'USD', 15, 'Consulate visa required. Apply at Japanese embassy'),
('RU', 'KR', 'consulate_visa', 90, 80.00, 'USD', 15, 'Consulate visa required. Apply at Korean embassy'),
('RU', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('RU', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('RU', 'AU', 'consulate_visa', 90, 140.00, 'AUD', 15, 'Consulate visa required. Apply at Australian embassy'),

-- Middle East
('RU', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Brazilian Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Americas
('BR', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('BR', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('BR', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Europe
('BR', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Asia Pacific
('BR', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('BR', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('BR', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('BR', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Middle East
('BR', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Update the is_active flag for all entries
UPDATE visa_requirements SET is_active = true WHERE is_active IS NULL; 