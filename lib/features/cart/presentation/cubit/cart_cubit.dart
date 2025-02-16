import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/domain/usecases/getcarts_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetcartsUsecase getcartsUsecase;
  CartCubit(this.getcartsUsecase) : super(CartInitial());

  Future<void> getcarts() async {
    emit(CartLoading());
    final result = await getcartsUsecase.call();
    result.fold((failure) => emit(CartError(failure.message)), (carts) => emit(CartLoaded(carts)));
  }
}