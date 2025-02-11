part of 'reviews_cubit.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<ReviewEntity> reviews;
  
  const ReviewsLoaded({required this.reviews});

  @override
  List<Object> get props => [reviews];
}

class ReviewsError extends ReviewsState {
  final String message;
  
  const ReviewsError({required this.message});

  @override
  List<Object> get props => [message];
}

class ReviewsRatingUpdated extends ReviewsState {
  final double rating;
  
  const ReviewsRatingUpdated(this.rating);

  @override
  List<Object> get props => [rating];
}