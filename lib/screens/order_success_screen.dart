import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/theme_provider.dart';

class OrderSuccessScreen extends ConsumerWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0F0F1E), const Color(0xFF1A1A2E)]
                : [const Color(0xFFF8F9FE), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Animation Container
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF10B981), Color(0xFF34D399)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withOpacity(0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Success Message
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF34D399)],
                    ).createShader(bounds),
                    child: Text(
                      'Order Placed!',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Text(
                    'Your order has been successfully placed',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  
                  // Thank you message
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF252540) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.celebration_rounded,
                          size: 32,
                          color: isDark ? const Color(0xFF8B85FF) : const Color(0xFF6C63FF),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Thank you for shopping with',
                          style: TextStyle(
                            fontSize: 15,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                          ).createShader(bounds),
                          child: const Text(
                            'Bazar Sodai',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          Icons.local_shipping_rounded,
                          'Fast Delivery',
                          'We\'ll deliver soon',
                          isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          Icons.notifications_active_rounded,
                          'Stay Updated',
                          'Track your order',
                          isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Continue Shopping Button
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
                      onPressed: () => context.go('/home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Continue Shopping',
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
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String title, String subtitle, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252540) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: isDark ? Colors.white : const Color(0xFF1A1A2E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
