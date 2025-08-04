-- Update existing documents to use unified 'permanent_residence' document type
-- This script updates any existing documents that use 'green_card' or 'pr_card' to use 'permanent_residence'

-- Update green_card documents to permanent_residence
UPDATE documents 
SET document_type = 'permanent_residence' 
WHERE document_type = 'green_card';

-- Update pr_card documents to permanent_residence
UPDATE documents 
SET document_type = 'permanent_residence' 
WHERE document_type = 'pr_card';

-- Verify the changes
SELECT DISTINCT document_type FROM documents ORDER BY document_type; 