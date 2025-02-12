import 'package:clothshop/features/reviews/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.name,
    required super.review,
    required super.rating,
    required super.productId,
    required super.categoryId,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      review: json['review'] ?? '',
      rating: (json['rating'] ?? 0).toInt(),
    );
  }

  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
      id: entity.id,
      name: entity.name,
      review: entity.review,
      rating: entity.rating,
      productId: entity.productId,
      categoryId: entity.categoryId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'categoryId': categoryId,
      'name': name,
      'review': review,
      'rating': rating,
    };
  }
}