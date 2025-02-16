import 'package:clothshop/core/services/firestore_services.dart';
import 'package:clothshop/features/cart/data/models/cart_model.dart';

abstract class RemoteDatasourceCart {
  Future<List<CartModel>> getCart();
}

class RemoteDatasourceCartImpl implements RemoteDatasourceCart {
  final FirestoreService firestoreService;

  RemoteDatasourceCartImpl({required this.firestoreService});
  @override
  Future<List<CartModel>> getCart() async {
    return firestoreService.getCarts();
  }
}