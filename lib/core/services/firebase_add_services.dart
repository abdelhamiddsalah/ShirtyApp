import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/checkout/data/models/address_model.dart';
import 'package:clothshop/features/profile/data/models/complaint_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

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

Future<Either<Failure, CartItemEntity>> addCartItem(CartItemEntity cart, String userId) async {
  try {
    // Reference to user's cart in Firebase
    final cartRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('cart');
    
    // Check if item exists with same id, size and color
    final querySnapshot = await cartRef
        .where('id', isEqualTo: cart.id)
        .where('selectedSize', isEqualTo: cart.selectedSize)
        .where('selectedColor', isEqualTo: cart.selectedColor)
        .get();
    
    if (querySnapshot.docs.isNotEmpty) {
      // Item exists, update it
      final docId = querySnapshot.docs[0].id;
      final itemData = {
        'quantity': cart.quantity,
        'totalPrice': cart.totalPrice,
        // Include other fields that might have changed
      };
      
      await cartRef.doc(docId).update(itemData);
      return Right(cart);
    } else {
      // New item, add it
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
      
      await cartRef.add(itemData);
      return Right(cart);
    }
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

}