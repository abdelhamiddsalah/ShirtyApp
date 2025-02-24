import 'package:clothshop/features/cart/data/models/cart_item_model.dart';
import 'package:clothshop/features/home/data/models/product_model.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/reviews/data/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clothshop/features/home/data/models/category_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    DocumentSnapshot doc = await firestore.collection('Allproducts').doc(productId).get();

    if (!doc.exists || doc.data() == null) {
      throw Exception("Product not found or has no reviews");
    }

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<ReviewModel> reviews = [];

    if (data.containsKey('reviews') && data['reviews'] is List) {
      reviews = (data['reviews'] as List)
          .map((review) => ReviewModel.fromJson(review))
          .toList();

      // **ترتيب المراجعات بالأحدث أولًا**
      reviews.sort((a, b) => b.timestamp.compareTo(a.timestamp));  
    }

    return reviews;
  } catch (e) {
    throw Exception("Error fetching reviews: $e");
  }
}



  Future<void> addReview(String productId, ReviewModel review) async {
  try {
    DocumentReference productRef = FirebaseFirestore.instance.collection('Allproducts').doc(productId);

    DocumentSnapshot doc = await productRef.get();
    if (!doc.exists) {
      throw Exception("Product not found");
    }

    await productRef.update({
      'reviews': FieldValue.arrayUnion([review.toJson()])
    });
  } catch (e) {
    throw Exception("Error adding review: $e");
  }
}


Future<List<ProductModel>> fetchnewinProducts() async{
   try{
    final result =await firestore.collection('Allproducts').where('createdate',isGreaterThanOrEqualTo: Timestamp.fromDate(
      DateTime(2025, 1, 1)
    )).orderBy('createdate',descending: true).limit(10).get();
    return result.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
   }
   catch(e){
    throw Exception("Error fetching products: $e");
   }
}

Future<List<ProductModel>> getproductsBytitle(String name) async{
   try{
    final result =await firestore.collection('Allproducts').where('name',isEqualTo: name).get();

    return result.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
   }
   catch(e){
    throw Exception("Error fetching products: $e");
   }
}

Future<List<ProductModel>> getallproducts(String query) async {
  try {
    final collection = firestore.collection('Allproducts');
    
    // تصفية المنتجات بناءً على البحث إن كان هناك نص مدخل
    final result = query.isEmpty 
        ? null
        : await collection.where('name', isGreaterThanOrEqualTo: query)
                         .where('name', isLessThanOrEqualTo: '$query\uf8ff')
                         .get() as QuerySnapshot;

    return result?.docs.map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList() ?? [];
  } catch (e) {
    throw Exception("Error fetching products: $e");
  }
}

Future<List<ProductModel>> getSearchProductsByPrice() async {
  try {
    final result = await firestore.collection('Allproducts').where('price', isGreaterThanOrEqualTo: 50).get();
    return result.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  } catch (e) {
    throw Exception("Error fetching products: $e");
  }

}

Future<Either> addToCart(AddtocartModel addtocartModel) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null) {
      return Left('User is not authenticated. Please sign in.');
    }

    print("User ID: ${user.uid}");
    
    await firestore.collection('Users').doc(user.uid).collection('cart').add(addtocartModel.toJson());

    return const Right('Product added to cart successfully');
  } catch (e) {
    return Left("Error adding product to cart: $e");
  }
}

Future<List<CartItemModel>> getCarts() async {
  try {
    var user =FirebaseAuth.instance.currentUser;
    var result = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid) // استخدم userId لتحديد المستخدم الصحيح
        .collection('cart')
        .get();

    return result.docs
        .map((doc) => CartItemModel.fromJson(doc.data()))
        .toList();
  } catch (e) {
    print('Error fetching carts: $e');
    return []; // إرجاع قائمة فارغة بدلاً من حدوث كراش
  }
}

Future<void> deleteCart(String cartId) async {
  try {
    var user =FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid) // استخدم userId لتحديد المستخدم الصحيح
        .collection('cart')
        .doc(cartId)
        .delete();
  } catch (e) {
    print('Error deleting cart: $e');
  }
}
Future<List<ProductModel>> getatopSalesproducts() async {
  try {
    final collection = firestore.collection('Allproducts');
    
    // تصفية المنتجات بناءً على البحث إن كان هناك نص مدخل
    final result = 
        
        await collection.where('salescount', isGreaterThanOrEqualTo: 5).limit(10)
                         .get() as QuerySnapshot;

    return result.docs.map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList();
  } catch (e) {
    throw Exception("Error fetching products: $e");
  }
}


}
