import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalAmount = ref.read(cartProvider.notifier).totalAmount;
    final themeMode = ref.watch(themeModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF252540), const Color(0xFF1E1E32)]
                            : [const Color(0xFFF8F9FE), Colors.white],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: isDark ? const Color(0xFF8B85FF) : const Color(0xFF6C63FF),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your cart is empty',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add products to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => context.go('/home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Start Shopping',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
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
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Product Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  cartItem.product.imageUrl,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              
                              // Product Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      cartItem.product.company,
                                      style: TextStyle(
                                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '\$${cartItem.product.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: isDark ? const Color(0xFF8B85FF) : const Color(0xFF6C63FF),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Quantity Controls
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF252540) : const Color(0xFFF8F9FE),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_rounded),
                                          iconSize: 20,
                                          onPressed: () {
                                            ref.read(cartProvider.notifier).updateQuantity(
                                                  cartItem.product.id,
                                                  cartItem.quantity - 1,
                                                );
                                          },
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '${cartItem.quantity}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add_rounded),
                                          iconSize: 20,
                                          onPressed: () {
                                            ref.read(cartProvider.notifier).updateQuantity(
                                                  cartItem.product.id,
                                                  cartItem.quantity + 1,
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  IconButton(
                                    icon: const Icon(Icons.delete_rounded),
                                    color: const Color(0xFFFF6584),
                                    onPressed: () {
                                      ref.read(cartProvider.notifier).removeFromCart(
                                            cartItem.product.id,
                                          );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Bottom Summary
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E32) : Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.grey[400] : Colors.grey[700],
                              ),
                            ),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                              ).createShader(bounds),
                              child: Text(
                                '\$${totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6C63FF).withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/billing');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Proceed to Checkout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
