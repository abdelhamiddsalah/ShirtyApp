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
  const CartLoaded(this.cartItems);
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
}