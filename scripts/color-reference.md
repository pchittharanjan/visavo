# Visa Status Color Reference

## Current Color Scheme

| Visa Status | Hex Code | Color Name | Description |
|-------------|----------|------------|-------------|
| `visa_free` | `#10b981` | **Green** | No visa required - easiest travel |
| `eta_required` | `#f59e0b` | **Yellow** | Electronic Travel Authorization needed |
| `visa_on_arrival` | `#3b82f6` | **Blue** | Can get visa at airport/border |
| `evisa` | `#f59e0b` | **Yellow** | Electronic visa required before travel |
| `consulate_visa` | `#ef4444` | **Red** | Must visit embassy/consulate |
| `default` | `#6b7280` | **Gray** | Unknown status |

## Color Logic

- **🟢 Green** = Easiest (no visa needed)
- **🟡 Yellow** = Simple online process
- **🔵 Blue** = Moderate (get at airport)
- **🔴 Red** = Most complex (consulate visit required)
- **⚫ Gray** = Unknown/error state

## Database Storage

These colors are now stored in the `visa_status_types` table with a `color` column:

```sql
SELECT code, name, color FROM visa_status_types ORDER BY id;
```

## Usage in Code

### Old Way (Hardcoded):
```typescript
const getStatusColor = (status: string): string => {
  switch (status) {
    case 'visa_free': return '#10b981' // Green
    case 'eta_required': return '#f59e0b' // Yellow
    // ... more hardcoded values
  }
}
```

### New Way (Database):
```typescript
const getDynamicStatusColor = async (status: string): Promise<string> => {
  const statusType = await loadStatusType(status)
  return statusType?.color || '#6b7280' // Gray as default
}
```

## Benefits

1. **Centralized** - All colors in one place (database)
2. **Maintainable** - Change colors without touching code
3. **Consistent** - All components use same colors
4. **Flexible** - Easy to add new status types with colors 