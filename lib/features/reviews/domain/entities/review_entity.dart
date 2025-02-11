import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String name;
  final String review;
  final String productId;
  final String categoryId;
  final int rating;

  const ReviewEntity({
    required this.id,
    required this.name,
    required this.review,
    required this.rating,
    required this.productId,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [id, name, review, rating, productId, categoryId];
}