import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

// Cart Provider
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      // Increase quantity if product already in cart
      state = [
        ...state.sublist(0, existingIndex),
        state[existingIndex].copyWith(quantity: state[existingIndex].quantity + 1),
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // Add new product to cart
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final index = state.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      state = [
        ...state.sublist(0, index),
        state[index].copyWith(quantity: quantity),
        ...state.sublist(index + 1),
      ];
    }
  }

  void clearCart() {
    state = [];
  }

  bool isInCart(String productId) {
    return state.any((item) => item.product.id == productId);
  }

  double get totalAmount {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get itemCount {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

// Liked Products Provider
final likedProductsProvider = StateNotifierProvider<LikedProductsNotifier, List<Product>>((ref) {
  return LikedProductsNotifier();
});

class LikedProductsNotifier extends StateNotifier<List<Product>> {
  LikedProductsNotifier() : super([]);

  void toggleLike(Product product) {
    final isLiked = state.any((p) => p.id == product.id);
    
    if (isLiked) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isLiked(String productId) {
    return state.any((p) => p.id == productId);
  }

  void removeLiked(String productId) {
    state = state.where((p) => p.id != productId).toList();
  }
}
