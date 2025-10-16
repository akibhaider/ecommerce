class Product {
  final String id;
  final String name;
  final String company;
  final String imageUrl;
  final double price;
  final double? oldPrice; // Added for discount pricing
  final String category;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.company,
    required this.imageUrl,
    required this.price,
    this.oldPrice, // Added
    required this.category,
    this.description,
  });

  // Calculate discount percentage
  int? get discountPercentage {
    if (oldPrice == null || oldPrice! <= price) return null;
    return (((oldPrice! - price) / oldPrice!) * 100).round();
  }

  // Check if product has discount
  bool get hasDiscount => oldPrice != null && oldPrice! > price;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      company: json['company'] ?? '',
      imageUrl: json['image_url'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      oldPrice: json['old_price'] != null ? (json['old_price'] as num).toDouble() : null,
      category: json['category'] ?? '',
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'company': company,
      'image_url': imageUrl,
      'price': price,
      'old_price': oldPrice,
      'category': category,
      'description': description,
    };
  }
}
