import '../models/product.dart';

class ProductService {
  // Mock data with local assets
  final List<Product> _mockProducts = [
    Product(
      id: '1',
      name: 'Premium Coffee Beans',
      company: 'Coffee Co.',
      imageUrl: 'asset/coffee.jpg',
      price: 19.99,
      oldPrice: 24.99, // Added discount
      category: 'Coffee',
      description: 'Rich and aromatic premium coffee beans from the finest plantations',
    ),
    Product(
      id: '2',
      name: 'Arabica Ground Coffee',
      company: 'Coffee Co.',
      imageUrl: 'asset/coffee.jpg',
      price: 18.99,
      category: 'Coffee',
      description: 'Freshly ground arabica coffee with smooth flavor',
    ),
    Product(
      id: '3',
      name: 'Espresso Roast',
      company: 'Coffee Co.',
      imageUrl: 'asset/coffee.jpg',
      price: 29.99,
      category: 'Coffee',
      description: 'Dark roasted espresso beans for the perfect shot',
    ),
    Product(
      id: '4',
      name: 'Winter Jacket',
      company: 'Fashion Brand',
      imageUrl: 'asset/jacket.jpg',
      price: 149.99,
      category: 'Jacket',
      description: 'Warm and stylish winter jacket with water-resistant material',
    ),
    Product(
      id: '5',
      name: 'Leather Jacket',
      company: 'Fashion Brand',
      imageUrl: 'asset/jacket.jpg',
      price: 249.99,
      oldPrice: 299.99, // Added discount
      category: 'Jacket',
      description: 'Premium leather jacket with classic design',
    ),
    Product(
      id: '6',
      name: 'Sports Jacket',
      company: 'Fashion Brand',
      imageUrl: 'asset/jacket.jpg',
      price: 89.99,
      category: 'Jacket',
      description: 'Lightweight sports jacket perfect for outdoor activities',
    ),
    Product(
      id: '7',
      name: 'Luxury Perfume',
      company: 'Fragrance House',
      imageUrl: 'asset/perfume.jpg',
      price: 89.99,
      category: 'Perfume',
      description: 'Elegant and long-lasting luxury perfume with floral notes',
    ),
    Product(
      id: '8',
      name: 'Classic Eau de Parfum',
      company: 'Fragrance House',
      imageUrl: 'asset/perfume.jpg',
      price: 99.99,
      oldPrice: 129.99, // Added discount
      category: 'Perfume',
      description: 'Timeless fragrance with woody and spicy undertones',
    ),
    Product(
      id: '9',
      name: 'Fresh Cologne',
      company: 'Fragrance House',
      imageUrl: 'asset/perfume.jpg',
      price: 64.99,
      category: 'Perfume',
      description: 'Light and refreshing cologne for everyday wear',
    ),
    Product(
      id: '10',
      name: 'Moisturizing Shampoo',
      company: 'Beauty Care',
      imageUrl: 'asset/shampoo.jpg',
      price: 12.99,
      category: 'Shampoo',
      description: 'Deep moisturizing shampoo for dry and damaged hair',
    ),
    Product(
      id: '11',
      name: 'Anti-Dandruff Shampoo',
      company: 'Beauty Care',
      imageUrl: 'asset/shampoo.jpg',
      price: 15.99,
      category: 'Shampoo',
      description: 'Effective anti-dandruff formula for healthy scalp',
    ),
    Product(
      id: '12',
      name: 'Volumizing Shampoo',
      company: 'Beauty Care',
      imageUrl: 'asset/shampoo.jpg',
      price: 14.99,
      category: 'Shampoo',
      description: 'Adds volume and body to fine and limp hair',
    ),
    Product(
      id: '13',
      name: 'Premium Tissue Box',
      company: 'Home Essentials',
      imageUrl: 'asset/tissue.jpg',
      price: 4.99,
      category: 'Tissue',
      description: 'Soft and strong 3-ply tissues for everyday use',
    ),
    Product(
      id: '14',
      name: 'Pocket Tissue Pack',
      company: 'Home Essentials',
      imageUrl: 'asset/tissue.jpg',
      price: 2.99,
      category: 'Tissue',
      description: 'Convenient pocket-sized tissue pack for on-the-go',
    ),
    Product(
      id: '15',
      name: 'Family Pack Tissues',
      company: 'Home Essentials',
      imageUrl: 'asset/tissue.jpg',
      price: 19.99,
      category: 'Tissue',
      description: 'Economy family pack with 12 boxes of soft tissues',
    ),
  ];

  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockProducts;
  }

  Future<List<Product>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.company.toLowerCase().contains(query.toLowerCase()) ||
            product.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Product>> filterByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts
        .where((product) => product.category == category)
        .toList();
  }

  Future<List<Product>> filterByPriceRange(double minPrice, double maxPrice) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts
        .where((product) => product.price >= minPrice && product.price <= maxPrice)
        .toList();
  }

  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts
        .map((product) => product.category)
        .toSet()
        .toList()
      ..sort();
  }

  Future<Product> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts.firstWhere(
      (product) => product.id == id,
      orElse: () => throw Exception('Product not found'),
    );
  }

  Future<List<Product>> getDiscountProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts.where((product) => product.hasDiscount).toList();
  }
}
