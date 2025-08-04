# 🎯 **15-PASSPORT COMPLETE DATABASE SETUP**

## **📋 What You're Getting**

**15 Passport Types** with comprehensive visa requirements for **15 destination countries**:

### **Group 1: US, Canada, Mexico, UK, Australia** 🇺🇸🇨🇦🇲🇽🇬🇧🇦🇺
### **Group 2: Germany, France, Italy, Russia, Brazil** 🇩🇪🇫🇷🇮🇹🇷🇺🇧🇷  
### **Group 3: Japan, South Korea, India, China, Saudi Arabia** 🇯🇵🇰🇷🇮🇳🇨🇳🇸🇦

**Total**: 15 passports × 15 destinations = **225 visa requirement records**

## 🚀 **STEP-BY-STEP INSTRUCTIONS**

### **Step 1: Open Supabase Dashboard**

1. **Open your web browser**
2. **Go to**: `https://supabase.com`
3. **Sign in** to your account
4. **Click on your Visavo project**
5. **Click "SQL Editor"** in the left sidebar

### **Step 2: Run Script 1 (Group 1)**

1. **Open file**: `scripts/group1-passports.sql`
2. **Copy ALL content** (Ctrl+A, Ctrl+C)
3. **In Supabase SQL Editor**:
   - Click **"New Query"**
   - **Paste the content** (Ctrl+V)
   - **Click "Run"**
4. **Wait for success message**

### **Step 3: Run Script 2 (Group 2)**

1. **Open file**: `scripts/group2-passports.sql`
2. **Copy ALL content** (Ctrl+A, Ctrl+C)
3. **In Supabase SQL Editor**:
   - Click **"New Query"**
   - **Paste the content** (Ctrl+V)
   - **Click "Run"**
4. **Wait for success message**

### **Step 4: Run Script 3 (Group 3)**

1. **Open file**: `scripts/group3-passports.sql`
2. **Copy ALL content** (Ctrl+A, Ctrl+C)
3. **In Supabase SQL Editor**:
   - Click **"New Query"**
   - **Paste the content** (Ctrl+V)
   - **Click "Run"**
4. **Wait for success message**

### **Step 5: Verify Setup**

Run this query in Supabase to verify all 15 passport types:

```sql
SELECT DISTINCT passport_country FROM visa_requirements ORDER BY passport_country;
```

**Expected result**: You should see all 15 countries listed.

### **Step 6: Check Total Records**

```sql
SELECT COUNT(*) FROM visa_requirements;
```

**Expected result**: Around 225 records (15 passports × 15 destinations)

## 🧪 **TESTING YOUR APPLICATION**

### **Step 1: Start Your App**

```bash
npm run dev
```

### **Step 2: Test Different Scenarios**

**Scenario 1: Your Case (India + US Green Card + Australia PR)**
1. Go to `http://localhost:3000/onboarding`
2. Add: India Passport, US Green Card, Australia PR Card
3. Go to dashboard and test:
   - 🇺🇸 **US**: Should show "Visa Free" (Green Card holder)
   - 🇦🇺 **Australia**: Should show "Visa Free" (PR holder)
   - 🇮🇳 **India**: Should show "Visa Free" (citizen)
   - 🇨🇦 **Canada**: Should show "Visa Free" (Green Card holder)

**Scenario 2: US Passport Only**
1. Add only: US Passport
2. Test:
   - 🇺🇸 **US**: Should show "Visa Free" (citizen)
   - 🇬🇧 **UK**: Should show "Visa Free"
   - 🇯🇵 **Japan**: Should show "Visa Free"
   - 🇨🇳 **China**: Should show "Consulate Visa Required"

**Scenario 3: Indian Passport Only**
1. Add only: India Passport
2. Test:
   - 🇮🇳 **India**: Should show "Visa Free" (citizen)
   - 🇺🇸 **US**: Should show "Consulate Visa Required"
   - 🇬🇧 **UK**: Should show "Consulate Visa Required"
   - 🇸🇦 **Saudi Arabia**: Should show "eVisa Required"

**Scenario 4: Russian Passport Only**
1. Add only: Russia Passport
2. Test:
   - 🇷🇺 **Russia**: Should show "Visa Free" (citizen)
   - 🇺🇸 **US**: Should show "Consulate Visa Required"
   - 🇬🇧 **UK**: Should show "Consulate Visa Required"
   - 🇯🇵 **Japan**: Should show "Consulate Visa Required"

## ✅ **Success Indicators**

You'll know it's working when:

- ✅ **All 15 passport types** appear in the database
- ✅ **225+ visa requirement records** total
- ✅ **Dashboard loads** without errors
- ✅ **Interactive map shows** all countries
- ✅ **Clicking countries** shows accurate visa status
- ✅ **Your specific case** (India + US Green Card + Australia PR) works correctly
- ✅ **Different passport combinations** show different results

## 🎯 **Expected Results by Passport Type**

| Passport | US | UK | Japan | China | India | Australia |
|----------|----|----|----|----|----|----|
| **US** | ✅ Free | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **UK** | ✅ ETA | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **Canada** | ✅ ETA | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **Mexico** | ❌ Consulate | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **Australia** | ✅ ETA | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ Free |
| **Germany** | ✅ ETA | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **France** | ✅ ETA | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **Italy** | ✅ ETA | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **Russia** | ❌ Consulate | ❌ Consulate | ❌ Consulate | ❌ Consulate | ✅ eVisa | ❌ Consulate |
| **Brazil** | ✅ ETA | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **Japan** | ✅ ETA | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **South Korea** | ✅ ETA | ✅ Free | ✅ Free | ❌ Consulate | ✅ eVisa | ✅ ETA |
| **India** | ❌ Consulate | ❌ Consulate | ❌ Consulate | ❌ Consulate | ✅ Free | ❌ Consulate |
| **China** | ❌ Consulate | ❌ Consulate | ❌ Consulate | ❌ Consulate | ❌ Consulate | ❌ Consulate |
| **Saudi Arabia** | ❌ Consulate | ❌ Consulate | ❌ Consulate | ❌ Consulate | ✅ eVisa | ❌ Consulate |

## 🚨 **Troubleshooting**

**If you see errors:**
1. **Check file content** - make sure you copied the entire script
2. **Check Supabase connection** - verify your credentials
3. **Check for syntax errors** - look for any red error messages
4. **Restart your app** - `npm run dev`

**If you see wrong results:**
1. **Check your documents** - make sure you added the right passport types
2. **Check database** - verify all 15 passport types are in the database
3. **Clear browser cache** - refresh the page

## 🎉 **You're Done!**

After running all 3 scripts, you'll have the most comprehensive visa requirements database covering all 15 major passport types with accurate visa statuses, fees, and processing times!

**Your app will now handle any combination of passports, Green Cards, and PR cards correctly!** 🚀 