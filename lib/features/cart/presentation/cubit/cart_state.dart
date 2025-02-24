part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> cartItems;
  final int totalQuantity;
    final double totalPrice;

  const CartLoaded(this.cartItems, this.totalQuantity, this.totalPrice);

  @override
  List<Object> get props => [cartItems, totalQuantity];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
