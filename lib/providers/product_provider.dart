import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../services/product_service.dart';

final productServiceProvider = Provider<ProductService>((ref) => ProductService());

final productsProvider = FutureProvider<List<Product>>((ref) async {
  return ref.watch(productServiceProvider).getProducts();
});

final discountProductsProvider = FutureProvider<List<Product>>((ref) async {
  return ref.watch(productServiceProvider).getDiscountProducts();
});

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  return ref.watch(productServiceProvider).getCategories();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final showOnlyDiscountsProvider = StateProvider<bool>((ref) => false);

final priceRangeProvider = StateProvider<(double, double)?>((ref) => null);

final filteredProductsProvider = FutureProvider<List<Product>>((ref) async {
  final productService = ref.watch(productServiceProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final showOnlyDiscounts = ref.watch(showOnlyDiscountsProvider);
  final priceRange = ref.watch(priceRangeProvider);

  List<Product> products;

  // Apply filters based on priority
  if (showOnlyDiscounts) {
    // Show only discount products
    products = await productService.getDiscountProducts();
  } else if (searchQuery.isNotEmpty) {
    products = await productService.searchProducts(searchQuery);
  } else if (selectedCategory != null && selectedCategory.isNotEmpty) {
    products = await productService.filterByCategory(selectedCategory);
  } else if (priceRange != null) {
    products = await productService.filterByPriceRange(priceRange.$1, priceRange.$2);
  } else {
    products = await productService.getProducts();
  }

  // Apply additional filters
  if (selectedCategory != null && selectedCategory.isNotEmpty && searchQuery.isNotEmpty) {
    products = products.where((p) => p.category == selectedCategory).toList();
  }

  if (priceRange != null && !showOnlyDiscounts) {
    products = products.where((p) => 
      p.price >= priceRange.$1 && p.price <= priceRange.$2
    ).toList();
  }

  return products;
});

final productDetailProvider = FutureProvider.family<Product, String>((ref, id) async {
  return ref.watch(productServiceProvider).getProductById(id);
});
