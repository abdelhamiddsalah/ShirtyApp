import 'package:clothshop/core/services/firestore_services.dart';
import 'package:clothshop/features/home/data/models/product_model.dart';

abstract class RemoteProductdatasource {
  Future<List<ProductModel>> getremoteProducts(String path1, String path2, String documentId);
}

class RemoteProductdatasourceImpl implements RemoteProductdatasource {
  final FirestoreService firestoreService;

  RemoteProductdatasourceImpl(this.firestoreService);
  @override
  Future<List<ProductModel>> getremoteProducts( String path1, String path2,String documentId) {
    return firestoreService.getProducts( path1, path2,documentId);
  }
}