import 'package:clothshop/features/home/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clothshop/features/home/data/models/category_model.dart';

class FirestoreService {
  final FirebaseFirestore firestore;

  FirestoreService(this.firestore);

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('categories').get();
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }

  Future<List<ProductModel>> getProducts(String path1, String path2,String documentId) async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection(path1).doc(documentId).collection(path2).get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
