-- Dynamic Visa Requirements Database Setup
-- Run this in your Supabase SQL Editor

-- Countries table
CREATE TABLE IF NOT EXISTS countries (
  code VARCHAR(2) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  flag VARCHAR(10) NOT NULL,
  region VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Document types table
CREATE TABLE IF NOT EXISTS document_types (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Visa requirement rules table
CREATE TABLE IF NOT EXISTS visa_requirements (
  id SERIAL PRIMARY KEY,
  passport_country VARCHAR(2) REFERENCES countries(code),
  destination_country VARCHAR(2) REFERENCES countries(code),
  status VARCHAR(20) NOT NULL, -- 'visa_free', 'eta_required', 'evisa', etc.
  passport_validity_months INTEGER DEFAULT 6,
  allowed_stay_days INTEGER,
  visa_fee_amount DECIMAL(10,2),
  visa_fee_currency VARCHAR(3) DEFAULT 'USD',
  processing_time_days INTEGER,
  notes TEXT,
  requirements_url VARCHAR(255),
  last_updated TIMESTAMP DEFAULT NOW(),
  is_active BOOLEAN DEFAULT true,
  UNIQUE(passport_country, destination_country)
);

-- Special override rules (like OCI cards)
CREATE TABLE IF NOT EXISTS special_overrides (
  id SERIAL PRIMARY KEY,
  destination_country VARCHAR(2) REFERENCES countries(code),
  required_documents JSONB NOT NULL, -- Array of required document combinations
  override_status VARCHAR(20) NOT NULL,
  notes TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Country-specific requirements details
CREATE TABLE IF NOT EXISTS country_requirements (
  id SERIAL PRIMARY KEY,
  country_code VARCHAR(2) REFERENCES countries(code),
  requirement_type VARCHAR(50) NOT NULL, -- 'passport_validity', 'allowed_stay', etc.
  requirement_value TEXT NOT NULL,
  requirement_notes TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_visa_requirements_passport ON visa_requirements(passport_country);
CREATE INDEX IF NOT EXISTS idx_visa_requirements_destination ON visa_requirements(destination_country);
CREATE INDEX IF NOT EXISTS idx_visa_requirements_status ON visa_requirements(status);
CREATE INDEX IF NOT EXISTS idx_special_overrides_destination ON special_overrides(destination_country);
CREATE INDEX IF NOT EXISTS idx_country_requirements_country ON country_requirements(country_code);

-- Sample data insertion
INSERT INTO countries (code, name, flag) VALUES
('US', 'United States', '🇺🇸'),
('CA', 'Canada', '🇨🇦'),
('GB', 'United Kingdom', '🇬🇧'),
('AU', 'Australia', '🇦🇺'),
('IN', 'India', '🇮🇳'),
('AR', 'Argentina', '🇦🇷'),
('BR', 'Brazil', '🇧🇷'),
('JP', 'Japan', '🇯🇵'),
('SG', 'Singapore', '🇸🇬'),
('TH', 'Thailand', '🇹🇭'),
('MX', 'Mexico', '🇲🇽'),
('CL', 'Chile', '🇨🇱'),
('CO', 'Colombia', '🇨🇴'),
('PE', 'Peru', '🇵🇪'),
('ZA', 'South Africa', '🇿🇦'),
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
('JO', 'Jordan', '🇯🇴'),
('LB', 'Lebanon', '🇱🇧'),
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
('DE', 'Germany', '🇩🇪'),
('FR', 'France', '🇫🇷'),
('IT', 'Italy', '🇮🇹'),
('ES', 'Spain', '🇪🇸'),
('NL', 'Netherlands', '🇳🇱'),
('SE', 'Sweden', '🇸🇪'),
('NO', 'Norway', '🇳🇴'),
('DK', 'Denmark', '🇩🇰'),
('FI', 'Finland', '🇫🇮'),
('CH', 'Switzerland', '🇨🇭'),
('AT', 'Austria', '🇦🇹'),
('BE', 'Belgium', '🇧🇪'),
('IE', 'Ireland', '🇮🇪'),
('NZ', 'New Zealand', '🇳🇿'),
('KR', 'South Korea', '🇰🇷'),
('VN', 'Vietnam', '🇻🇳'),
('MM', 'Myanmar', '🇲🇲'),
('KH', 'Cambodia', '🇰🇭'),
('LA', 'Laos', '🇱🇦'),
('BD', 'Bangladesh', '🇧🇩'),
('PK', 'Pakistan', '🇵🇰'),
('LK', 'Sri Lanka', '🇱🇰'),
('NP', 'Nepal', '🇳🇵'),
('MV', 'Maldives', '🇲🇻'),
('ID', 'Indonesia', '🇮🇩'),
('PH', 'Philippines', '🇵🇭'),
('CN', 'China', '🇨🇳')
ON CONFLICT (code) DO NOTHING;

INSERT INTO document_types (name, description) VALUES
('passport', 'National passport'),
('tourist_visa', 'Tourist visa'),
('business_visa', 'Business visa'),
('student_visa', 'Student visa'),
('work_permit', 'Work permit'),
('pr_card', 'Permanent resident card'),
('oci_card', 'Overseas Citizen of India card'),
('green_card', 'US Permanent Resident Card')
ON CONFLICT DO NOTHING;

-- Sample visa requirements (US passport holders)
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
('US', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('US', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online at least 4 days before travel'),
('US', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),
('US', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required for US citizens'),
('US', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available at major airports'),
('US', 'MX', 'visa_free', 180, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'CO', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'PE', 'visa_free', 183, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'ZA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'EG', 'visa_on_arrival', 30, 25.00, 'USD', 0, 'Visa on arrival available. Bring USD in cash'),
('US', 'MA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'TR', 'evisa', 90, 50.00, 'USD', 0, 'eVisa required. Apply online before travel'),
('US', 'IL', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'AE', 'visa_free', 30, 0.00, 'USD', 0, 'Visa on arrival available. Can be extended'),
('US', 'SA', 'evisa', 90, 80.00, 'USD', 1, 'eVisa required. Apply online before travel'),
('US', 'QA', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('US', 'KW', 'evisa', 90, 3.00, 'KWD', 1, 'eVisa required. Apply online before travel'),
('US', 'BH', 'visa_on_arrival', 14, 0.00, 'USD', 0, 'Visa on arrival available'),
('US', 'OM', 'evisa', 30, 20.00, 'OMR', 1, 'eVisa required. Apply online before travel'),
('US', 'JO', 'visa_on_arrival', 30, 40.00, 'JOD', 0, 'Visa on arrival available'),
('US', 'LB', 'visa_on_arrival', 30, 0.00, 'USD', 0, 'Visa on arrival available'),
('US', 'RU', 'consulate_visa', 30, 160.00, 'USD', 10, 'Consulate visa required. Apply at Russian embassy'),
('US', 'UA', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
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
('US', 'NZ', 'eta_required', 90, 23.00, 'NZD', 0, 'NZeTA required for visa-free travel'),
('US', 'KR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
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
('US', 'CN', 'consulate_visa', 30, 140.00, 'USD', 4, 'Consulate visa required. Apply at Chinese embassy')
ON CONFLICT (passport_country, destination_country) DO UPDATE SET
  status = EXCLUDED.status,
  allowed_stay_days = EXCLUDED.allowed_stay_days,
  visa_fee_amount = EXCLUDED.visa_fee_amount,
  visa_fee_currency = EXCLUDED.visa_fee_currency,
  processing_time_days = EXCLUDED.processing_time_days,
  notes = EXCLUDED.notes,
  last_updated = NOW();

-- Sample special overrides (OCI card for India)
INSERT INTO special_overrides (destination_country, required_documents, override_status, notes) VALUES
('IN', '["US", "oci_card"]', 'visa_free', 'US passport + OCI card = visa-free to India'),
('IN', '["GB", "oci_card"]', 'visa_free', 'UK passport + OCI card = visa-free to India'),
('IN', '["CA", "oci_card"]', 'visa_free', 'Canadian passport + OCI card = visa-free to India')
ON CONFLICT DO NOTHING;

-- Sample country requirements
INSERT INTO country_requirements (country_code, requirement_type, requirement_value, requirement_notes) VALUES
('US', 'passport_validity', 'Valid passport required', 'For US citizens'),
('US', 'allowed_stay', 'Unlimited (citizen)', 'For US citizens'),
('CA', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('CA', 'allowed_stay', '6 months', 'For eTA holders'),
('IN', 'passport_validity', '6+ months beyond stay', 'For eVisa holders'),
('IN', 'allowed_stay', '60 days', 'For eVisa holders'),
('AU', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('AU', 'allowed_stay', '90 days', 'For ETA holders'),
('NZ', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('NZ', 'allowed_stay', '90 days', 'For NZeTA holders'),
('TH', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('TH', 'allowed_stay', '30 days', 'For visa on arrival'),
('BR', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('BR', 'allowed_stay', '90 days', 'For eVisa holders'),
('TR', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('TR', 'allowed_stay', '90 days', 'For eVisa holders'),
('SA', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('SA', 'allowed_stay', '90 days', 'For eVisa holders'),
('VN', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('VN', 'allowed_stay', '30 days', 'For eVisa holders'),
('MM', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('MM', 'allowed_stay', '28 days', 'For eVisa holders'),
('PK', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('PK', 'allowed_stay', '30 days', 'For eVisa holders'),
('CN', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('CN', 'allowed_stay', '30 days', 'For consulate visa holders'),
('RU', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('RU', 'allowed_stay', '30 days', 'For consulate visa holders')
ON CONFLICT DO NOTHING; 