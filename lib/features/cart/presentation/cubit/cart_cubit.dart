/*import 'package:clothshop/features/cart/domain/entities/cart_entity.dart';
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
     // var cartItem = getCartItem(productentity);
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

}*/

import 'package:clothshop/features/cart/domain/entities/cart_entity.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartEntity> {
  CartCubit() : super(CartEntity(products: []));

  void addToCart(ProductEntity product) {
    print('Adding product to cart: ${product.name}'); // Debug print
    
    List<ProductEntity> updatedProducts = List.from(state.products);
    int index = updatedProducts.indexWhere((p) => p.productId == product.productId);

    if (index != -1) {
      print('Product exists in cart, updating quantity'); // Debug print
      ProductEntity existingProduct = updatedProducts[index];
      updatedProducts[index] = ProductEntity(
        categoryId: existingProduct.categoryId,
        productId: existingProduct.productId,
        name: existingProduct.name,
        price: existingProduct.price,
        image: existingProduct.image,
        quantity: existingProduct.quantity + 1,
        ratingcount: existingProduct.ratingcount,
        sizes: existingProduct.sizes,
        description: existingProduct.description,
        colors: existingProduct.colors,
        category: existingProduct.category,
        reviews: existingProduct.reviews,
        salescount: existingProduct.salescount,
      );
    } else {
      print('Adding new product to cart'); // Debug print
      product.quantity = 1; // Ensure quantity is set
      updatedProducts.add(product);
    }

    print('Updated cart products count: ${updatedProducts.length}'); // Debug print
    emit(CartEntity(products: updatedProducts));
  }

  void removeFromCart(String productId) {
    print('Removing product: $productId'); // Debug print
    List<ProductEntity> updatedProducts = state.products.where((p) => p.productId != productId).toList();
    emit(CartEntity(products: updatedProducts));
  }

  void updateQuantity(String productId, int quantity) {
    print('Updating quantity for product: $productId to $quantity'); // Debug print
    List<ProductEntity> updatedProducts = List.from(state.products);
    int index = updatedProducts.indexWhere((p) => p.productId == productId);

    if (index != -1) {
      if (quantity > 0) {
        ProductEntity existingProduct = updatedProducts[index];
        updatedProducts[index] = ProductEntity(
          categoryId: existingProduct.categoryId,
          productId: existingProduct.productId,
          name: existingProduct.name,
          price: existingProduct.price,
          image: existingProduct.image,
          quantity: quantity,
          ratingcount: existingProduct.ratingcount,
          sizes: existingProduct.sizes,
          description: existingProduct.description,
          colors: existingProduct.colors,
          category: existingProduct.category,
          reviews: existingProduct.reviews,
          salescount: existingProduct.salescount,
        );
      } else {
        updatedProducts.removeAt(index);
      }
    }

    emit(CartEntity(products: updatedProducts));
  }
}