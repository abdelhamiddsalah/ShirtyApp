import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/orders/domain/usecases/addtocart_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart'; // استيراد CartCubit
import 'package:flutter/widgets.dart'; // لاستدعاء context

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final AddtocartUsecase addtocartUsecase;
  
  OrdersCubit(this.addtocartUsecase) : super(OrdersInitial());

  int quantity = 0;

  Future<void> addtocart(AddtocartModel params, BuildContext context) async {
    final userid = FirebaseAuth.instance.currentUser;
    if (userid == null) return;

    final cartRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userid.uid)
        .collection('cart')
        .doc(params.productId);

    try {
      final cartSnapshot = await cartRef.get();

      if (cartSnapshot.exists) {
        final currentData = cartSnapshot.data() as Map<String, dynamic>;
        final currentQuantity = currentData['quantity'] as int;
        final newQuantity = currentQuantity + params.quantity;

        quantity = newQuantity;
        emit(OrdersLoaded(quantity));

        await Future.wait([
          cartRef.update({
            'quantity': newQuantity,
            'totalprice': params.mainprice * newQuantity,
          }),
          FirebaseFirestore.instance
              .collection('Allproducts')
              .doc(params.productId)
              .update({
            'salescount': FieldValue.increment(params.quantity)
          }),
        ]);
      } else {
        quantity = params.quantity;
        emit(OrdersLoaded(quantity));

        await Future.wait([
          cartRef.set({
            'productId': params.productId,
            'quantity': params.quantity,
            'productname': params.productname,
            'mainprice': params.mainprice,
            'productimage': params.productimage,
            'productSelectedcolor': params.productSelectedcolor,
            'productSelectedsize': params.productSelectedsize,
            'createDate': params.createDate,
            'totalprice': params.mainprice * params.quantity,
          }),
          FirebaseFirestore.instance
              .collection('Allproducts')
              .doc(params.productId)
              .update({
            'salescount': FieldValue.increment(params.quantity)
          }),
        ]);
      }

      /// **تحديث بيانات السلة بعد الإضافة مباشرة**
     // context.read<CartCubit>().getcarts();
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
}
