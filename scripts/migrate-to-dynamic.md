# Migration Guide: From simple-travel-requirements to dynamic-travel-requirements

## Overview
This guide helps you migrate from the deprecated `lib/simple-travel-requirements.ts` to the new `lib/dynamic-travel-requirements.ts` that pulls data from the database.

## Files to Update

### 1. components/Globe.tsx
**Current imports:**
```typescript
import { getSimpleTravelStatus, getSimpleBatchTravelStatuses } from '@/lib/simple-travel-requirements'
import { getStatusColor } from '@/lib/simple-travel-requirements'
```

**New imports:**
```typescript
import { getSimpleTravelStatus, getSimpleBatchTravelStatuses } from '@/lib/dynamic-travel-requirements'
import { getDynamicStatusColor } from '@/lib/dynamic-travel-requirements'
```

**Changes needed:**
- Replace `getStatusColor` calls with `getDynamicStatusColor` (async function)
- Update any synchronous color calls to handle async nature

### 2. app/dashboard/page.tsx
**Current imports:**
```typescript
import { getStatusLabel, getStatusColor, getRequirementsText } from '@/lib/simple-travel-requirements'
```

**New imports:**
```typescript
import { 
  getDynamicStatusLabel, 
  getDynamicStatusColor, 
  getDynamicRequirementsText 
} from '@/lib/dynamic-travel-requirements'
```

**Changes needed:**
- Replace all function calls with their dynamic equivalents
- Handle async nature of dynamic functions
- Update state management to handle async loading

### 3. app/dashboard-backup/page.tsx
Same changes as dashboard/page.tsx

### 4. app/dashboardglobe/page.tsx
Same changes as dashboard/page.tsx

## Migration Steps

### Step 1: Test Dynamic Version
1. Test `/admin-dynamic` - verify it works with database
2. Test `/dashboard-dynamic` - verify it works with database
3. Ensure all visa status types are in the databaseare

### Step 2: Update Components One by One
1. Start with `components/Globe.tsx` (most critical)
2. Update imports and function calls
3. Test thoroughly
4. Move to next component

### Step 3: Remove Old File
1. After all components are migrated and tested
2. Delete `lib/simple-travel-requirements.ts`
3. Run full application test

## Benefits of Migration

1. **Dynamic Status Types** - Add new types via database
2. **Consistent Data** - Single source of truth
3. **Better Maintainability** - Change descriptions in one place
4. **Future-Proof** - Easy to extend with new fields

## Rollback Plan

If issues arise:
1. Keep `lib/simple-travel-requirements.ts` as backup
2. Revert imports to old file
3. Fix issues in dynamic version
4. Retry migration

## Testing Checklist

- [ ] Admin console loads status types from database
- [ ] Dashboard displays correct colors and labels
- [ ] Globe component shows correct country colors
- [ ] Country details show correct requirements
- [ ] No console errors
- [ ] Performance is acceptable (caching works) 