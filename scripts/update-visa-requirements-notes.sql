-- Update visa_requirements notes to use descriptions from visa_status_types table
-- This ensures consistency and proper descriptions for each visa status

UPDATE visa_requirements 
SET notes = (
  SELECT description 
  FROM visa_status_types 
  WHERE visa_status_types.code = visa_requirements.status
)
WHERE status IN (
  SELECT code 
  FROM visa_status_types 
  WHERE is_active = true
);

-- Verify the update worked
SELECT 
  vr.status,
  vr.notes as updated_notes,
  vst.description as status_description
FROM visa_requirements vr
JOIN visa_status_types vst ON vr.status = vst.code
WHERE vr.passport_country = 'US' 
  AND vr.destination_country IN ('CA', 'MX', 'IN', 'AU', 'GB')
ORDER BY vr.destination_country;

-- Show a few examples of the updated data
SELECT 
  passport_country,
  destination_country,
  status,
  notes
FROM visa_requirements 
WHERE passport_country = 'US' 
  AND destination_country IN ('CA', 'MX', 'IN', 'AU', 'GB')
ORDER BY destination_country; 