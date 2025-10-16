# Quick Start Guide - Local Asset Version

## ✅ Ready to Run!

Your e-commerce app now uses **local assets** instead of Supabase database for products.
No database setup required!

## 🚀 Run the App

```bash
cd /home/akib/BLI-flutter-training/ecommerce
flutter run -d chrome
```

Or for Linux desktop:
```bash
flutter run -d linux
```

## 📦 What's Included

### Local Products (15 items across 5 categories):
- **Coffee** (3 items): Premium Coffee Beans, Arabica Ground Coffee, Espresso Roast
- **Jacket** (3 items): Winter Jacket, Leather Jacket, Sports Jacket  
- **Perfume** (3 items): Luxury Perfume, Classic Eau de Parfum, Fresh Cologne
- **Shampoo** (3 items): Moisturizing, Anti-Dandruff, Volumizing
- **Tissue** (3 items): Premium Box, Pocket Pack, Family Pack

### Features Working:
✅ User authentication (Supabase - signup/login/logout)
✅ Email & password validation with real-time warnings
✅ Search products with debounce (500ms delay)
✅ Filter by category (Coffee, Jacket, Perfume, Shampoo, Tissue)
✅ Filter by price range ($0 - $500)
✅ Combined filters (search + category + price)
✅ Product carousel slider
✅ Product cards with images
✅ Product detail page
✅ Light/Dark theme toggle
✅ Proper routing with back buttons

## 🧪 Test the App

1. **Create Account**:
   - Email: `test@example.com`
   - Password: `Test123` (uppercase, lowercase, numbers)

2. **Test Search**:
   - Try searching: "coffee", "jacket", "perfume"
   - Search is debounced (waits 500ms after you stop typing)

3. **Test Category Filter**:
   - Click on category chips: Coffee, Jacket, Perfume, Shampoo, Tissue
   - Click "All" to clear category filter

4. **Test Price Filter**:
   - Click "Price Range" button
   - Adjust the slider (min: $0, max: $500)
   - Click "Apply"

5. **Test Combined Filters**:
   - Select a category + adjust price range
   - Search + filter by category
   - All filters work together!

6. **Test Product Details**:
   - Click any product card
   - View full product information
   - Click back button to return to home

7. **Test Theme**:
   - Click moon/sun icon in app bar
   - Toggle between light and dark mode

## 📁 Local Assets Used

All product images are stored in the `asset/` folder:
- `coffee.jpg` - Used for all coffee products
- `jacket.jpg` - Used for all jacket products
- `perfume.jpg` - Used for all perfume products
- `shampoo.jpg` - Used for all shampoo products
- `tissue.jpg` - Used for all tissue products

## 🎯 Product Prices

Price range: $2.99 - $299.99
- Tissue products: $2.99 - $19.99
- Shampoo products: $12.99 - $15.99
- Coffee products: $18.99 - $29.99
- Perfume products: $64.99 - $129.99
- Jacket products: $89.99 - $299.99

## 🔧 Authentication Still Uses Supabase

- User signup/login/logout uses your Supabase project
- Credentials are stored in `.env` file
- Email confirmation may be enabled in your Supabase project

## �� Tips

- **No Database Setup Needed**: Products are hardcoded in `lib/services/product_service.dart`
- **Add More Products**: Edit `_mockProducts` list in `ProductService`
- **Add New Images**: Add to `asset/` folder and update `pubspec.yaml`
- **Change Categories**: Modify the product data in `product_service.dart`

## 🐛 Troubleshooting

### Images not showing?
- Run: `flutter pub get`
- Hot restart the app (press 'R' in terminal)

### Authentication issues?
- Check `.env` file exists with Supabase credentials
- Verify internet connection for auth

### Build issues?
- Run: `flutter clean && flutter pub get`
- Restart the app

## 🎉 Enjoy Your E-Commerce App!

Everything works locally now - no database setup required!
