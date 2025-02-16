/*import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> items;

  CartEntity({required this.items});

  CartEntity copyWith({List<CartItemEntity>? newItems}) {
    return CartEntity(items: newItems ?? items);
  }

  CartEntity addCartItem(CartItemEntity item) {
    return copyWith(newItems: [...items, item]);
  }

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get shippingCost => 0.0;
  double get total => subtotal + shippingCost;
  int get itemCount => items.fold(0, (sum, item) => sum + item.count);
}*/

import 'package:clothshop/features/home/domain/entities/product_entity.dart';

class CartEntity {
  final List<ProductEntity> products;

  CartEntity({required this.products});

  double get subtotal => products.fold(0, (total, product) => total + (product.price * product.quantity));

  double get shippingCost => subtotal > 0 ? 10.0 : 0.0; // مثال لشحن ثابت

  double get total => subtotal + shippingCost;
}
