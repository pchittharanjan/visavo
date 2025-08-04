-- Group 1: US, Canada, Mexico, UK, Australia Passports
-- This script provides visa requirements for the first 5 passport types

-- Clear existing data for these passport types
DELETE FROM visa_requirements WHERE passport_country IN ('US', 'CA', 'MX', 'GB', 'AU');

-- US Passport Holders (Comprehensive)
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- North America
('US', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('US', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Europe
('US', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Asia Pacific
('US', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online at least 4 days before travel'),
('US', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('US', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Americas
('US', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required for US citizens'),

-- Middle East
('US', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- UK Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Europe
('GB', 'DE', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('GB', 'FR', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('GB', 'IT', 'visa_free', 90, 0.00, 'EUR', 0, 'No visa required for tourism'),
('GB', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('GB', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('GB', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('GB', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('GB', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Asia Pacific
('GB', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('GB', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('GB', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('GB', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('GB', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Middle East
('GB', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Canadian Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- North America
('CA', 'US', 'eta_required', 180, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('CA', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Europe
('CA', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('CA', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('CA', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('CA', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('CA', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Asia Pacific
('CA', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('CA', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('CA', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('CA', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('CA', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Americas
('CA', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Middle East
('CA', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Mexican Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- North America
('MX', 'US', 'consulate_visa', 180, 160.00, 'USD', 15, 'Consulate visa required. Apply at US embassy'),
('MX', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),

-- Europe
('MX', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Asia Pacific
('MX', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('MX', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('MX', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),
('MX', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),

-- Americas
('MX', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Middle East
('MX', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Australian Passport Holders
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
-- Asia Pacific
('AU', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('AU', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('AU', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online before travel'),
('AU', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy'),

-- Europe
('AU', 'GB', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('AU', 'DE', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('AU', 'FR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('AU', 'IT', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('AU', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),

-- Americas
('AU', 'US', 'eta_required', 90, 21.00, 'USD', 0, 'ESTA required for visa-free travel'),
('AU', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('AU', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('AU', 'BR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),

-- Middle East
('AU', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel');

-- Update the is_active flag for all entries
UPDATE visa_requirements SET is_active = true WHERE is_active IS NULL; 