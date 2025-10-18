# E-Commerce Flutter App

A full-featured e-commerce mobile application built with Flutter, Supabase, and Riverpod.

## Features

✅ **Authentication**
- User signup with email validation
- Strong password validation (min 6 chars, uppercase, lowercase, numbers)
- Login with email/password
- Password reset via email
- Real-time validation warnings

✅ **Product Management**
- Product listing with card-based UI
- Carousel slider for featured products
- Product detail page with full information
- Categories for each product
- Search functionality with debounce
- Price range filtering
- Category-based filtering

✅ **State Management & Routing**
- Flutter Riverpod for state management
- GoRouter for dynamic routing
- Proper back button handling
- Route guards for authentication

## System Interaction

<table align="center">
  <tr>
    <td align="center">
      <img src="ui/1 login screen.png" alt="Home Page" width="150"/><br/>
      <em>Login Screen</em>
    </td>
    <td align="center">
      <img src="ui/2 splash screen.png" alt="Feature Dashboard" width="150"/><br/>
      <em>App Splash Screen with Rive Animation</em>
    </td>
    <td align="center">
      <img src="ui/3 product filtering price and category wise.png" alt="Academic Updates and Schedules" width="150"/><br/>
      <em>Category and Pricewise Product Filtering</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="ui/4 Discount section.png" alt="Internet Usage Tracker" width="150"/><br/>
      <em>Discount and Featured Products</em>
    </td>
    <td align="center">
      <img src="ui/5 Dynamic product search with debounce.png" alt="E-Library and Question Bank" width="150"/><br/>
      <em>On-Change Product Search with Debounce</em>
    </td>
    <td align="center">
      <img src="ui/6 Liked product.png" alt="Semester wise Course Results" width="150"/><br/>
      <em>Liked Products</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="ui/7 Product details.png" alt="E-Banking with AB-Direct" width="150"/><br/>
      <em>Product Details</em>
    </td>
    <td align="center">
      <img src="ui/8 Shopping cart.png" alt="Smart Wallet" width="150"/><br/>
      <em>Shopping Cart</em>
    </td>
    <td align="center">
      <img src="ui/9 order confirmation and billing.png" alt="Iut Bus Service Tracker" width="150"/><br/>
      <em>Billing and Order Confirmation</em>
    </td>
  </tr>
</table>


## Setup Instructions

### 1. Install Dependencies

The dependencies are already installed. If you need to reinstall:

```bash
flutter pub get
```

### 2. Set Up Supabase Database

1. Go to your Supabase project dashboard: https://qczskdexrlukonzimmks.supabase.co
2. Navigate to the SQL Editor
3. Copy and paste the contents of `supabase_setup.sql`
4. Run the SQL script to create the products table and insert sample data

The script will:
- Create a `products` table with proper structure
- Enable Row Level Security (RLS)
- Add policies for public read access
- Create indexes for better performance
- Insert 20 sample products across different categories

### 3. Environment Variables

The `.env` file is already created with your Supabase credentials:
- SUPABASE_URL
- SUPABASE_ANON_KEY

**Important:** Never commit the `.env` file to version control!

### 4. Run the App

```bash
flutter run
```

Or for a specific device:
```bash
flutter run -d chrome  # For web
flutter run -d linux   # For Linux desktop
```

## Project Structure

```
lib/
├── config/
│   └── supabase_config.dart      # Supabase configuration
├── models/
│   └── product.dart               # Product model
├── providers/
│   ├── auth_provider.dart         # Authentication state providers
│   ├── product_provider.dart      # Product state providers
│   └── theme_provider.dart        # Theme state provider
├── routes/
│   └── app_router.dart            # GoRouter configuration
├── screens/
│   ├── login_screen.dart          # Login page
│   ├── signup_screen.dart         # Signup page
│   ├── forgot_password_screen.dart # Password reset page
│   ├── home_screen.dart           # Main product listing
│   └── product_detail_screen.dart # Product details
├── services/
│   ├── auth_service.dart          # Authentication logic
│   └── product_service.dart       # Product CRUD operations
├── widgets/
│   ├── product_card.dart          # Product card widget
│   └── category_chip.dart         # Category filter chip
└── main.dart                      # App entry point
```

## Key Features Explained

### Authentication Flow
1. Users start at the login screen
2. Can navigate to signup or forgot password
3. Signup validates email format and password strength in real-time
4. After successful login, redirected to home screen
5. Route guards prevent unauthorized access

### Product Features
- **Search**: Type in the search bar, results update after 500ms (debounced)
- **Category Filter**: Click category chips to filter products
- **Price Filter**: Use the price range slider to filter by price
- **Product Details**: Click any product card to view full details

### State Management
- Riverpod providers manage all state
- Automatic cache invalidation
- Reactive UI updates
- Efficient rebuilds

## Database Schema

### Products Table
```sql
- id (UUID, Primary Key)
- name (TEXT)
- company (TEXT)
- image_url (TEXT)
- price (NUMERIC)
- category (TEXT)
- description (TEXT)
- created_at (TIMESTAMP)
```

## Troubleshooting

### Issue: "Failed to load products"
- Check your internet connection
- Verify Supabase credentials in `.env`
- Ensure the products table is created in Supabase

### Issue: "Authentication failed"
- Verify email confirmation (check spam folder)
- Check Supabase authentication settings
- Ensure email provider is configured in Supabase

### Issue: Images not loading
- Check internet connection
- Verify image URLs in the database
- Some free image hosting services may have rate limits

## Testing the App

### Test User Flow:
1. Start the app → Login screen appears
2. Click "Sign Up" → Create account with valid email/password
3. Check email for verification link (if email confirmation is enabled)
4. Login with credentials
5. Browse products on home screen
6. Use search, filters, and categories
7. Click a product to view details
8. Toggle light/dark theme
9. Logout and verify redirect to login

## Technologies Used

- **Flutter 3.9.2+**
- **Riverpod 2.6.1** - State management
- **GoRouter 14.8.1** - Routing
- **Supabase Flutter 2.5.6** - Backend & Auth
- **Carousel Slider 5.0.0** - Image carousel
- **Flutter DotEnv 5.2.1** - Environment variables

## Next Steps / Future Enhancements

- Add shopping cart functionality
- Implement user favorites/wishlist
- Add product reviews and ratings
- Implement order history
- Add payment integration
- Multiple product images
- User profile management
- Admin panel for product management

## License

This project is for educational purposes.
