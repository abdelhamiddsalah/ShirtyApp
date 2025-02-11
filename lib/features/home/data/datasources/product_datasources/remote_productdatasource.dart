import 'package:clothshop/core/services/firestore_services.dart';
import 'package:clothshop/features/home/data/models/product_model.dart';

abstract class RemoteProductdatasource {
  Future<List<ProductModel>> getremoteProducts(String categoryId);
}

class RemoteProductdatasourceImpl implements RemoteProductdatasource {
  final FirestoreService firestoreService;

  RemoteProductdatasourceImpl(this.firestoreService);
  @override
  Future<List<ProductModel>> getremoteProducts(String categoryId) {
    return firestoreService.getProducts( categoryId);
  }
}