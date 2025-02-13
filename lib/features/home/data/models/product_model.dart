import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/reviews/data/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel extends ProductEntity{
  ProductModel({
    required super.categoryId,
    required super.productId,
   required super.name, 
   required super.price, 
   required super.image, 
   required super.quantity, 
   required super.ratingcount, 
   required super.sizes, 
   required super.description, 
   required super.colors, 
   required super.category, 
   required super.reviews});

   factory ProductModel.fromJson(Map<String, dynamic> json,String documentId) {
    return ProductModel(
      productId: documentId ,
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
      ratingcount: json['ratingcount'],
      sizes: json['size'],
      description: json['description'],
      colors: json['colors'],
      category: json['category'],
        reviews: (json['reviews'] as List<dynamic>?)
              ?.map((review) => ReviewModel.fromJson(review))
              .toList() ??
          [],
           categoryId: json['categoryId'],
    );
  }

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    if (data.isEmpty) {
      throw Exception("No data found for the category");
    }
    return ProductModel(
      productId: doc.id,
      name: data['name'],
      price: data['price'],
      image: data['image'],
      quantity: data['quantity'],
      ratingcount: data['ratingcount'],
      sizes: List<String>.from(data['size']),  // تأكد أنها List
      description: data['description'],
      colors: List<String>.from(data['colors']),
      category: data['category'],
      reviews: data['reviews'], 
      categoryId: data['categoryId'],
    );
  }

  toJson(){
    return {
      'categoryId': categoryId,
      'productId': productId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
      'ratingcount': ratingcount,
      'size': sizes,
      'description': description,
      'colors': colors,
      'category': category,
      'reviews': reviews,
    };
  }



}