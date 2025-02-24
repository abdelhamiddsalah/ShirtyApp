import 'package:clothshop/features/cart/data/models/cart_item_model.dart';
import 'package:clothshop/features/checkout/data/models/address_model.dart';
import 'package:clothshop/features/profile/data/models/complaint_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

Future<void> addCart(CartItemModel cart, String userId) async {
  try {
    await _firestore.collection('Users').doc(userId).collection('cart').add(cart.toJson());
  } catch (e) {
    throw Exception("Error adding cart: $e");
  }
}
}