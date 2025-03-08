import 'package:clothshop/features/cart/domain/usecases/deletecart_usecase.dart';
import 'package:clothshop/features/cart/domain/usecases/getcarts_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/domain/usecases/addcart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddcartUsecase addcartUsecase;
  final GetcartsUsecase getcartsUsecase;
  final DeletecartUsecase deletecartUsecase;

  CartCubit(this.addcartUsecase, this.getcartsUsecase, this.deletecartUsecase) : super(CartInitial()) {
    // Initialize by fetching carts
    getcarts();
  }

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
      emit(CartLoaded(List.from(cartItems))); // ✅ تحديث مباشر بدون حالة إضافية
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

      int updatedQuantity = cart.quantity;
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
    }
  }

  void updateQuantity(int index, int additionalQuantity) {
    if (index >= 0 && index < cartItems.length) {
      updateCartItemQuantity(index, cartItems[index].quantity + additionalQuantity);
    }
  }

  Future<void> getcarts() async {
    emit(CartLoading());
    final result = await getcartsUsecase.call();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartItems) {
        this.cartItems.clear();
        this.cartItems.addAll(cartItems);
        emit(CartLoaded(List.from(cartItems)));
      },
    );
  }


Future<void> deletecart(String cartId, String selectedSize, String selectedColor) async {
  // Find the item index before removing it
  final itemIndex = cartItems.indexWhere((item) => 
      item.id == cartId && 
      item.selectedSize == selectedSize && 
      item.selectedColor == selectedColor);
  
  if (itemIndex != -1) {
    // Create a copy of the item before removing it (in case we need to restore it)
    final removedItem = cartItems[itemIndex];
    
    // Remove item from local list first
    cartItems.removeAt(itemIndex);
    
    // Update UI immediately to remove the dismissed widget from the tree
    emit(CartLoaded(List.from(cartItems)));
    
    // Then attempt to delete from backend
    final result = await deletecartUsecase.call(cartId, selectedSize, selectedColor);
    
    result.fold(
      (failure) {
        print("Error deleting cart item: ${failure.message}");
        // If backend deletion fails, restore the item
        cartItems.insert(itemIndex, removedItem);
        emit(CartError(failure.message));
        // Re-emit loaded state to update UI
        emit(CartLoaded(List.from(cartItems)));
      },
      (_) {
        print("Cart item deleted successfully");
      },
    );
  }
}


Future<void> clearCart() async {
  if (cartItems.isEmpty) return;

  // نسخ القائمة للاحتفاظ بالعناصر قبل حذفها في حالة فشل العملية
  final oldCartItems = List<CartItemEntity>.from(cartItems);

  // حذف كل عنصر من السلة في `backend`
  for (var item in oldCartItems) {
    final result = await deletecartUsecase.call(
      item.id.toString(),
      item.selectedSize.toString(),
      item.selectedColor.toString(),
    );

    result.fold(
      (failure) {
        print("Error deleting cart item: ${failure.message}");
        emit(CartError(failure.message));
        // في حالة الفشل، استعادة العناصر المحذوفة
        cartItems.clear();
        cartItems.addAll(oldCartItems);
        emit(CartLoaded(List.from(cartItems)));
      },
      (_) {
        print("Cart item deleted successfully");
      },
    );
  }

  // إذا نجح الحذف، قم بتفريغ القائمة وإعادة تحديث الحالة
  cartItems.clear();
  emit(CartLoaded(List.from(cartItems)));
}


}
