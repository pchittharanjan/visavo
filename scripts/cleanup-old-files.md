# Cleanup Plan: Remove Old Files

## Files to Delete (Old/Deprecated)

### Dashboard Files
- [ ] `app/dashboard-backup/page.tsx` - Old backup, no longer needed
- [ ] `app/dashboardglobe/page.tsx` - Old variant, no longer needed
- [ ] `app/dashboard-dynamic/page.tsx` - Dynamic version (keep for now, test first)

### Admin Files  
- [ ] `app/admin-dynamic/page.tsx` - Dynamic version (keep for now, test first)

### Library Files
- [ ] `lib/all-countries.ts` - Old countries file, replaced by `countries.ts`
- [ ] `lib/countries-with-coordinates.ts` - Unused coordinates file
- [ ] `lib/travel-buddy-api.ts` - Old API file, no longer used

### Scripts (Old/Unused)
- [ ] `scripts/add-canada-mexico-data-fixed.sql` - Old data script
- [ ] `scripts/edit-visa-requirements.sql` - Old admin script
- [ ] `scripts/test-admin-permissions.sql` - Old test script
- [ ] `scripts/fix-currency-column.sql` - Old fix script
- [ ] `scripts/populate-countries-table.sql` - Old populate script
- [ ] `scripts/populate-countries-table-fixed.sql` - Old populate script
- [ ] `scripts/check-visa-data.sql` - Old check script
- [ ] `scripts/check-visa-data-fixed.sql` - Old check script
- [ ] `scripts/clean-slate-visa-requirements.sql` - Old data script
- [ ] `scripts/auto-generate-visa-requirements.sql` - Old generate script
- [ ] `scripts/simple-auto-generate.sql` - Old generate script
- [ ] `scripts/simple-auto-generate-all-countries.sql` - Old generate script

## Files to Keep (Current/Active)

### Current Active Files
- ✅ `app/dashboard/page.tsx` - Main dashboard (current)
- ✅ `app/admin/page.tsx` - Main admin (current)
- ✅ `lib/simple-travel-requirements.ts` - Current travel requirements
- ✅ `lib/dynamic-travel-requirements.ts` - New dynamic version
- ✅ `lib/countries.ts` - Current countries file
- ✅ `lib/simple-database.ts` - Current database functions
- ✅ `lib/types.ts` - Current type definitions
- ✅ `lib/utils.ts` - Current utility functions
- ✅ `lib/supabase.ts` - Current Supabase config

### New Files to Test
- 🔄 `app/dashboard-dynamic/page.tsx` - Test before replacing main dashboard
- 🔄 `app/admin-dynamic/page.tsx` - Test before replacing main admin

## Cleanup Steps

### Step 1: Test Dynamic Versions
1. Test `/dashboard-dynamic` - Make sure it works
2. Test `/admin-dynamic` - Make sure it works
3. Verify database integration works

### Step 2: Replace Main Files
1. Replace `app/dashboard/page.tsx` with dynamic version
2. Replace `app/admin/page.tsx` with dynamic version
3. Update imports to use `lib/countries.ts` instead of `all-countries.ts`

### Step 3: Delete Old Files
1. Delete backup and variant files
2. Delete old library files
3. Delete old script files

### Step 4: Update Imports
1. Check all files for imports from deleted files
2. Update imports to use current files
3. Test everything works

## Benefits of Cleanup
- ✅ No more confusion about which file to use
- ✅ Cleaner codebase
- ✅ Easier maintenance
- ✅ No duplicate functionality
- ✅ Clear file structure 