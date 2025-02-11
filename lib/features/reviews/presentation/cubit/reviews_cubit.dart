import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/usecases/reviews_usecase.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsUsecase reviewsUsecase;
  final TextEditingController reviewController;
  final TextEditingController nameController;
  final String productId;
  final String categoryId;
  double rating = 0.0;
  final formKey = GlobalKey<FormState>();

  ReviewsCubit(
    this.reviewsUsecase,
    this.reviewController,
    this.nameController,
    this.productId,
    this.categoryId,
  ) : super(ReviewsInitial());

  void setRating(double value) {
    rating = value;
    emit(ReviewsRatingUpdated(rating));
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

  Future<bool> submitReview(BuildContext context) async {
    if (!formKey.currentState!.validate()) return false;
    if (rating == 0.0) {
      emit(const ReviewsError(message: 'Please select a rating'));
      return false;
    }

    final review = ReviewEntity(
      id: const Uuid().v4(),
      productId: productId,
      categoryId: categoryId,
      name: nameController.text,
      review: reviewController.text,
      rating: rating.round(),
    );

    emit(ReviewsLoading());
    final result = await reviewsUsecase.addReview(review);

    return result.fold(
      (failure) {
        emit(ReviewsError(message: failure.message));
        return false;
      },
      (_) async {
        await getReviews();
        if (context.mounted) {
          nameController.clear();
          reviewController.clear();
          rating = 0.0;
          Navigator.pop(context);
        }
        return true;
      },
    );
  }
}
