import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/home/presentation/widgets/products_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:clothshop/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:clothshop/features/home/presentation/widgets/category_item_shape.dart';
import 'package:clothshop/features/home/presentation/widgets/texts_in_homeview.dart';

class HomeCategories extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  
  const HomeCategories({super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextsInHomeview(text: 'Categories',onTap: () {
          Navigator.pushNamed(context, Routes.shopbycategories);
        },),
        SizedBox(height: screenHeight * 0.026),
        BlocProvider(
          create: (context) => sl<CategoriesCubit>()..fetchCategories(),
          child: SizedBox(
            height: screenHeight * 0.12,
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[700]!,
                      highlightColor: Colors.white,
                      period: const Duration(seconds: 2),
                      direction: ShimmerDirection.ltr,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => CtegoryShapeItem(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ),
                    ),
                  );
                } else if (state is CategoriesLoaded) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return GestureDetector(
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsGridView(
                           categoryId: category.id
                         )));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.05),
                          child: Column(
                            children: [
                              Container(
                                width: screenWidth * 0.13,
                                height: screenWidth * 0.13,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(category.image.toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                category.title.toString(),
                                style: TextStyle(fontSize: screenWidth * 0.035),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'Error loading categories',
                      style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.red),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
