import 'package:clothshop/features/cart/domain/usecases/getcarts_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clothshop/features/cart/data/models/cart_item_model.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/domain/usecases/addcart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddcartUsecase addcartUsecase;
  final GetcartsUsecase getcartsUsecase;
  CartCubit(this.addcartUsecase, this.getcartsUsecase) : super(CartInitial()){
    getcarts();
  }

  final List<CartItemEntity> _cartItems = [];
  List<CartItemEntity> get cartItems => _cartItems;

  double get totalCartPrice => _cartItems.fold(
        0,
        (sum, item) => sum + item.totalPrice,
      );

  Future<void> addToCart(CartItemModel cart, String userId) async {
    try {
      emit(CartLoading());
      
      // Check if item already exists in cart
      final existingItemIndex = _cartItems.indexWhere(
        (item) => item.product.productId == cart.product.productId,
      );

      if (existingItemIndex != -1) {
        // Update quantity if item exists
        await _updateCartItemQuantity(
          _cartItems[existingItemIndex],
          _cartItems[existingItemIndex].quantity + 1,
          userId,
        );
      } else {
        // Add new item if it doesn't exist
        final result = await addcartUsecase.call(cart, userId);
        result.fold(
          (failure) => emit(CartError(failure.message)),
          (cartItem) {
            _cartItems.add(cartItem);
            _emitUpdatedState();
          },
        );
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> incrementQuantity(CartItemEntity cartItem, String userId) async {
    try {
      final index = _cartItems.indexWhere(
        (item) => item.product.productId == cartItem.product.productId,
      );
      
      if (index != -1) {
        await _updateCartItemQuantity(
          cartItem,
          cartItem.quantity + 1,
          userId,
        );
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> decrementQuantity(CartItemEntity cartItem, String userId) async {
    try {
      final index = _cartItems.indexWhere(
        (item) => item.product.productId == cartItem.product.productId,
      );
      
      if (index != -1) {
        if (cartItem.quantity > 1) {
          await _updateCartItemQuantity(
            cartItem,
            cartItem.quantity - 1,
            userId,
          );
        } else {
          await removeFromCart(cartItem, userId);
        }
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeFromCart(CartItemEntity cartItem, String userId) async {
  try {
    _cartItems.removeWhere(
      (item) => item.product.productId == cartItem.product.productId,
    );
    _emitUpdatedState(); // لا نستخدم CartLoading()
  } catch (e) {
    emit(CartError(e.toString()));
  }
}


  Future<void> _updateCartItemQuantity(
    CartItemEntity cartItem,
    int newQuantity,
    String userId,
  ) async {
    try {
      emit(CartLoading());
      // Add your update quantity API call here if needed
      
      final index = _cartItems.indexWhere(
        (item) => item.product.productId == cartItem.product.productId,
      );
      
      if (index != -1) {
        _cartItems[index] = cartItem.copyWith(
          quantity: newQuantity,
          totalPrice: cartItem.product.price.toDouble() * newQuantity,
        );
        _emitUpdatedState();
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void _emitUpdatedState() {
    emit(CartLoaded(
      List.from(_cartItems),
      _calculateTotalQuantity(),
      totalCartPrice,
    ));
  }

  int _calculateTotalQuantity() {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void clearCart() {
    _cartItems.clear();
    _emitUpdatedState();
  }

 Future<void> getcarts() async {
  emit(CartLoading());
  final result = await getcartsUsecase.call();
  result.fold(
    (failure) => emit(CartError(failure.message)), 
    (carts) {
      _cartItems.clear();
      _cartItems.addAll(carts);
      int totalQuantity = carts.fold(0, (sum, item) => sum + item.quantity);
      double totalPrice = carts.fold(0, (sum, item) => sum + item.totalPrice);
      emit(CartLoaded(carts, totalQuantity, totalPrice));
    }
  );
}

}

/*int quantity = 1;
Future<void> getcarts() async {
  emit(CartLoading());
  final result = await getcartsUsecase.call();
  result.fold(
    (failure) => emit(CartError(failure.message)), 
    (carts) {
      int totalQuantity = carts.fold(0, (sum, item) => sum + item.quantity);
      emit(CartLoaded(carts, totalQuantity));
    }
  );
}


  Future<void> deletecart(String cartId) async {
  if (state is CartLoaded) {
    final currentState = state as CartLoaded;
    final updatedCartItems = List<CartItemEntity>.from(currentState.cartItems);
    
    final itemIndex = updatedCartItems.indexWhere((item) => item.productId == cartId);
    if (itemIndex == -1) return;

    final removedItem = updatedCartItems.removeAt(itemIndex);
    int updatedQuantity = currentState.quantity - removedItem.quantity;

    emit(CartLoaded(updatedCartItems, updatedQuantity));

    final result = await deletecartUsecase.call(cartId);
    result.fold(
      (failure) {
        updatedCartItems.insert(itemIndex, removedItem);
        emit(CartLoaded(updatedCartItems, currentState.quantity));
        emit(CartError(failure.message));
      },
      (_) {},
    );
  }
}


  // Add this method to handle cart updates from other screens
  void refreshCart() {
    getcarts();
  }

  Future<void> addtocart(AddtocartModel params, BuildContext context) async {
  final userid = FirebaseAuth.instance.currentUser;
  if (userid == null) return;

  final cartRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(userid.uid)
      .collection('cart')
      .doc(params.productId);

  try {
    final cartSnapshot = await cartRef.get();

    if (cartSnapshot.exists) {
      final currentData = cartSnapshot.data() as Map<String, dynamic>;
      final currentQuantity = currentData['quantity'] as int;
      final newQuantity = currentQuantity + params.quantity;

      quantity = newQuantity;
      final updatedCartItems = (state as CartLoaded).cartItems;
      emit(CartLoaded(updatedCartItems, quantity));

      await cartRef.update({
        'quantity': newQuantity,
        'totalprice': params.mainprice * newQuantity,
      });

    } else {
      quantity = params.quantity;
      emit(CartLoaded((state is CartLoaded) ? (state as CartLoaded).cartItems : [], quantity));

      await cartRef.set({
        'productId': params.productId,
        'quantity': params.quantity,
        'productname': params.productname,
        'mainprice': params.mainprice,
        'productimage': params.productimage,
        'productSelectedcolor': params.productSelectedcolor,
        'productSelectedsize': params.productSelectedsize,
        'createDate': params.createDate,
        'totalprice': params.mainprice * params.quantity,
      });

      // تحديث salescount فقط إذا كان المنتج جديدًا
      await FirebaseFirestore.instance
          .collection('Allproducts')
          .doc(params.productId)
          .update({
        'salescount': FieldValue.increment(params.quantity)
      });
    }

    /// **تحديث بيانات السلة بعد الإضافة مباشرة**
    context.read<CartCubit>().getcarts();
  } catch (e) {
    emit(CartError(e.toString()));
  }
}*/