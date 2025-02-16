part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}


class OrdersLoaded extends OrdersState {
  final int quantity;
  OrdersLoaded( this.quantity);

  @override
  List<Object> get props => [quantity];
}

class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}
