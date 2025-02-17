import 'package:bloc/bloc.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/orders/domain/usecases/addtocart_usecase.dart';
import 'package:equatable/equatable.dart';

part 'orders_state.dart';
 
class OrdersCubit extends Cubit<OrdersState> {
  final AddtocartUsecase addtocartUsecase;
  
  OrdersCubit(this.addtocartUsecase) : super(OrdersInitial());

  int quantity = 0;

  Future<void> addtocart(AddtocartModel params) async {
    emit(OrdersLoading());
    final result = await addtocartUsecase.call(params);
    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (addtocart) => emit(OrdersLoaded(quantity)),
    );
  }

  void increasecount() {
    quantity += 1;
    emit(OrdersLoaded(quantity)); // 🔹 تحديث الواجهة بعد زيادة العدد
  }

  void decreasecount() {
    if (quantity > 0) {
      quantity -= 1; // 🔹 تصحيح الإنقاص ليكون `-1` بدلاً من `= -1`
      emit(OrdersLoaded(quantity)); // 🔹 تحديث الواجهة بعد إنقاص العدد
    }
  }
}
