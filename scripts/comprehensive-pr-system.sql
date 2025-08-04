-- Comprehensive Permanent Resident System
-- This system uses regional blocs + bilateral relationships for scalable PR logic

-- 1. Regional Blocs Table
CREATE TABLE IF NOT EXISTS regional_blocs (
    id SERIAL PRIMARY KEY,
    bloc_name VARCHAR(100) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 2. Regional Bloc Members
CREATE TABLE IF NOT EXISTS regional_bloc_members (
    id SERIAL PRIMARY KEY,
    bloc_id INTEGER REFERENCES regional_blocs(id),
    country_code VARCHAR(2) NOT NULL,
    member_since DATE,
    is_active BOOLEAN DEFAULT true,
    UNIQUE(bloc_id, country_code)
);

-- 3. Regional PR Privileges
CREATE TABLE IF NOT EXISTS regional_pr_privileges (
    id SERIAL PRIMARY KEY,
    bloc_id INTEGER REFERENCES regional_blocs(id),
    privilege_type VARCHAR(50) NOT NULL, -- 'visa_free', 'eta_required', 'visa_on_arrival'
    allowed_stay_days INTEGER DEFAULT 90,
    notes TEXT,
    is_active BOOLEAN DEFAULT true
);

-- 4. Bilateral PR Relationships
CREATE TABLE IF NOT EXISTS bilateral_pr_relationships (
    id SERIAL PRIMARY KEY,
    pr_country VARCHAR(2) NOT NULL, -- Country where person has PR
    destination_country VARCHAR(2) NOT NULL, -- Country they want to visit
    privilege_type VARCHAR(50) NOT NULL,
    allowed_stay_days INTEGER DEFAULT 90,
    notes TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(pr_country, destination_country)
);

-- Clear existing data
DELETE FROM bilateral_pr_relationships;
DELETE FROM regional_pr_privileges;
DELETE FROM regional_bloc_members;
DELETE FROM regional_blocs;

-- Insert Regional Blocs FIRST
INSERT INTO regional_blocs (id, bloc_name, description) VALUES
(1, 'European Union', 'EU member states with mutual recognition of permanent residence'),
(2, 'Schengen Area', 'Schengen countries with visa-free travel for residents'),
(3, 'NAFTA/USMCA', 'North American Free Trade Agreement countries'),
(4, 'ASEAN', 'Association of Southeast Asian Nations'),
(5, 'Commonwealth', 'Commonwealth of Nations with some mutual privileges'),
(6, 'Nordic Council', 'Scandinavian countries with mutual recognition'),
(7, 'Gulf Cooperation Council', 'GCC countries with some mutual privileges'),
(8, 'Mercosur', 'South American trade bloc'),
(9, 'Pacific Alliance', 'Latin American trade bloc'),
(10, 'CARICOM', 'Caribbean Community');

-- Insert Regional Bloc Members
INSERT INTO regional_bloc_members (bloc_id, country_code) VALUES
-- EU Members
(1, 'DE'), (1, 'FR'), (1, 'IT'), (1, 'ES'), (1, 'NL'), (1, 'BE'), (1, 'AT'), (1, 'SE'), (1, 'DK'), (1, 'FI'),
(1, 'PT'), (1, 'IE'), (1, 'PL'), (1, 'CZ'), (1, 'HU'), (1, 'RO'), (1, 'BG'), (1, 'HR'), (1, 'SI'), (1, 'SK'),
(1, 'LT'), (1, 'LV'), (1, 'EE'), (1, 'MT'), (1, 'CY'), (1, 'LU'), (1, 'GR'),

-- Schengen (includes some non-EU)
(2, 'DE'), (2, 'FR'), (2, 'IT'), (2, 'ES'), (2, 'NL'), (2, 'BE'), (2, 'AT'), (2, 'SE'), (2, 'DK'), (2, 'FI'),
(2, 'PT'), (2, 'NO'), (2, 'CH'), (2, 'IS'), (2, 'LU'), (2, 'GR'), (2, 'PL'), (2, 'CZ'), (2, 'HU'), (2, 'SI'),
(2, 'SK'), (2, 'LT'), (2, 'LV'), (2, 'EE'), (2, 'MT'), (2, 'LI'),

-- NAFTA/USMCA
(3, 'US'), (3, 'CA'), (3, 'MX'),

-- ASEAN
(4, 'SG'), (4, 'MY'), (4, 'TH'), (4, 'ID'), (4, 'PH'), (4, 'VN'), (4, 'MM'), (4, 'KH'), (4, 'LA'), (4, 'BN'),

-- Commonwealth
(5, 'GB'), (5, 'CA'), (5, 'AU'), (5, 'NZ'), (5, 'IN'), (5, 'ZA'), (5, 'NG'), (5, 'KE'), (5, 'UG'), (5, 'TZ'),
(5, 'MW'), (5, 'ZM'), (5, 'ZW'), (5, 'BW'), (5, 'NA'), (5, 'SZ'), (5, 'LS'), (5, 'MU'), (5, 'SC'), (5, 'JM'),
(5, 'BB'), (5, 'TT'), (5, 'GY'), (5, 'BZ'), (5, 'BS'), (5, 'AG'), (5, 'KN'), (5, 'LC'), (5, 'VC'), (5, 'GD'),
(5, 'DM'), (5, 'FJ'), (5, 'PG'), (5, 'SB'), (5, 'VU'), (5, 'NC'), (5, 'WS'), (5, 'TO'), (5, 'KI'), (5, 'TV'),
(5, 'NR'), (5, 'PW'), (5, 'MH'), (5, 'FM'), (5, 'PK'), (5, 'BD'), (5, 'LK'), (5, 'MV'), (5, 'NP'), (5, 'BT'),
(5, 'MY'), (5, 'SG'), (5, 'BN'), (5, 'CY'), (5, 'MT'), (5, 'IE'),

-- Nordic Council
(6, 'SE'), (6, 'NO'), (6, 'DK'), (6, 'FI'), (6, 'IS'),

-- GCC
(7, 'SA'), (7, 'AE'), (7, 'QA'), (7, 'KW'), (7, 'BH'), (7, 'OM'),

-- Mercosur
(8, 'BR'), (8, 'AR'), (8, 'PY'), (8, 'UY'), (8, 'VE'), (8, 'BO'),

-- Pacific Alliance
(9, 'CL'), (9, 'CO'), (9, 'PE'), (9, 'MX'),

-- CARICOM
(10, 'JM'), (10, 'BB'), (10, 'TT'), (10, 'GY'), (10, 'BZ'), (10, 'BS'), (10, 'AG'), (10, 'KN'), (10, 'LC'),
(10, 'VC'), (10, 'GD'), (10, 'DM'), (10, 'SR'), (10, 'HT'), (10, 'DO');

-- Insert Regional PR Privileges
INSERT INTO regional_pr_privileges (bloc_id, privilege_type, allowed_stay_days, notes) VALUES
-- EU: PR holders can visit other EU countries visa-free
(1, 'visa_free', 90, 'EU permanent residents can visit other EU countries visa-free for up to 90 days'),
-- Schengen: Similar to EU but includes some non-EU countries
(2, 'visa_free', 90, 'Schengen permanent residents can visit other Schengen countries visa-free'),
-- NAFTA: Limited PR privileges
(3, 'visa_free', 180, 'NAFTA permanent residents get some visa-free access to other NAFTA countries'),
-- ASEAN: Limited mutual recognition
(4, 'visa_on_arrival', 30, 'ASEAN permanent residents get visa-on-arrival in some other ASEAN countries'),
-- Commonwealth: Limited privileges
(5, 'eta_required', 90, 'Commonwealth permanent residents may get simplified visa processes'),
-- Nordic: Strong mutual recognition
(6, 'visa_free', 90, 'Nordic permanent residents can visit other Nordic countries visa-free'),
-- GCC: Limited mutual recognition
(7, 'visa_free', 30, 'GCC permanent residents can visit other GCC countries visa-free'),
-- Mercosur: Strong mutual recognition
(8, 'visa_free', 90, 'Mercosur permanent residents can visit other Mercosur countries visa-free'),
-- Pacific Alliance: Limited mutual recognition
(9, 'visa_free', 90, 'Pacific Alliance permanent residents get some visa-free access'),
-- CARICOM: Strong mutual recognition
(10, 'visa_free', 90, 'CARICOM permanent residents can visit other CARICOM countries visa-free');

-- Insert Major Bilateral PR Relationships
INSERT INTO bilateral_pr_relationships (pr_country, destination_country, privilege_type, allowed_stay_days, notes) VALUES
-- US Green Card holders get extensive privileges
('US', 'CA', 'visa_free', 180, 'US Green Card holders can visit Canada visa-free'),
('US', 'MX', 'visa_free', 180, 'US Green Card holders can visit Mexico visa-free'),
('US', 'BS', 'visa_free', 30, 'US Green Card holders can visit Bahamas visa-free'),
('US', 'BB', 'visa_free', 30, 'US Green Card holders can visit Barbados visa-free'),
('US', 'JM', 'visa_free', 30, 'US Green Card holders can visit Jamaica visa-free'),
('US', 'TT', 'visa_free', 30, 'US Green Card holders can visit Trinidad & Tobago visa-free'),
('US', 'CR', 'visa_free', 90, 'US Green Card holders can visit Costa Rica visa-free'),
('US', 'PA', 'visa_free', 90, 'US Green Card holders can visit Panama visa-free'),
('US', 'GT', 'visa_free', 90, 'US Green Card holders can visit Guatemala visa-free'),
('US', 'SV', 'visa_free', 90, 'US Green Card holders can visit El Salvador visa-free'),
('US', 'HN', 'visa_free', 90, 'US Green Card holders can visit Honduras visa-free'),
('US', 'NI', 'visa_free', 90, 'US Green Card holders can visit Nicaragua visa-free'),
('US', 'CO', 'visa_free', 90, 'US Green Card holders can visit Colombia visa-free'),
('US', 'PE', 'visa_free', 183, 'US Green Card holders can visit Peru visa-free'),
('US', 'EC', 'visa_free', 90, 'US Green Card holders can visit Ecuador visa-free'),
('US', 'CL', 'visa_free', 90, 'US Green Card holders can visit Chile visa-free'),
('US', 'AR', 'visa_free', 90, 'US Green Card holders can visit Argentina visa-free'),
('US', 'UY', 'visa_free', 90, 'US Green Card holders can visit Uruguay visa-free'),
('US', 'PY', 'visa_free', 90, 'US Green Card holders can visit Paraguay visa-free'),
('US', 'BO', 'visa_free', 90, 'US Green Card holders can visit Bolivia visa-free'),
('US', 'AE', 'visa_free', 30, 'US Green Card holders can visit UAE visa-free'),
('US', 'QA', 'visa_free', 30, 'US Green Card holders can visit Qatar visa-free'),
('US', 'KW', 'visa_free', 30, 'US Green Card holders can visit Kuwait visa-free'),
('US', 'BH', 'visa_free', 14, 'US Green Card holders can visit Bahrain visa-free'),
('US', 'OM', 'visa_free', 30, 'US Green Card holders can visit Oman visa-free'),
('US', 'JO', 'visa_free', 30, 'US Green Card holders can visit Jordan visa-free'),
('US', 'LB', 'visa_free', 30, 'US Green Card holders can visit Lebanon visa-free'),
('US', 'EG', 'visa_free', 30, 'US Green Card holders can visit Egypt visa-free'),
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
('US', 'MV', 'visa_free', 30, 'US Green Card holders can visit Maldives visa-free'),

-- Canadian PR holders
('CA', 'US', 'visa_free', 180, 'Canadian PR holders can visit US visa-free'),
('CA', 'MX', 'visa_free', 180, 'Canadian PR holders can visit Mexico visa-free'),
('CA', 'BS', 'visa_free', 30, 'Canadian PR holders can visit Bahamas visa-free'),
('CA', 'BB', 'visa_free', 30, 'Canadian PR holders can visit Barbados visa-free'),
('CA', 'JM', 'visa_free', 30, 'Canadian PR holders can visit Jamaica visa-free'),
('CA', 'CR', 'visa_free', 90, 'Canadian PR holders can visit Costa Rica visa-free'),
('CA', 'PA', 'visa_free', 90, 'Canadian PR holders can visit Panama visa-free'),

-- Australian PR holders
('AU', 'NZ', 'visa_free', 90, 'Australian PR holders can visit New Zealand visa-free'),
('AU', 'SG', 'visa_free', 30, 'Australian PR holders can visit Singapore visa-free'),
('AU', 'MY', 'visa_free', 30, 'Australian PR holders can visit Malaysia visa-free'),
('AU', 'TH', 'visa_free', 30, 'Australian PR holders can visit Thailand visa-free'),
('AU', 'PH', 'visa_free', 30, 'Australian PR holders can visit Philippines visa-free'),
('AU', 'ID', 'visa_free', 30, 'Australian PR holders can visit Indonesia visa-free'),
('AU', 'FJ', 'visa_free', 30, 'Australian PR holders can visit Fiji visa-free'),
('AU', 'PG', 'visa_free', 30, 'Australian PR holders can visit Papua New Guinea visa-free'),

-- UK PR holders
('GB', 'IE', 'visa_free', 90, 'UK PR holders can visit Ireland visa-free'),
('GB', 'BS', 'visa_free', 30, 'UK PR holders can visit Bahamas visa-free'),
('GB', 'BB', 'visa_free', 30, 'UK PR holders can visit Barbados visa-free'),
('GB', 'JM', 'visa_free', 30, 'UK PR holders can visit Jamaica visa-free'),

-- German PR holders (EU benefits covered by regional bloc)
('DE', 'CH', 'visa_free', 90, 'German PR holders can visit Switzerland visa-free'),

-- French PR holders (EU benefits covered by regional bloc)
('FR', 'CH', 'visa_free', 90, 'French PR holders can visit Switzerland visa-free'),

-- Japanese PR holders
('JP', 'KR', 'visa_free', 90, 'Japanese PR holders can visit South Korea visa-free'),
('JP', 'SG', 'visa_free', 30, 'Japanese PR holders can visit Singapore visa-free'),
('JP', 'MY', 'visa_free', 30, 'Japanese PR holders can visit Malaysia visa-free'),
('JP', 'TH', 'visa_free', 30, 'Japanese PR holders can visit Thailand visa-free'),

-- Singapore PR holders
('SG', 'MY', 'visa_free', 30, 'Singapore PR holders can visit Malaysia visa-free'),
('SG', 'TH', 'visa_free', 30, 'Singapore PR holders can visit Thailand visa-free'),
('SG', 'ID', 'visa_free', 30, 'Singapore PR holders can visit Indonesia visa-free'),
('SG', 'PH', 'visa_free', 30, 'Singapore PR holders can visit Philippines visa-free'),

-- UAE PR holders
('AE', 'SA', 'visa_free', 30, 'UAE PR holders can visit Saudi Arabia visa-free'),
('AE', 'QA', 'visa_free', 30, 'UAE PR holders can visit Qatar visa-free'),
('AE', 'KW', 'visa_free', 30, 'UAE PR holders can visit Kuwait visa-free'),
('AE', 'BH', 'visa_free', 14, 'UAE PR holders can visit Bahrain visa-free'),
('AE', 'OM', 'visa_free', 30, 'UAE PR holders can visit Oman visa-free');

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_regional_bloc_members_lookup 
ON regional_bloc_members(bloc_id, country_code, is_active);

CREATE INDEX IF NOT EXISTS idx_regional_pr_privileges_lookup 
ON regional_pr_privileges(bloc_id, is_active);

CREATE INDEX IF NOT EXISTS idx_bilateral_pr_relationships_lookup 
ON bilateral_pr_relationships(pr_country, destination_country, is_active); 