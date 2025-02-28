import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/domain/usecases/addcart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddcartUsecase addcartUsecase;

  CartCubit(this.addcartUsecase) : super(CartInitial());
  final List<CartItemEntity> cartItems = [];

  /// 🔹 دالة لحساب السعر الإجمالي بناءً على السعر والكمية
  double calculateUpdatedTotalPrice(double price, int quantity) {
    return price * quantity;
  }

  /// 🔹 دالة لتحديث العنصر داخل السلة وإعادة الإرسال للحالة
  void updateCartItemQuantity(int index, int newQuantity) {
    if (index >= 0 && index < cartItems.length) {
      final cart = cartItems[index];

      double updatedTotalPrice = calculateUpdatedTotalPrice(cart.price, newQuantity);

      cartItems[index] = cart.copyWith(
        quantity: newQuantity,
        totalPrice: updatedTotalPrice,
      );

      emit(CartUpdated(cartItems));
    }
  }

 Future<void> addToCart(CartItemEntity cart, String userId) async {
   print('Adding item to cart: ${cart.id}, current count: ${cartItems.length}');
  final existingItemIndex = cartItems.indexWhere((item) => 
    item.id == cart.id && 
    item.selectedSize == cart.selectedSize && 
    item.selectedColor == cart.selectedColor
  );
  
  if (existingItemIndex != -1) {
    // إذا كان المنتج موجودًا، قم بتحديث الكمية فقط
    final existingItem = cartItems[existingItemIndex];
    
    int updatedQuantity = existingItem.quantity + cart.quantity;
    double updatedTotalPrice = calculateUpdatedTotalPrice(existingItem.price, updatedQuantity);
    
    final updatedItem = existingItem.copyWith(
      quantity: updatedQuantity,
      totalPrice: updatedTotalPrice,
    );
    
    final result = await addcartUsecase.call(updatedItem, userId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartItem) {
        cartItems[existingItemIndex] = cartItem;
        emit(CartLoaded(List.from(cartItems))); // ✅ تحديث عدد المنتجات
      },
    );
  } else {
    // إضافة منتج جديد للسلة
    final result = await addcartUsecase.call(cart, userId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartItem) {
        cartItems.add(cartItem);
        emit(CartLoaded(List.from(cartItems))); // ✅ تحديث عدد المنتجات
      },
    );
  }
  print('After adding, cart count: ${cartItems.length}');
} 


 void increaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      updateCartItemQuantity(index, cartItems[index].quantity + 1);
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length && cartItems[index].quantity > 1) {
      updateCartItemQuantity(index, cartItems[index].quantity - 1);
       emit(CartLoaded(List.from(cartItems)));
    }
  }

  void updateQuantity(int index, int additionalQuantity) {
    if (index >= 0 && index < cartItems.length) {
      updateCartItemQuantity(index, cartItems[index].quantity + additionalQuantity);
       emit(CartLoaded(List.from(cartItems)));
    }
  }
}

