-- Simple PR rules table (replaces complex regional bloc system)
CREATE TABLE IF NOT EXISTS simple_pr_rules (
    id SERIAL PRIMARY KEY,
    pr_country VARCHAR(2) NOT NULL,
    destination_country VARCHAR(2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'visa_free',
    notes TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(pr_country, destination_country)
);

-- Clear existing data
DELETE FROM simple_pr_rules;

-- Insert simple PR rules
INSERT INTO simple_pr_rules (pr_country, destination_country, status, notes) VALUES
-- US Green Card holders
('US', 'CA', 'visa_free', 'US Green Card holders can visit Canada visa-free'),
('US', 'MX', 'visa_free', 'US Green Card holders can visit Mexico visa-free'),
('US', 'SG', 'visa_free', 'US Green Card holders can visit Singapore visa-free'),

-- Canadian PR holders  
('CA', 'US', 'visa_free', 'Canadian PR holders can visit US visa-free'),

-- Australian PR holders
('AU', 'NZ', 'visa_free', 'Australian PR holders can visit New Zealand visa-free'),

-- UK PR holders
('GB', 'IE', 'visa_free', 'UK PR holders can visit Ireland visa-free');

-- Disable RLS on this simple table
ALTER TABLE simple_pr_rules DISABLE ROW LEVEL SECURITY; 