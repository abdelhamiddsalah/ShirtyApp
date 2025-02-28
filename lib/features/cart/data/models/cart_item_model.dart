import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.selectedColor,
    required super.selectedSize,
    required super.quantity,
    required super.totalPrice, required super.name, required super.image, required super.price, required super.id,
    
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      selectedColor: json['selectedColor'] ?? '',
      selectedSize: json['selectedSize'] ?? '',
      quantity: json['quantity'] ?? 1,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num).toDouble(),
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'totalPrice': totalPrice,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'name': name,
      'image': image,
      'price': price,
      'id': id,
    };
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      selectedColor: selectedColor,
      selectedSize: selectedSize,
      quantity: quantity,
      totalPrice: totalPrice,
      name: name,
      image: image,
      price: price,
      id: id,
    );
  }
}
