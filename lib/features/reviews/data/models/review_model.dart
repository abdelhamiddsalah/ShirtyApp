import 'package:clothshop/features/reviews/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.name,
    required super.review,
    required super.rating,
    required super.productId,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      review: json['review'] ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 0,  // تحويل إلى int لمنع أخطاء الأنواع
      productId: json['productId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'review': review,
      'rating': rating,
      'productId': productId,
    };
  }
}