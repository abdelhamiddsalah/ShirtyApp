import 'package:clothshop/features/reviews/domain/entities/review_entity.dart';
import 'package:equatable/equatable.dart';


// STATES
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