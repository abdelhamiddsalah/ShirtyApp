import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/reviews/data/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel extends ProductEntity{
  ProductModel({
    required super.categoryId,
    required super.collectionName,
    required super.productId,
   required super.name, 
   required super.price, 
   required super.image, 
   required super.quantity, 
   required super.ratingcount, 
   required super.size, 
   required super.description, 
   required super.color, 
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
      size: json['size'],
      description: json['description'],
      color: json['color'],
      category: json['category'],
        reviews: (json['reviews'] as List<dynamic>?)
              ?.map((review) => ReviewModel.fromJson(review))
              .toList() ??
          [], collectionName: json['collectionName'], categoryId: json['categoryId'],
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
      size: data['size'],
      description: data['description'],
      color: data['color'],
      category: data['category'],
      reviews: data['reviews'], collectionName: data['collectionName'], categoryId: data['categoryId'],
    );
  }

  toJson(){
    return {
      'categoryId': categoryId,
      collectionName: collectionName,
      'productId': productId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
      'ratingcount': ratingcount,
      'size': size,
      'description': description,
      'color': color,
      'category': category,
      'reviews': reviews,
    };
  }



}