import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable{
  final ProductEntity product;
  final int quantity;
  final double totalPrice;
  final String selectedColor;
  final String selectedSize;

  const CartItemEntity(this.selectedColor, this.selectedSize, {
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });
  
  @override
  List<Object?> get props => [product, quantity, totalPrice]; 

  CartItemEntity copyWith({
    ProductEntity? product,
    int? quantity,
    double? totalPrice,
    String? selectedColor,
    String? selectedSize,
  }) {
    return CartItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
       selectedColor ?? this.selectedColor,
       selectedSize ?? this.selectedSize,
    );
  }
}