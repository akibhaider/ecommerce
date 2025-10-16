import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../providers/auth_provider.dart';
import '../providers/product_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  double _minPrice = 0;
  double _maxPrice = 500;
  bool _showPriceFilter = false;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchQueryProvider.notifier).state = query;
    });
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _minPrice = 0;
      _maxPrice = 500;
      _showPriceFilter = false;
    });
    ref.read(searchQueryProvider.notifier).state = '';
    ref.read(selectedCategoryProvider.notifier).state = null;
    ref.read(showOnlyDiscountsProvider.notifier).state = false;
    ref.read(priceRangeProvider.notifier).state = null;
  }

  void _applyPriceFilter() {
    ref.read(priceRangeProvider.notifier).state = (_minPrice, _maxPrice);
    setState(() => _showPriceFilter = false);
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(filteredProductsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final discountProductsAsync = ref.watch(discountProductsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final showOnlyDiscounts = ref.watch(showOnlyDiscountsProvider);
    final themeMode = ref.watch(themeModeProvider);
    final cartItemCount = ref.watch(cartProvider.notifier).itemCount;
    final likedItemCount = ref.watch(likedProductsProvider).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authServiceProvider).signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          // Categories with Discount Filter
          categoriesAsync.when(
            data: (categories) {
              return Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryChip(
                      label: 'All',
                      isSelected: selectedCategory == null && !showOnlyDiscounts,
                      onTap: () {
                        ref.read(selectedCategoryProvider.notifier).state = null;
                        ref.read(showOnlyDiscountsProvider.notifier).state = false;
                      },
                    ),
                    // Special Discount Category
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_offer, 
                              size: 16, 
                              color: showOnlyDiscounts ? Colors.white : Colors.red.shade700,
                            ),
                            const SizedBox(width: 4),
                            const Text('Discounts'),
                          ],
                        ),
                        selected: showOnlyDiscounts,
                        onSelected: (_) {
                          ref.read(showOnlyDiscountsProvider.notifier).state = !showOnlyDiscounts;
                          ref.read(selectedCategoryProvider.notifier).state = null;
                        },
                        backgroundColor: Colors.red.shade50,
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: showOnlyDiscounts ? Colors.white : Colors.red.shade700,
                          fontWeight: showOnlyDiscounts ? FontWeight.bold : FontWeight.w600,
                        ),
                        checkmarkColor: Colors.white,
                        side: BorderSide(
                          color: showOnlyDiscounts ? Colors.red : Colors.red.shade300,
                        ),
                      ),
                    ),
                    ...categories.map((category) => CategoryChip(
                          label: category,
                          isSelected: selectedCategory == category,
                          onTap: () {
                            ref.read(selectedCategoryProvider.notifier).state = category;
                            ref.read(showOnlyDiscountsProvider.notifier).state = false;
                          },
                        )),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Filter Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() => _showPriceFilter = !_showPriceFilter);
                    },
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Price Range'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _clearFilters,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
          ),

          // Price Range Filter
          if (_showPriceFilter)
            Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Min: \$${_minPrice.toStringAsFixed(0)}'),
                      ),
                      Expanded(
                        child: Text(
                          'Max: \$${_maxPrice.toStringAsFixed(0)}',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 0,
                    max: 500,
                    divisions: 100,
                    labels: RangeLabels(
                      '\$${_minPrice.toStringAsFixed(0)}',
                      '\$${_maxPrice.toStringAsFixed(0)}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: _applyPriceFilter,
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ),

          // Products List
          Expanded(
            child: productsAsync.when(
              data: (products) {
                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Featured carousel
                final featuredProducts = products.take(5).toList();

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(filteredProductsProvider);
                  },
                  child: ListView(
                    children: [
                      if (selectedCategory == null && _searchController.text.isEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Featured Products',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 200,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                autoPlayInterval: const Duration(seconds: 3),
                              ),
                              items: featuredProducts.map((product) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.push('/product/${product.id}');
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: AssetImage(product.imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.7),
                                              ],
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.name,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '\$${product.price.toStringAsFixed(2)}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'All Products',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
                        },
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline, 
                      size: 64, 
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: $error',
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(filteredProductsProvider);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            context.push('/cart');
          } else if (index == 2) {
            context.push('/liked');
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('$cartItemCount'),
              isLabelVisible: cartItemCount > 0,
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('$likedItemCount'),
              isLabelVisible: likedItemCount > 0,
              child: const Icon(Icons.favorite),
            ),
            label: 'Liked',
          ),
        ],
      ),
    );
  }
}
