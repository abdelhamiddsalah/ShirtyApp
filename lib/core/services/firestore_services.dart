import 'package:clothshop/features/home/data/models/product_model.dart';
import 'package:clothshop/features/reviews/data/models/review_model.dart';
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

  Future<List<ProductModel>> getProducts(String categoryId) async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('Allproducts').where('categoryId', isEqualTo: categoryId).get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }

 Future<List<ReviewModel>> getProductReviews(String productId) async {
  try {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Allproducts')
        .doc(productId)
        .get();

    if (!doc.exists) {
      throw Exception("Product not found");
    }

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List<ReviewModel> reviews = (data['reviews'] as List<dynamic>?)
            ?.map((review) => ReviewModel.fromJson(review))
            .toList() ??
        [];
    return reviews;
  } catch (e) {
    throw Exception("Error fetching reviews: $e");
  }
}


  Future<void> addReview(String productId, ReviewModel review) async {
  try {
    DocumentReference productRef =
        FirebaseFirestore.instance.collection('Allproducts').doc(productId);

    await productRef.update({
      'reviews': FieldValue.arrayUnion([review.toJson()])
    });
  } catch (e) {
    throw Exception("Error adding review: $e");
  }
}

}
