import 'package:clothshop/features/reviews/domain/entities/review_entity.dart';
import 'package:clothshop/features/reviews/domain/usecases/reviews_usecase.dart';
import 'package:clothshop/features/reviews/presentation/cubit/reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsUsecase reviewsUsecase;
  final TextEditingController reviewController;
  final TextEditingController nameController;
  final String productId;
  double selectedRating = 0;
  final formkey = GlobalKey<FormState>();

  ReviewsCubit({
    required this.reviewsUsecase,
    required this.reviewController,
    required this.nameController,
    required this.productId,
  }) : super(ReviewsInitial()) {
    getReviews();
  }

  Future<void> getReviews() async {
    if (productId.isEmpty) {
      emit(const ReviewsError(message: 'Product ID is missing'));
      return;
    }

    emit(ReviewsLoading());
    final result = await reviewsUsecase.getReviews(productId);

    result.fold(
      (failure) => emit(ReviewsError(message: failure.message)),
      (reviews) => emit(ReviewsLoaded(reviews: reviews)),
    );
  }

  Future<void> addReview(ReviewEntity review) async {
    if (productId.isEmpty) {
      emit(const ReviewsError(message: 'Product ID is missing'));
      return;
    }

    // Get current reviews
    List<ReviewEntity> currentReviews = [];
    if (state is ReviewsLoaded) {
      currentReviews = List.from((state as ReviewsLoaded).reviews);
    }

    // Add new review to the beginning of the list
    currentReviews.insert(0, review);
    
    // Update UI immediately
    emit(ReviewsLoaded(reviews: currentReviews));

    // Send to API
    final result = await reviewsUsecase.addReview(review, productId);

    result.fold(
      (failure) {
        // Remove the review if API call fails
        currentReviews.removeWhere((r) => r.id == review.id);
        emit(ReviewsLoaded(reviews: currentReviews));
        emit(ReviewsError(message: failure.message));
      },
      (_) {
        // Clear the form
        reviewController.clear();
        nameController.clear();
        selectedRating = 0;
      },
    );
  }
}