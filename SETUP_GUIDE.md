# Quick Setup Guide

## Step 1: Set Up Supabase Database

1. **Open Supabase SQL Editor**
   - Go to: https://supabase.com/dashboard/project/qczskdexrlukonzimmks
   - Click on "SQL Editor" in the left sidebar

2. **Run the SQL Script**
   - Click "New Query"
   - Copy all contents from `supabase_setup.sql`
   - Paste into the SQL editor
   - Click "Run" or press Ctrl+Enter

3. **Verify Setup**
   - Go to "Table Editor" in the left sidebar
   - You should see a `products` table with 20 sample products

## Step 2: Run the App

```bash
# Run on Chrome (recommended for development)
flutter run -d chrome

# Or run on other platforms
flutter run -d linux
flutter run -d android
flutter run -d ios
```

## Step 3: Test the App

### Create an Account:
1. Click "Sign Up"
2. Enter a valid email (e.g., test@example.com)
3. Create a strong password (min 6 chars, uppercase, lowercase, numbers)
   - Example: `Test123`
4. Sign up and check for verification email (if enabled)

### Test Features:
- ✅ Login with your credentials
- ✅ Browse products on home screen
- ✅ Search for products (try typing "iPhone")
- ✅ Filter by category (Electronics, Fashion, Home, Sports)
- ✅ Filter by price range using the slider
- ✅ Click on a product to view details
- ✅ Toggle light/dark theme
- ✅ Test forgot password flow
- ✅ Logout

## Troubleshooting

### "Failed to load products"
- Make sure you ran the SQL script in Supabase
- Check internet connection
- Verify `.env` file exists with correct credentials

### Authentication Issues
- Check Supabase authentication settings
- Verify email confirmation is disabled for testing (or check spam folder)
- Go to: Authentication → Settings → Email Auth

### Images Not Loading
- Images are loaded from Unsplash CDN
- Check internet connection
- Try refreshing the page

## Database Structure

Your products table has these fields:
- `id` - Unique identifier (UUID)
- `name` - Product name
- `company` - Brand/manufacturer
- `image_url` - Product image URL
- `price` - Product price (numeric)
- `category` - Product category
- `description` - Product description (optional)
- `created_at` - Timestamp

## Sample Data Included

20 products across 4 categories:
- **Electronics**: iPhone, MacBook, Samsung phones, headphones, etc.
- **Fashion**: Nike shoes, Levi's jeans, Ray-Ban sunglasses, etc.
- **Home**: Kitchen appliances, Dyson vacuum, smart bulbs, etc.
- **Sports**: Yoga mats, dumbbells, treadmill, bikes, etc.

## Next Steps

Once the app is running, you can:
1. Add more products via Supabase dashboard
2. Customize the theme colors in `main.dart`
3. Add more categories
4. Implement shopping cart (future feature)
5. Add user favorites/wishlist
