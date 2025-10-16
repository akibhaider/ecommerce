import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/otp_verification_screen.dart';
import '../screens/home_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/liked_products_screen.dart';
import '../screens/billing_screen.dart';
import '../screens/order_success_screen.dart';
import '../screens/discount_products_screen.dart';
import '../providers/auth_provider.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.value?.session != null;
      final isLoggingIn = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forgot-password' ||
          state.matchedLocation == '/verify-otp';

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      if (isLoggedIn && isLoggingIn && state.matchedLocation != '/verify-otp') {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SignupScreen(),
        ),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: '/verify-otp',
        name: 'verify-otp',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] as String? ?? '';
          final type = extra?['type'] as String? ?? 'signup';
          
          return MaterialPage(
            key: state.pageKey,
            child: OtpVerificationScreen(
              email: email,
              type: type,
            ),
          );
        },
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/product/:id',
        name: 'product-detail',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return MaterialPage(
            key: state.pageKey,
            child: ProductDetailScreen(productId: id),
          );
        },
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CartScreen(),
        ),
      ),
      GoRoute(
        path: '/liked',
        name: 'liked',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LikedProductsScreen(),
        ),
      ),
      GoRoute(
        path: '/discounts',
        name: 'discounts',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const DiscountProductsScreen(),
        ),
      ),
      GoRoute(
        path: '/billing',
        name: 'billing',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const BillingScreen(),
        ),
      ),
      GoRoute(
        path: '/order-success',
        name: 'order-success',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const OrderSuccessScreen(),
        ),
      ),
    ],
  );
});
