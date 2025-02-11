// category_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clothshop/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel(
     {
    required super.image,
    required super.title, required super.productPath, required super.id,
  });

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    if (data.isEmpty) {
      throw Exception("No data found for the category");
    }
    return CategoryModel(
      image: data['imageUrl'] ?? '',
      title: data['title'] ?? '',
     productPath:  data['productPath'] ?? '', id: doc.id,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json, String documentId) {
    return CategoryModel(
      
      image: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      productPath: json['productPath'] ?? '', id: documentId, // قراءة المسار من JSON
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': image,
        'title': title,
   'productPath': productPath, // تضمين المسار في JSON
      };
}