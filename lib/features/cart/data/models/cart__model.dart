import 'package:clothshop/features/cart/data/models/cart_item_model.dart';

class CartModel {
  final String cartId;
  final List<CartItemModel> items;
  final double totalPrice;

  CartModel({
    required this.cartId,
    required this.items,
    required this.totalPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json['cartId'] ?? '',
      items: (json['items'] as List<dynamic>)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }
}
