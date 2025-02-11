import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/reviews/domain/repositories/reviews_repositry.dart';
import 'package:dartz/dartz.dart';
import '../entities/review_entity.dart';

class ReviewsUsecase {
  final ReviewsRepository repository;

  ReviewsUsecase(this.repository);

  Future<Either<Failure, List<ReviewEntity>>> getReviews(String productId) {
    return repository.getProductReviews(productId);
  }

  Future<Either<Failure, Unit>> addReview(ReviewEntity review) {
    return repository.addReview(review);
  }
}