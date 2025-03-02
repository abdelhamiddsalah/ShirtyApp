import 'package:clothshop/core/services/firestore_services.dart';
import 'package:clothshop/features/cart/data/models/cart_item_model.dart';

abstract class RemoteDatasourceCart {
  Future<List<CartItemModel>> getCart();

}

class RemoteDatasourceCartImpl implements RemoteDatasourceCart {
  final FirestoreService firestoreService;

  RemoteDatasourceCartImpl({required this.firestoreService});
  @override
  Future<List<CartItemModel>> getCart() async {
    return firestoreService.getCarts();
  }

}