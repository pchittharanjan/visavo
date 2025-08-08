-- Dynamic Visa Requirements Database Schema
-- This would replace the static code with a real database

-- Countries table
CREATE TABLE countries (
  code VARCHAR(2) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  flag VARCHAR(10) NOT NULL,
  region VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Document types table
CREATE TABLE document_types (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Visa requirement rules table
CREATE TABLE visa_requirements (
  id SERIAL PRIMARY KEY,
  passport_country VARCHAR(2) REFERENCES countries(code),
  destination_country VARCHAR(2) REFERENCES countries(code),
  status VARCHAR(20) NOT NULL, -- 'visa_free', 'eta_required', 'evisa', etc.
  passport_validity_months INTEGER DEFAULT 6,
  allowed_stay_days TEXT,
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
CREATE TABLE special_overrides (
  id SERIAL PRIMARY KEY,
  destination_country VARCHAR(2) REFERENCES countries(code),
  required_documents JSONB NOT NULL, -- Array of required document combinations
  override_status VARCHAR(20) NOT NULL,
  notes TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Country-specific requirements details
CREATE TABLE country_requirements (
  id SERIAL PRIMARY KEY,
  country_code VARCHAR(2) REFERENCES countries(code),
  requirement_type VARCHAR(50) NOT NULL, -- 'passport_validity', 'allowed_stay', etc.
  requirement_value TEXT NOT NULL,
  requirement_notes TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);

-- User travel history (optional)
CREATE TABLE user_travel_history (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  destination_country VARCHAR(2) REFERENCES countries(code),
  travel_date DATE,
  entry_status VARCHAR(20), -- 'successful', 'denied', 'delayed'
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- API logs for tracking usage
CREATE TABLE api_logs (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  endpoint VARCHAR(100),
  request_data JSONB,
  response_data JSONB,
  response_time_ms INTEGER,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_visa_requirements_passport ON visa_requirements(passport_country);
CREATE INDEX idx_visa_requirements_destination ON visa_requirements(destination_country);
CREATE INDEX idx_visa_requirements_status ON visa_requirements(status);
CREATE INDEX idx_special_overrides_destination ON special_overrides(destination_country);
CREATE INDEX idx_country_requirements_country ON country_requirements(country_code);

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
('TH', 'Thailand', '🇹🇭');

INSERT INTO document_types (name, description) VALUES
('passport', 'National passport'),
('tourist_visa', 'Tourist visa'),
('business_visa', 'Business visa'),
('student_visa', 'Student visa'),
('work_permit', 'Work permit'),
('pr_card', 'Permanent resident card'),
('oci_card', 'Overseas Citizen of India card'),
('green_card', 'US Permanent Resident Card');

-- Sample visa requirements (US passport holders)
INSERT INTO visa_requirements (passport_country, destination_country, status, allowed_stay_days, visa_fee_amount, visa_fee_currency, processing_time_days, notes) VALUES
('US', 'CA', 'eta_required', 180, 7.00, 'CAD', 0, 'eTA required for visa-free travel'),
('US', 'AR', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'IN', 'evisa', 60, 25.00, 'USD', 3, 'eVisa required. Apply online at least 4 days before travel'),
('US', 'AU', 'eta_required', 90, 20.00, 'AUD', 0, 'ETA required for visa-free travel'),
('US', 'BR', 'evisa', 90, 40.00, 'USD', 5, 'eVisa required for US citizens'),
('US', 'JP', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'SG', 'visa_free', 90, 0.00, 'USD', 0, 'No visa required for tourism'),
('US', 'TH', 'visa_on_arrival', 30, 2000.00, 'THB', 0, 'Visa on arrival available at major airports');

-- Sample special overrides (OCI card for India)
INSERT INTO special_overrides (destination_country, required_documents, override_status, notes) VALUES
('IN', '["US", "oci_card"]', 'visa_free', 'US passport + OCI card = visa-free to India'),
('IN', '["GB", "oci_card"]', 'visa_free', 'UK passport + OCI card = visa-free to India'),
('IN', '["CA", "oci_card"]', 'visa_free', 'Canadian passport + OCI card = visa-free to India');

-- Sample country requirements
INSERT INTO country_requirements (country_code, requirement_type, requirement_value, requirement_notes) VALUES
('US', 'passport_validity', 'Valid passport required', 'For US citizens'),
('US', 'allowed_stay', 'Unlimited (citizen)', 'For US citizens'),
('CA', 'passport_validity', '6+ months beyond stay', 'For all visitors'),
('CA', 'allowed_stay', '6 months', 'For eTA holders'),
('IN', 'passport_validity', '6+ months beyond stay', 'For eVisa holders'),
('IN', 'allowed_stay', '60 days', 'For eVisa holders'); 