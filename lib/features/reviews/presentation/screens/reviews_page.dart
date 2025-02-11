import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/features/reviews/domain/entities/review_entity.dart';
import 'package:clothshop/features/reviews/presentation/widgets/add_review_view_body.dart';
import 'package:clothshop/features/reviews/presentation/widgets/reviews_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:clothshop/injection.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key, required this.review});
 final ReviewEntity review;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReviewsCubit>(param1:  review.productId, param2:  review.categoryId)..getReviews(),
      child: Navigator(
        onGenerateRoute: (settings) {
          if (settings.name == Routes.addreviews) {
            return MaterialPageRoute(
              builder: (context) => const AddReviewViewBody(),
            );
          }
          return MaterialPageRoute(
            builder: (context) => const ReviewsViewBody(),
          );
        },
      ),
    );
  }
}