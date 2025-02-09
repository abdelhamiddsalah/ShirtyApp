import 'package:clothshop/core/widgets/custom_bottom_nav.dart';
import 'package:clothshop/features/home/presentation/widgets/custom_appbar.dart';
import 'package:clothshop/features/home/presentation/widgets/home_categories.dart';
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
      bottomNavigationBar: CustomBottomNav(),
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
                CustomAppbarinhome(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomTextFormField(
                  title: 'Search',
                  prefixIcon: Icon(Icons.search, size: screenWidth * 0.06),
                ),
                SizedBox(height: screenHeight * 0.02),
                HomeCategories(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextsInHomeview(text: 'Top Selling'),
                SizedBox(height: screenHeight * 0.02),
                TopsellingListview(screenHeight: screenHeight),
                SizedBox(height: screenHeight * 0.02),
                TextsInHomeview(text: 'New In', color: AppColors.primary),
                SizedBox(height: screenHeight * 0.02),
                TopsellingListview(screenHeight: screenHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
