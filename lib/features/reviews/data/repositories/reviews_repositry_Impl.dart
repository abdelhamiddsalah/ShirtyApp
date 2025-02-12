// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/reviews/domain/repositories/reviews_repositry.dart';

import '../../domain/entities/review_entity.dart';
import '../models/review_model.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final FirebaseFirestore firestore;

  ReviewsRepositoryImpl(this.firestore);

  @override
  Future<Either<Failure, List<ReviewEntity>>> getProductReviews(String productId) async {
    try {
      final docSnapshot = await firestore
          .collection('Allproducts')
          .doc(productId)
          .get();

      if (!docSnapshot.exists) {
        return Left(ServerFailure('Product not found'));
      }

      final data = docSnapshot.data();
      if (data == null || !data.containsKey('reviews')) {
        return const Right([]);
      }

      final reviewsList = (data['reviews'] as List<dynamic>)
          .map((reviewData) => ReviewModel.fromJson(reviewData as Map<String, dynamic>))
          .toList();

      return Right(reviewsList);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch reviews: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addReview(ReviewEntity review) async {
    try {
      final reviewModel = ReviewModel.fromEntity(review);
      final productRef = firestore.collection('Allproducts').doc(review.productId);
      
      // Get the current document
      final docSnapshot = await productRef.get();
      if (!docSnapshot.exists) {
        return Left(ServerFailure( 'Product not found'));
      }

      // Add the new review to the reviews array using arrayUnion
      await productRef.update({
        'reviews': FieldValue.arrayUnion([reviewModel.toJson()])
      });

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Failed to add review: $e'));
    }
  }
}