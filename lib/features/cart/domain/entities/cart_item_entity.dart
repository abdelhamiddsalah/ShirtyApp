import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String id  ;
  final String name;
  final String image;
  final int quantity;
  final double totalPrice;
  final String selectedColor;
  final String selectedSize;
  final double price;

  const CartItemEntity({
    required this.name,
    required this.image,
    required this.selectedColor,
    required this.selectedSize,
    required this.quantity,
    required this.totalPrice,
    required this.price,
    required this.id,
  });

  @override
  List<Object?> get props => [name, image, quantity, totalPrice, selectedColor, selectedSize,price];

  CartItemEntity copyWith({
    String? name,
    String? image,
    int? quantity,
    double? totalPrice,
    String? selectedColor,
    String? selectedSize,
    double? price,
    String? id,
  }) {
    return CartItemEntity(
      name: name ?? this.name,
      image: image ?? this.image,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      price: price ?? this.price,
      id: id ?? this.id,
    );
  }

   static CartItemEntity empty() {
    return CartItemEntity(
      id: '',
      name: '',
      image: '',
      quantity: 0,
      totalPrice: 0.0,
      selectedColor: '',
      selectedSize: '',
      price: 0.0,
    );
  }
}
