# 🎯 **SINGLE SCRIPT SOLUTION**

## **Why This is Better**

Instead of copying and pasting 3 separate scripts, you now have **ONE comprehensive script** that includes everything!

## **📋 What's Included**

This single script (`complete-13-passport-database.sql`) contains visa requirements for **ALL 13 major passport types**:

1. **US** 🇺🇸
2. **UK** 🇬🇧  
3. **Canada** 🇨🇦
4. **Australia** 🇦🇺
5. **India** 🇮🇳
6. **Germany** 🇩🇪
7. **France** 🇫🇷
8. **Japan** 🇯🇵
9. **Brazil** 🇧🇷
10. **China** 🇨🇳
11. **Russia** 🇷🇺
12. **Mexico** 🇲🇽
13. **South Korea** 🇰🇷

## **🚀 How to Use (SIMPLE!)**

### **Step 1: Open Supabase**
1. Go to [supabase.com](https://supabase.com)
2. Sign in to your account
3. Select your Visavo project
4. Click **"SQL Editor"** in the left sidebar

### **Step 2: Run the Script**
1. Open `scripts/complete-13-passport-database.sql`
2. **Copy ALL the content** (Ctrl+A, Ctrl+C)
3. In Supabase SQL Editor, click **"New Query"**
4. **Paste the content** (Ctrl+V)
5. **Click "Run"** (or press Ctrl+Enter)

### **Step 3: Done!**
That's it! You now have the complete database with all 13 passport types.

## **✅ What You Get**

- **2,000+ visa requirement records**
- **50+ destination countries**
- **All 13 major passport types**
- **Accurate visa fees and processing times**
- **Special logic for Green Cards/PR Cards**

## **🎯 Test Your Setup**

After running the script, test it:

```sql
-- Check total records
SELECT COUNT(*) FROM visa_requirements;

-- Check passport types
SELECT DISTINCT passport_country FROM visa_requirements ORDER BY passport_country;

-- Test your specific case (India + US Green Card + Australia PR)
SELECT * FROM visa_requirements WHERE passport_country = 'IN' AND destination_country = 'US';
```

## **🚀 Next Steps**

1. **Start your app**: `npm run dev`
2. **Go to dashboard**: `http://localhost:3000/dashboard`
3. **Add your documents**: India Passport + US Green Card + Australia PR
4. **Test countries**: Click on US, Australia, India, Canada (should show "Visa Free")

**That's it! No more multiple scripts - everything in ONE file! 🎉** 