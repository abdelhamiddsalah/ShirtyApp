import 'package:clothshop/features/reviews/domain/entities/review_entity.dart';

class ProductEntity {
  final String name;
  final String productId;
  final String categoryId;
  final num price;
  final String image;
  int quantity;
  double ratingcount; 
  final List<String> sizes; 
  final String description;
  final List<String> colors; 
  final String category;
  final List<ReviewEntity> reviews;
  int? salescount;

  ProductEntity({
    this.salescount,
    required this.categoryId,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.ratingcount,
    required this.sizes,
    required this.description,
    required this.colors,
    required this.category,
    required this.reviews,
  });
}
