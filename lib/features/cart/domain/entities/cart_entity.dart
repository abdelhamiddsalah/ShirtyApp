import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final int count;

  const CartEntity({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.count,
  });
  @override
  List<Object?> get props => [id, productId, title, price, quantity, count];
}