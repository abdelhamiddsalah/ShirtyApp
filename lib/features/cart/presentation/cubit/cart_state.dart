part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final CartEntity cart;
  const CartLoaded(this.cart);
  
  @override
  List<Object> get props => [cart];
}

class CartItemAdded extends CartState {}
class CartItemRemoved extends CartState {}
class CartCleared extends CartState {}
class CartError extends CartState {
  final String message;
  const CartError(this.message);
  
  @override
  List<Object> get props => [message];
}
