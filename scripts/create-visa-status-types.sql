-- Create visa_status_types table to standardize visa requirement categories
-- This will help maintain consistency and make the system more flexible

-- 1. Create the visa_status_types table
CREATE TABLE IF NOT EXISTS visa_status_types (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Insert the standard visa status types
INSERT INTO visa_status_types (code, name, description) VALUES
('visa_free', 'Visa Free', 'No visa required for tourism. Travelers can enter without any visa application.'),
('evisa', 'eVisa', 'Electronic visa required. Must be applied for online before travel.'),
('eta_required', 'eTA Required', 'Electronic Travel Authorization required. Must be applied for online before travel.'),
('visa_on_arrival', 'Visa on Arrival', 'Visa can be obtained upon arrival at the destination airport/border.'),
('consulate_visa', 'Consulate Visa', 'Visa must be applied for at the destination country embassy or consulate before travel.')
ON CONFLICT (code) DO NOTHING;

-- 3. Verify the data
SELECT * FROM visa_status_types ORDER BY id;

-- 4. Add a foreign key constraint to visa_requirements table
-- (This enforces referential integrity - only if it doesn't already exist)
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_name = 'fk_visa_requirements_status'
    ) THEN
        ALTER TABLE visa_requirements 
        ADD CONSTRAINT fk_visa_requirements_status 
        FOREIGN KEY (status) REFERENCES visa_status_types(code);
    END IF;
END $$;

-- 5. Show current status values in visa_requirements to compare
SELECT DISTINCT status, COUNT(*) as count
FROM visa_requirements 
GROUP BY status 
ORDER BY status; 