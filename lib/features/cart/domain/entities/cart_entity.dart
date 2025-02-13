import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> items;
  
  CartEntity({
    required this.items,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get shippingCost => 0.0; // Can be modified based on business logic
  double get total => subtotal + shippingCost;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}