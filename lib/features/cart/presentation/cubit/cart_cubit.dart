import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/domain/usecases/deletecart_usecase.dart';
import 'package:clothshop/features/cart/domain/usecases/getcarts_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetcartsUsecase getcartsUsecase;
  final DeletecartUsecase deletecartUsecase;
  CartCubit(this.getcartsUsecase, this.deletecartUsecase) : super(CartInitial());

  Future<void> getcarts() async {
    emit(CartLoading());
    final result = await getcartsUsecase.call();
    result.fold((failure) => emit(CartError(failure.message)), (carts) => emit(CartLoaded(carts)));
  }

 Future<void> deletecart(String cartId) async {
  if (state is CartLoaded) {
    final currentState = state as CartLoaded;
    final updatedCartItems = List<CartItemEntity>.from(currentState.cartItems);

    // ابحث عن العنصر المطلوب حذفه
    final itemIndex = updatedCartItems.indexWhere((item) => item.productId == cartId);
    if (itemIndex == -1) return; // إذا لم يكن العنصر موجودًا، لا تفعل شيئًا

    // احتفظ بنسخة احتياطية من العنصر قبل الحذف
    final removedItem = updatedCartItems.removeAt(itemIndex);

    // تحديث الواجهة مؤقتًا
    emit(CartLoaded(updatedCartItems));

    // تنفيذ الحذف الفعلي في الـ backend
    final result = await deletecartUsecase.call(cartId);

    result.fold(
      (failure) {
        // في حالة الفشل، استرجع العنصر المحذوف
        updatedCartItems.insert(itemIndex, removedItem);
        emit(CartError(failure.message)); 
        emit(CartLoaded(updatedCartItems)); // إعادة تحميل البيانات بعد الفشل
      },
      (_) {
        // الحذف ناجح، لا حاجة لفعل شيء إضافي
      },
    );
  }
}


}