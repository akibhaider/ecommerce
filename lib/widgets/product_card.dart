import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInCart = ref.watch(cartProvider.notifier).isInCart(product.id);
    final isLiked = ref.watch(likedProductsProvider.notifier).isLiked(product.id);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.push('/product/${product.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E32) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with badges
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: 'product-${product.id}',
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),
                  
                  // Discount Badge
                  if (product.hasDiscount)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6584), Color(0xFFFF8BA7)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF6584).withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          '${product.discountPercentage}% OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  
                  // Action buttons
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ref.read(likedProductsProvider.notifier).toggleLike(product);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              isLiked ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                              color: isLiked ? const Color(0xFFFF6584) : Colors.grey[700],
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            ref.read(cartProvider.notifier).addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Added to cart'),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: isInCart
                                  ? const LinearGradient(
                                      colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                                    )
                                  : null,
                              color: isInCart ? null : Colors.white.withOpacity(0.95),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              isInCart ? Icons.shopping_cart_rounded : Icons.shopping_cart_outlined,
                              color: isInCart ? Colors.white : Colors.grey[700],
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Product Info
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      product.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF6C63FF),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  Text(
                    product.company,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  
                  // Price section
                  if (product.hasDiscount) ...[
                    Row(
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            '\$${product.oldPrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: isDark ? Colors.grey[500] : Colors.grey[400],
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: isDark ? Colors.grey[500] : Colors.grey[400],
                              decorationThickness: 2,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isDark ? const Color(0xFF8B85FF) : const Color(0xFF6C63FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
