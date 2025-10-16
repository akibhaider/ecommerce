-- Create products table
CREATE TABLE IF NOT EXISTS products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  company TEXT NOT NULL,
  image_url TEXT NOT NULL,
  price NUMERIC(10, 2) NOT NULL,
  category TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Enable Row Level Security
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Create policy to allow anyone to read products
CREATE POLICY "Allow public read access" ON products
  FOR SELECT
  USING (true);

-- Create policy to allow authenticated users to insert products (optional)
CREATE POLICY "Allow authenticated insert" ON products
  FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- Create indexes for better performance
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_products_name ON products(name);

-- Insert sample data
INSERT INTO products (name, company, image_url, price, category, description) VALUES
('iPhone 15 Pro', 'Apple', 'https://images.unsplash.com/photo-1696446702183-cbd50c6e8837?w=800', 999.99, 'Electronics', 'Latest iPhone with A17 Pro chip and titanium design'),
('MacBook Pro 16"', 'Apple', 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800', 2499.99, 'Electronics', 'Powerful laptop with M3 Max chip'),
('AirPods Pro', 'Apple', 'https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=800', 249.99, 'Electronics', 'Active noise cancellation wireless earbuds'),
('Samsung Galaxy S24', 'Samsung', 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=800', 899.99, 'Electronics', 'Latest Samsung flagship with AI features'),
('Sony WH-1000XM5', 'Sony', 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=800', 399.99, 'Electronics', 'Industry-leading noise canceling headphones'),
('Nike Air Max', 'Nike', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800', 150.00, 'Fashion', 'Comfortable and stylish running shoes'),
('Adidas Ultraboost', 'Adidas', 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=800', 180.00, 'Fashion', 'Premium running shoes with Boost technology'),
('Levi''s 501 Jeans', 'Levi''s', 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=800', 89.99, 'Fashion', 'Classic straight fit denim jeans'),
('North Face Jacket', 'The North Face', 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800', 299.99, 'Fashion', 'Waterproof outdoor jacket for all weather'),
('Ray-Ban Aviator', 'Ray-Ban', 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800', 154.99, 'Fashion', 'Iconic aviator sunglasses with UV protection'),
('Instant Pot Duo', 'Instant Pot', 'https://images.unsplash.com/photo-1585515320310-259814833e62?w=800', 99.99, 'Home', '7-in-1 multi-cooker for quick meals'),
('Dyson V15', 'Dyson', 'https://images.unsplash.com/photo-1558317374-067fb5f30001?w=800', 649.99, 'Home', 'Powerful cordless vacuum with laser detection'),
('Nespresso Machine', 'Nespresso', 'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=800', 199.99, 'Home', 'Premium coffee machine for espresso lovers'),
('KitchenAid Mixer', 'KitchenAid', 'https://images.unsplash.com/photo-1578269174936-2709b6aeb913?w=800', 379.99, 'Home', 'Professional stand mixer for baking'),
('Smart LED Bulbs', 'Philips Hue', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800', 49.99, 'Home', 'Color changing smart bulbs with app control'),
('Yoga Mat Premium', 'Manduka', 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=800', 120.00, 'Sports', 'High-quality non-slip yoga mat'),
('Dumbbells Set', 'Bowflex', 'https://images.unsplash.com/photo-1638805981949-4e0c4c45b071?w=800', 349.99, 'Sports', 'Adjustable dumbbells for home gym'),
('Treadmill Pro', 'NordicTrack', 'https://images.unsplash.com/photo-1538805060514-97d9cc17730c?w=800', 1299.99, 'Sports', 'Professional treadmill with interactive training'),
('Tennis Racket', 'Wilson', 'https://images.unsplash.com/photo-1617083279008-ac0b61afcb5c?w=800', 189.99, 'Sports', 'Professional tennis racket for advanced players'),
('Mountain Bike', 'Trek', 'https://images.unsplash.com/photo-1576435728678-68d0fbf94e91?w=800', 899.99, 'Sports', 'Durable mountain bike for off-road adventures');
