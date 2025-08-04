-- Permanent Resident Rules Table
-- This table defines which countries give visa-free access to permanent residents of other countries

-- Create the permanent resident rules table
CREATE TABLE IF NOT EXISTS permanent_resident_rules (
    id SERIAL PRIMARY KEY,
    permanent_residence_country VARCHAR(2) NOT NULL, -- Country where person has PR
    destination_country VARCHAR(2) NOT NULL, -- Country they want to visit
    status VARCHAR(20) NOT NULL DEFAULT 'visa_free', -- Usually visa_free for PR holders
    allowed_stay_days INTEGER DEFAULT 180,
    notes TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(permanent_residence_country, destination_country)
);

-- Clear existing data
DELETE FROM permanent_resident_rules;

-- US Green Card holders get visa-free access to:
INSERT INTO permanent_resident_rules (permanent_residence_country, destination_country, status, allowed_stay_days, notes) VALUES
-- North America
('US', 'CA', 'visa_free', 180, 'US Green Card holders can visit Canada visa-free'),
('US', 'MX', 'visa_free', 180, 'US Green Card holders can visit Mexico visa-free'),

-- Caribbean
('US', 'BS', 'visa_free', 30, 'US Green Card holders can visit Bahamas visa-free'),
('US', 'BB', 'visa_free', 30, 'US Green Card holders can visit Barbados visa-free'),
('US', 'JM', 'visa_free', 30, 'US Green Card holders can visit Jamaica visa-free'),
('US', 'TT', 'visa_free', 30, 'US Green Card holders can visit Trinidad & Tobago visa-free'),

-- Central America
('US', 'CR', 'visa_free', 90, 'US Green Card holders can visit Costa Rica visa-free'),
('US', 'PA', 'visa_free', 90, 'US Green Card holders can visit Panama visa-free'),
('US', 'GT', 'visa_free', 90, 'US Green Card holders can visit Guatemala visa-free'),
('US', 'SV', 'visa_free', 90, 'US Green Card holders can visit El Salvador visa-free'),
('US', 'HN', 'visa_free', 90, 'US Green Card holders can visit Honduras visa-free'),
('US', 'NI', 'visa_free', 90, 'US Green Card holders can visit Nicaragua visa-free'),

-- South America
('US', 'CO', 'visa_free', 90, 'US Green Card holders can visit Colombia visa-free'),
('US', 'PE', 'visa_free', 183, 'US Green Card holders can visit Peru visa-free'),
('US', 'EC', 'visa_free', 90, 'US Green Card holders can visit Ecuador visa-free'),
('US', 'CL', 'visa_free', 90, 'US Green Card holders can visit Chile visa-free'),
('US', 'AR', 'visa_free', 90, 'US Green Card holders can visit Argentina visa-free'),
('US', 'UY', 'visa_free', 90, 'US Green Card holders can visit Uruguay visa-free'),
('US', 'PY', 'visa_free', 90, 'US Green Card holders can visit Paraguay visa-free'),
('US', 'BO', 'visa_free', 90, 'US Green Card holders can visit Bolivia visa-free'),

-- Middle East
('US', 'AE', 'visa_free', 30, 'US Green Card holders can visit UAE visa-free'),
('US', 'QA', 'visa_free', 30, 'US Green Card holders can visit Qatar visa-free'),
('US', 'KW', 'visa_free', 30, 'US Green Card holders can visit Kuwait visa-free'),
('US', 'BH', 'visa_free', 14, 'US Green Card holders can visit Bahrain visa-free'),
('US', 'OM', 'visa_free', 30, 'US Green Card holders can visit Oman visa-free'),
('US', 'JO', 'visa_free', 30, 'US Green Card holders can visit Jordan visa-free'),
('US', 'LB', 'visa_free', 30, 'US Green Card holders can visit Lebanon visa-free'),
('US', 'EG', 'visa_free', 30, 'US Green Card holders can visit Egypt visa-free'),

