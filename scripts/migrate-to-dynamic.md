# Migration Guide: Static to Dynamic Visa Requirements

## Step 1: Set up the Database

1. **Go to your Supabase Dashboard**
2. **Navigate to SQL Editor**
3. **Run the setup script**: Copy and paste the contents of `scripts/setup-dynamic-db.sql`
4. **Verify tables are created**: Check that all tables exist in the Database section

## Step 2: Update Components

### Update Globe Component
Replace the static function calls with dynamic ones:

```typescript
// OLD (static)
import { getTravelStatus, getStatusColor } from '@/lib/travel-requirements'

// NEW (dynamic)
import { getDynamicTravelStatus, getStatusColor } from '@/lib/dynamic-travel-requirements'

// Update the function call
const status = await getDynamicTravelStatus(userDocuments, countryCode)
```

### Update Dashboard Component
Replace the static function calls:

```typescript
// OLD (static)
import { getStatusLabel, getRequirementsText } from '@/lib/travel-requirements'

// NEW (dynamic)
import { getStatusLabel, getDynamicRequirementsText } from '@/lib/dynamic-travel-requirements'

// Update the function call
const requirements = await getDynamicRequirementsText(status, countryCode, userDocuments)
```

## Step 3: Handle Async Operations

Since the dynamic functions are async, you'll need to update the components:

### Globe Component Changes
```typescript
// Make the click handler async
const handleCountryClick = async (countryCode: string) => {
  const country = countries.find(c => c.code === countryCode)
  if (country) {
    const status = await getDynamicTravelStatus(userDocuments, countryCode)
    onCountryClick({
      code: country.code,
      name: country.name,
      flag: country.flag,
      status,
      requirements: {}
    })
  }
}

// Update the grid rendering to handle async status
const [countryStatuses, setCountryStatuses] = useState<Record<string, TravelStatus>>({})

useEffect(() => {
  const loadStatuses = async () => {
    const statuses: Record<string, TravelStatus> = {}
    for (const country of countries) {
      statuses[country.code] = await getDynamicTravelStatus(userDocuments, country.code)
    }
    setCountryStatuses(statuses)
  }
  loadStatuses()
}, [userDocuments])
```

### Dashboard Component Changes
```typescript
// Make the click handler async
const handleCountryClick = async (countryInfo: CountryInfo) => {
  const requirements = await getDynamicRequirementsText(countryInfo.status, countryInfo.code, userDocuments)
  setSelectedCountry({
    ...countryInfo,
    requirements
  })
}
```

## Step 4: Add Loading States

Add loading indicators while the async operations complete:

```typescript
const [isLoading, setIsLoading] = useState(false)

const handleCountryClick = async (countryCode: string) => {
  setIsLoading(true)
  try {
    // ... async operations
  } finally {
    setIsLoading(false)
  }
}
```

## Step 5: Error Handling

Add proper error handling for database operations:

```typescript
try {
  const status = await getDynamicTravelStatus(userDocuments, countryCode)
  // Handle success
} catch (error) {
  console.error('Error getting travel status:', error)
  // Fallback to default status
  return 'consulate_visa'
}
```

## Step 6: Test the Migration

1. **Test basic functionality**: Click on different countries
2. **Test existing visa logic**: Verify India shows as visa-free with your tourist visa
3. **Test citizen logic**: Verify US shows as visa-free for US passport
4. **Test error handling**: Disconnect internet and verify fallback behavior

## Step 7: Performance Optimization

Consider implementing caching for frequently accessed data:

```typescript
// Add caching for country statuses
const statusCache = new Map<string, TravelStatus>()

const getCachedTravelStatus = async (userDocuments: UserDocument[], destinationCountry: string) => {
  const cacheKey = `${userDocuments.map(d => `${d.issuing_country}-${d.document_type}`).join(',')}-${destinationCountry}`
  
  if (statusCache.has(cacheKey)) {
    return statusCache.get(cacheKey)!
  }
  
  const status = await getDynamicTravelStatus(userDocuments, destinationCountry)
  statusCache.set(cacheKey, status)
  return status
}
```

## Benefits After Migration

✅ **Real-time updates**: Change visa requirements without code deployment
✅ **Admin interface**: Non-technical staff can update requirements
✅ **Analytics**: Track usage patterns and popular destinations
✅ **Scalability**: Support for 200+ countries and complex rules
✅ **API integration**: Connect to government APIs for real-time data
✅ **Multi-passport support**: Easy to add support for UK, Canadian, etc. passports

## Rollback Plan

If issues arise, you can quickly rollback by:

1. **Revert imports** back to static functions
2. **Remove async/await** from function calls
3. **Database remains** for future use

The static system will continue to work as a fallback. 