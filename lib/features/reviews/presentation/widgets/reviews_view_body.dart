import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/reviews/presentation/cubit/reviews_cubit.dart';

class ReviewsViewBody extends StatelessWidget {
  const ReviewsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      children: [
                        Text(
                          'Reviews',
                          style: TextStyles.authtitle.copyWith(
                            fontSize: screenWidth * 0.06,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Expanded(
                      child: BlocBuilder<ReviewsCubit, ReviewsState>(
                        builder: (context, state) {
                          if (state is ReviewsLoaded) {
                            return ListView.builder(
                              padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                              itemCount: state.reviews.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  color: Colors.white.withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          state.reviews[index].name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          state.reviews[index].review,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: List.generate(
                                            state.reviews[index].rating,
                                            (i) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (state is ReviewsError) {
                            return Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: screenHeight * 0.03,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.addreviews);
                  },
                  child: Text(
                    'Add Review',
                    style: TextStyles.textinhome,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}