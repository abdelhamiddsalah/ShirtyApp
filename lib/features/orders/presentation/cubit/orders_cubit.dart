import 'package:bloc/bloc.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/orders/domain/usecases/addtocart_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'orders_state.dart';
 
class OrdersCubit extends Cubit<OrdersState> {
  final AddtocartUsecase addtocartUsecase;
  
  OrdersCubit(this.addtocartUsecase) : super(OrdersInitial());

  int quantity = 0;

   Future<void> addtocart(AddtocartModel params) async {
    emit(OrdersLoading());
    
    try {
      final userid= FirebaseAuth.instance.currentUser;
      final cartRef = FirebaseFirestore.instance.collection('Users').doc(userid!.uid).collection('cart').doc(params.productId);
      final cartSnapshot = await cartRef.get();
      
      if (cartSnapshot.exists) {
        // Product already exists in cart - update quantity and sales count
        final currentData = cartSnapshot.data() as Map<String, dynamic>;
        final currentQuantity = currentData['quantity'] as int;
        final newQuantity = currentQuantity + params.quantity;
        
        await cartRef.update({
          'quantity': newQuantity,
          'totalprice': params.mainprice * newQuantity,
        });

        // Update sales count in products collection
        await FirebaseFirestore.instance
          .collection('Allproducts')
          .doc(params.productId)
          .update({
            'salescount': FieldValue.increment(params.quantity)
          });

        quantity = newQuantity;
        emit(OrdersLoaded(quantity));
      } else {
        // New product - add to cart with initial quantity
        await cartRef.set({
          'productId': params.productId,
          'quantity': params.quantity,
          'productname': params.productname,
          'mainprice': params.mainprice,
          'productimage': params.productimage,
          'productSelectedcolor': params.productSelectedcolor,
          'productSelectedsize': params.productSelectedsize,
          'createDate': params.createDate,
          'totalprice': params.mainprice * params.quantity,
        });

        // Update sales count in products collection
        await FirebaseFirestore.instance
          .collection('Allproducts')
          .doc(params.productId)
          .update({
            'salescount': FieldValue.increment(params.quantity)
          });

        quantity = params.quantity;
        emit(OrdersLoaded(quantity));
      }
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  void increasecount() {
    quantity += 1;
    emit(OrdersLoaded(quantity));
  }

  void decreasecount() {
    if (quantity > 0) {
      quantity -= 1;
      emit(OrdersLoaded(quantity));
    }
  }
}
