import 'package:clothshop/features/cart/domain/entities/cart_entity.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'cart_state.dart';



class CartCubit extends Cubit<CartState> {
  
  CartCubit() : super(CartInitial()){
     emit(CartLoaded(cartEntity)); // تأكد من تحميل البيانات عند إنشاء الكيوبت
  }

  CartEntity cartEntity = CartEntity(items: []);

  void addProduct(ProductEntity productentity) {
    bool isProductExist = cartEntity.items.any((item) => item.product == productentity);
    if (isProductExist) {
      var cartItem = getCartItem(productentity);
      cartEntity = cartEntity.copyWith(newItems: [
        for (var item in cartEntity.items)
          if (item.product == productentity)
            item.copyWith(count: item.count + 1)
          else
            item
      ]);
    } else {
      CartItemEntity cartItemEntity = CartItemEntity(product: productentity, count: 1);
      cartEntity = cartEntity.addCartItem(cartItemEntity);
    }
    emit(CartLoaded(cartEntity));
  }

  void removeProduct(ProductEntity productentity) {
    cartEntity = cartEntity.copyWith(
      newItems: cartEntity.items.where((item) => item.product != productentity).toList(),
    );
    emit(CartLoaded(cartEntity));
  }

  void increaseQuantity(ProductEntity productentity) {
    cartEntity = cartEntity.copyWith(newItems: [
      for (var item in cartEntity.items)
        if (item.product == productentity)
          item.copyWith(count: item.count + 1)
        else
          item
    ]);
    emit(CartLoaded(cartEntity));
  }

  void decreaseQuantity(ProductEntity productentity) {
    cartEntity = cartEntity.copyWith(newItems: [
      for (var item in cartEntity.items)
        if (item.product == productentity && item.count > 1)
          item.copyWith(count: item.count - 1)
        else
          item
    ]);
    emit(CartLoaded(cartEntity));
  }

  CartItemEntity? getCartItem(ProductEntity productentity) {
  return cartEntity.items.firstWhere(
    (item) => item.product == productentity,
    orElse: () => CartItemEntity(product: productentity, count: 1),
  );
}

}