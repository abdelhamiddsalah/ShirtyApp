import 'package:clothshop/features/home/domain/entities/product_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;

  CartItemEntity({
    required this.product,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
  });

  double get totalPrice => double.parse(product.price ?? '0') * quantity;
}