-- Asia Pacific
('US', 'SG', 'visa_free', 30, 'US Green Card holders can visit Singapore visa-free'),
('US', 'MY', 'visa_free', 30, 'US Green Card holders can visit Malaysia visa-free'),
('US', 'TH', 'visa_free', 30, 'US Green Card holders can visit Thailand visa-free'),
('US', 'PH', 'visa_free', 30, 'US Green Card holders can visit Philippines visa-free'),
('US', 'ID', 'visa_free', 30, 'US Green Card holders can visit Indonesia visa-free'),
('US', 'VN', 'visa_free', 30, 'US Green Card holders can visit Vietnam visa-free'),
('US', 'KH', 'visa_free', 30, 'US Green Card holders can visit Cambodia visa-free'),
('US', 'LA', 'visa_free', 30, 'US Green Card holders can visit Laos visa-free'),
('US', 'MM', 'visa_free', 28, 'US Green Card holders can visit Myanmar visa-free'),
('US', 'BD', 'visa_free', 30, 'US Green Card holders can visit Bangladesh visa-free'),
('US', 'PK', 'visa_free', 30, 'US Green Card holders can visit Pakistan visa-free'),
('US', 'LK', 'visa_free', 30, 'US Green Card holders can visit Sri Lanka visa-free'),
('US', 'NP', 'visa_free', 90, 'US Green Card holders can visit Nepal visa-free'),
('US', 'MV', 'visa_free', 30, 'US Green Card holders can visit Maldives visa-free');

-- Canadian PR holders get visa-free access to:
INSERT INTO permanent_resident_rules (permanent_residence_country, destination_country, status, allowed_stay_days, notes) VALUES
-- North America
('CA', 'US', 'visa_free', 180, 'Canadian PR holders can visit US visa-free'),
('CA', 'MX', 'visa_free', 180, 'Canadian PR holders can visit Mexico visa-free'),

-- Caribbean
('CA', 'BS', 'visa_free', 30, 'Canadian PR holders can visit Bahamas visa-free'),
('CA', 'BB', 'visa_free', 30, 'Canadian PR holders can visit Barbados visa-free'),
('CA', 'JM', 'visa_free', 30, 'Canadian PR holders can visit Jamaica visa-free'),

-- Central America
('CA', 'CR', 'visa_free', 90, 'Canadian PR holders can visit Costa Rica visa-free'),
('CA', 'PA', 'visa_free', 90, 'Canadian PR holders can visit Panama visa-free');

-- Australian PR holders get visa-free access to:
INSERT INTO permanent_resident_rules (permanent_residence_country, destination_country, status, allowed_stay_days, notes) VALUES
-- Oceania
('AU', 'NZ', 'visa_free', 90, 'Australian PR holders can visit New Zealand visa-free'),

-- Asia Pacific
('AU', 'SG', 'visa_free', 30, 'Australian PR holders can visit Singapore visa-free'),
('AU', 'MY', 'visa_free', 30, 'Australian PR holders can visit Malaysia visa-free'),
('AU', 'TH', 'visa_free', 30, 'Australian PR holders can visit Thailand visa-free'),
('AU', 'PH', 'visa_free', 30, 'Australian PR holders can visit Philippines visa-free'),
('AU', 'ID', 'visa_free', 30, 'Australian PR holders can visit Indonesia visa-free'),
('AU', 'FJ', 'visa_free', 30, 'Australian PR holders can visit Fiji visa-free'),
('AU', 'PG', 'visa_free', 30, 'Australian PR holders can visit Papua New Guinea visa-free');

-- UK PR holders get visa-free access to:
INSERT INTO permanent_resident_rules (permanent_residence_country, destination_country, status, allowed_stay_days, notes) VALUES
-- Europe
('GB', 'IE', 'visa_free', 90, 'UK PR holders can visit Ireland visa-free'),

-- Caribbean
('GB', 'BS', 'visa_free', 30, 'UK PR holders can visit Bahamas visa-free'),
('GB', 'BB', 'visa_free', 30, 'UK PR holders can visit Barbados visa-free'),
('GB', 'JM', 'visa_free', 30, 'UK PR holders can visit Jamaica visa-free');

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_permanent_resident_rules_lookup 
ON permanent_resident_rules(permanent_residence_country, destination_country, is_active); 