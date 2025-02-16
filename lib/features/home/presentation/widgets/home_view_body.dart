import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/features/home/presentation/screens/search_view.dart';
import 'package:clothshop/features/home/presentation/widgets/custom_appbar.dart';
import 'package:clothshop/features/home/presentation/widgets/home_categories.dart';
import 'package:clothshop/features/home/presentation/widgets/new_in_products.dart';
import 'package:clothshop/features/home/presentation/widgets/topselling_listview.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/widgets/custom_textfield.dart';
import 'package:clothshop/features/home/presentation/widgets/texts_in_homeview.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final safeVerticalPadding = screenHeight * 0.02;
    final safeHorizontalPadding = screenWidth * 0.03;

    return Scaffold(
    //  bottomNavigationBar: salmon(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: safeHorizontalPadding,
              vertical: safeVerticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.search),
                  child: CustomAppbarinhome(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
           InkWell(
  onTap: () => Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => const SearchView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  ),
  child: IgnorePointer( // لمنع التفاعل مع TextFormField نفسه
    child: CustomTextFormField(
      readOnly: true,
      title: 'Search',
      prefixIcon: Icon(Icons.search, size: screenWidth * 0.06),
    ),
  ),
),


                SizedBox(height: screenHeight * 0.02),
                HomeCategories(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
                SizedBox(height: screenHeight * 0.02),
                const TextsInHomeview(text: 'Top Selling'),
                SizedBox(height: screenHeight * 0.02),
                TopsellingListview(screenHeight: screenHeight),
                SizedBox(height: screenHeight * 0.02),
                const TextsInHomeview(text: 'New In', color: AppColors.primary),
                SizedBox(height: screenHeight * 0.02),
                NewInProducts(screenHeight: screenHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
