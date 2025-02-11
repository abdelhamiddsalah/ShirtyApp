import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/reviews/presentation/cubit/reviews_cubit.dart';

class AddReviewViewBody extends StatelessWidget {
  const AddReviewViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenhight = MediaQuery.of(context).size.height;
    
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        var cubit = context.read<ReviewsCubit>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenhight * 0.08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Review', style: TextStyles.textinhome),
                  SizedBox(height: screenhight * 0.02),
                  Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: cubit.nameController,
                          decoration: InputDecoration(labelText: "Your Name"),
                          validator: (value) =>
                              value!.isEmpty ? "Enter Your Name" : null,
                        ),
                        SizedBox(height: screenhight * 0.02),
                        TextFormField(
                          controller: cubit.reviewController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: "Your Review",
                          ),
                          validator: (value) =>
                              value!.isEmpty ? "Enter Your Review" : null,
                        ),
                        SizedBox(height: screenhight * 0.02),
                        Text("Rate:", style: TextStyle(fontSize: 16)),
                        SizedBox(height: screenhight * 0.02),
                        RatingBar.builder(
                          initialRating: cubit.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) => cubit.setRating(rating),
                        ),
                        SizedBox(height: screenhight * 0.04),
                        ElevatedButton(
                          onPressed: () async {
                            await cubit.submitReview(context);
                          },
                          child: Text(
                            "Submit Review",
                            style: TextStyles.textinhome,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
