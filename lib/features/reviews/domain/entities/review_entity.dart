import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String name;
  final String review;
  final int rating;
  final String productId;

  const ReviewEntity({
    required this.id,
    required this.name,
    required this.review,
    required this.rating,
    required this.productId,
  });

  @override
  List<Object> get props => [id, name, review, rating, productId];
}