/*import 'package:clothshop/core/services/firestore_services.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';

abstract class RemoteDatasourceOrders {
  Future<List<AddtocartModel>> addtocart();
}

class RemoteDatasourceOrdersImpl implements RemoteDatasourceOrders {
  final FirestoreService firestoreService;

  RemoteDatasourceOrdersImpl({required this.firestoreService});
  @override
  Future<List<AddtocartModel>> addtocart() async{
    return firestoreService.addToCart();
  }
}*/