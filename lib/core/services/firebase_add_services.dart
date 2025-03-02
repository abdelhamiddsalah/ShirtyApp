import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/checkout/data/models/address_model.dart';
import 'package:clothshop/features/profile/data/models/complaint_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAddServices {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addComplaint(ComplaintModel complaint) async {
    await _firestore.collection('complaints').add(complaint.toJson());
  }

  Future<void> addAddress(AddressModel address, String userid) async {
    await _firestore.collection('Users').doc(userid).collection('address').add(address.toJson());
  }

  Future<AddressModel> getUserAddress(String userId) async {
  try {
    final result = await _firestore.collection('Users').doc(userId).collection('address').get();
    return AddressModel.fromJson(result.docs.first.data());
  } catch (e) {
    throw Exception("Error fetching user address: $e");
  }
}

Future<Either<Failure, CartItemEntity>> addCartItem(
    CartItemEntity cart, String userId) async {
  try {
    // مرجع لسلة المشتريات الخاصة بالمستخدم
    final cartCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('cart');

    // البحث عن عنصر بنفس المواصفات
    final querySnapshot = await cartCollection
        .where('id', isEqualTo: cart.id)
        .where('selectedSize', isEqualTo: cart.selectedSize)
        .where('selectedColor', isEqualTo: cart.selectedColor)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // العنصر موجود بالفعل، نقوم بتحديث الكمية والسعر الإجمالي
      final docRef = querySnapshot.docs.first.reference;

      await docRef.update({
        'quantity': FieldValue.increment(cart.quantity),
        'totalPrice': FieldValue.increment(cart.totalPrice),
      });

      return Right(cart);
    } else {
      // عنصر جديد، نقوم بإضافته
      final itemData = {
        'id': cart.id,
        'name': cart.name,
        'image': cart.image,
        'price': cart.price,
        'quantity': cart.quantity,
        'totalPrice': cart.totalPrice,
        'selectedSize': cart.selectedSize,
        'selectedColor': cart.selectedColor,
      };

      await cartCollection.add(itemData);
      return Right(cart);
    }
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

Future<void> deletecart(String productId, String selectedSize, String selectedColor) async {
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("No authenticated user found");
    throw Exception("No authenticated user found");
  }

  var cartRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(user.uid)
      .collection('cart');

  try {
    var querySnapshot = await cartRef
        .where('id', isEqualTo: productId)
        .where('selectedSize', isEqualTo: selectedSize)
        .where('selectedColor', isEqualTo: selectedColor)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // حذف العنصر الأول الذي تطابقه الشروط
      await querySnapshot.docs.first.reference.delete();
      print("Item successfully deleted from Firebase.");
    } else {
      print("Item not found in cart.");
    }
  } catch (e) {
    print('Error deleting cart item: $e');
    throw Exception('Failed to delete item from cart: $e');
  }
}

}