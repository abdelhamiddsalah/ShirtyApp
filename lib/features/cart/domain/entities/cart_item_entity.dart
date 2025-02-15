import 'package:clothshop/features/home/domain/entities/product_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  int count;
  final String? selectedSize;
  final String? selectedColor;

  CartItemEntity({
    required this.product,
    this.count = 0,
    this.selectedSize,
    this.selectedColor,
  });

  CartItemEntity copyWith({
    ProductEntity? product,
    int? count,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItemEntity(
      product: product ?? this.product,
      count: count ?? this.count,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  double get totalPrice {
    try {
      return double.parse(product.price.trim()) * count;
    } catch (e) {
      return 0.0; // Fallback value
    }
  }
}