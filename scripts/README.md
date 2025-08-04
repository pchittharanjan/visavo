# Complete Visa Requirements Database

This directory contains SQL scripts to set up a comprehensive visa requirements database for **ALL 13 major passport types**.

## 📋 Passport Types Covered

1. 🇺🇸 **US Passport** - Most powerful passport
2. 🇬🇧 **UK Passport** - Strong European passport
3. 🇨🇦 **Canadian Passport** - Strong North American passport
4. 🇦🇺 **Australian Passport** - Strong Oceania passport
5. 🇮🇳 **Indian Passport** - Your use case
6. 🇩🇪 **German Passport** - Strong EU passport
7. 🇫🇷 **French Passport** - Strong EU passport
8. 🇯🇵 **Japanese Passport** - Strong Asian passport
9. 🇧🇷 **Brazilian Passport** - Strong South American passport
10. 🇨🇳 **Chinese Passport** - Most populous country
11. 🇷🇺 **Russian Passport** - Large Eurasian country
12. 🇲🇽 **Mexican Passport** - Strong North American passport
13. 🇰🇷 **South Korean Passport** - Strong Asian passport

## 🚀 How to Use

### Step 1: Run the Main Script
```sql
-- Copy and paste the contents of scripts/final-complete-visa-database.sql
-- This sets up the first 4 passport types (US, UK, Canada, Australia)
```

### Step 2: Add Remaining Passport Types
```sql
-- Copy and paste the contents of scripts/remaining-passport-types.sql
-- This adds passport types 5-8 (India, Germany, France, Japan)
```

### Step 3: Add Final Passport Types
```sql
-- Copy and paste the contents of scripts/final-passport-types.sql
-- This adds passport types 9-13 (Brazil, China, Russia, Mexico, South Korea)
```

## 📊 What You Get

### ✅ **50+ Destination Countries** across all major regions:
- **North America**: US, Canada, Mexico
- **South America**: Brazil, Argentina, Chile, Colombia, Peru
- **Europe**: UK, Germany, France, Italy, Spain, Netherlands, Sweden, Norway, Denmark, Finland, Switzerland, Austria, Belgium, Ireland, Poland, Czech Republic, Hungary, Romania, Bulgaria, Croatia, Slovenia, Slovakia, Lithuania, Latvia, Estonia, Malta, Cyprus, Greece, Portugal, Luxembourg, Iceland, Ukraine
- **Asia Pacific**: Japan, South Korea, China, Singapore, Thailand, India, Vietnam, Myanmar, Cambodia, Laos, Bangladesh, Pakistan, Sri Lanka, Nepal, Maldives, Indonesia, Philippines, Malaysia
- **Middle East**: Israel, UAE, Saudi Arabia, Qatar, Kuwait, Bahrain, Oman, Jordan, Lebanon, Egypt, Turkey
- **Africa**: Morocco, South Africa
- **Oceania**: Australia, New Zealand

### ✅ **Smart Logic Features**:
- **Multiple Passport Support**: Uses the best passport for each destination
- **Green Card Recognition**: Permanent residents get visa-free access
- **Existing Visa Recognition**: Valid visas override requirements
- **Special Overrides**: Handles complex cases like OCI cards for India

### ✅ **Comprehensive Data**:
- **Visa Status**: visa_free, eta_required, visa_on_arrival, evisa, reciprocity_fee, consulate_visa
- **Stay Duration**: Number of days allowed
- **Visa Fees**: Amount and currency
- **Processing Time**: How long applications take
- **Notes**: Specific requirements and tips

## 🎯 Perfect for Your Use Case

**India Passport + US Green Card + Australia PR** will get:
- 🇺🇸 **US**: Visa-free (Green Card holder)
- 🇦🇺 **Australia**: Visa-free (PR holder)
- 🇮🇳 **India**: Visa-free (citizen)
- 🇨🇦 **Canada**: Visa-free (Green Card holder)
- 🇲🇽 **Mexico**: Visa-free (Green Card holder)
- 🇬🇧 **UK**: Consulate visa required
- 🇩🇪 **Germany**: Consulate visa required
- 🇯🇵 **Japan**: Consulate visa required
- And many more...

## 🔧 Database Schema

The scripts create/update these tables:
- `countries` - List of all countries with flags
- `visa_requirements` - Main visa requirements data
- `special_overrides` - Special cases like OCI cards
- `country_requirements` - Detailed requirements per country

## 🚀 Next Steps

1. **Go to Supabase Dashboard** → **SQL Editor**
2. **Run all 3 scripts in order**
3. **Test at**: `http://localhost:3000/dashboard`
4. **Enjoy your comprehensive visa database!**

## 📈 Performance

- **Batch Loading**: All country statuses load in one query
- **Smart Caching**: Results cached for better performance
- **Optimized Queries**: Efficient database queries
- **Real-time Updates**: Changes reflect immediately

---

**🎉 You now have the most comprehensive visa requirements database covering all major passport types!** 