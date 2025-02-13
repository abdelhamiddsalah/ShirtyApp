
import 'package:clothshop/features/cart/data/models/cart_model.dart';
import 'package:clothshop/features/cart/domain/entities/cart_entity.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Box<CartModel> cartBox;

  CartCubit(this.cartBox) : super(CartInitial()) {
    loadCart();
  }

  void loadCart() {
    try {
      final cartItems = cartBox.values.map((cartModel) {
        // Create ProductEntity from stored data
        // In a real app, you might want to maintain a products repository
        // to fetch full product details
        final product = ProductEntity(
          productId: cartModel.productId,
          // Other product fields would come from your product repository
        );
        
        return cartModel.toEntity(product);
      }).toList();

      final cartEntity = CartEntity(items: cartItems);
      emit(CartLoaded(cartEntity));
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  void addToCart(ProductEntity product, {
    int quantity = 1,
    String? selectedSize,
    String? selectedColor,
  }) {
    try {
      final existingItem = cartBox.get(product.productId);
      
      if (existingItem != null) {
        // Update quantity if product already exists
        final updatedQuantity = existingItem.quantity + quantity;
        final cartModel = CartModel(
          productId: product.productId!,
          quantity: updatedQuantity,
          selectedSize: selectedSize ?? existingItem.selectedSize,
          selectedColor: selectedColor ?? existingItem.selectedColor,
        );
        cartBox.put(product.productId, cartModel);
      } else {
        // Add new product to cart
        final cartModel = CartModel(
          productId: product.productId!,
          quantity: quantity,
          selectedSize: selectedSize,
          selectedColor: selectedColor,
        );
        cartBox.put(product.productId, cartModel);
      }
      
      loadCart();
      emit(CartItemAdded());
    } catch (e) {
      emit(CartError('Failed to add item: $e'));
    }
  }

  void updateQuantity(String productId, int quantity) {
    try {
      final existingItem = cartBox.get(productId);
      if (existingItem != null) {
        final cartModel = CartModel(
          productId: productId,
          quantity: quantity,
          selectedSize: existingItem.selectedSize,
          selectedColor: existingItem.selectedColor,
        );
        cartBox.put(productId, cartModel);
        loadCart();
      }
    } catch (e) {
      emit(CartError('Failed to update quantity: $e'));
    }
  }

  void removeFromCart(String productId) {
    try {
      cartBox.delete(productId);
      loadCart();
      emit(CartItemRemoved());
    } catch (e) {
      emit(CartError('Failed to remove item: $e'));
    }
  }

  void clearCart() {
    try {
      cartBox.clear();
      loadCart();
      emit(CartCleared());
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }
}