-- Create trigger to automatically update notes based on status
-- This links the notes column to the description from visa_status_types

-- Step 1: Create the trigger function
CREATE OR REPLACE FUNCTION update_notes_from_status()
RETURNS TRIGGER AS $$
BEGIN
    -- Update notes based on the status
    NEW.notes = (
        SELECT description 
        FROM visa_status_types 
        WHERE code = NEW.status
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Step 2: Create the trigger
DROP TRIGGER IF EXISTS trigger_update_notes ON visa_requirements;
CREATE TRIGGER trigger_update_notes
    BEFORE INSERT OR UPDATE ON visa_requirements
    FOR EACH ROW
    EXECUTE FUNCTION update_notes_from_status();

-- Step 3: Update all existing records to sync with current status
UPDATE visa_requirements 
SET notes = (
    SELECT description 
    FROM visa_status_types 
    WHERE visa_status_types.code = visa_requirements.status
);

-- Step 4: Verify the trigger works by testing an update
-- Let's test with a sample record
SELECT 
    vr.passport_country,
    vr.destination_country,
    vr.status,
    vr.notes as current_notes,
    vst.description as status_description
FROM visa_requirements vr
JOIN visa_status_types vst ON vr.status = vst.code
WHERE vr.passport_country = 'US' 
  AND vr.destination_country IN ('CA', 'IN', 'AU')
ORDER BY vr.destination_country;

-- Step 5: Test the trigger by updating a status
-- This should automatically update the notes
UPDATE visa_requirements 
SET status = 'evisa' 
WHERE passport_country = 'US' 
  AND destination_country = 'IN';

-- Step 6: Verify the trigger worked
SELECT 
    passport_country,
    destination_country,
    status,
    notes
FROM visa_requirements 
WHERE passport_country = 'US' 
  AND destination_country = 'IN'; 