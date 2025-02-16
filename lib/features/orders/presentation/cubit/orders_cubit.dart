import 'package:bloc/bloc.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/orders/domain/usecases/addtocart_usecase.dart';
import 'package:equatable/equatable.dart';

part 'orders_state.dart';
 
class OrdersCubit extends Cubit<OrdersState> {
  final AddtocartUsecase addtocartUsecase;
  OrdersCubit(this.addtocartUsecase) : super(OrdersInitial());
 int quantity =0;
int count =0;
  Future<void> addtocart(AddtocartModel params) async {
    emit(OrdersLoading());
    final result = await addtocartUsecase.call(params);
    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (addtocart) => emit(OrdersLoaded( quantity)),
    );
  }

  totalprice(){

  }

  void increasecount() {
   quantity +=1;
  }

  void decreasecount() {
    if (quantity >0) {
      quantity=-1;
    }else{
      quantity =0;
    }
  }
}
