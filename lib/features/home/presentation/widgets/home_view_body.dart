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
    final safeHorizontalPadding = screenWidth * 0.03;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// ✅ الـ App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: safeHorizontalPadding,
                ),
                child: CustomAppbarinhome(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
              ),
            ),
    
            /// ✅ البحث
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: safeHorizontalPadding,
                vertical: screenHeight * 0.02,
              ),
              sliver: SliverToBoxAdapter(
                child: InkWell(
                  onTap:
                      () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const SearchView(),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      ),
                  child: IgnorePointer(
                    child: CustomTextFormField(
                      readOnly: true,
                      title: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        size: screenWidth * 0.06,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    
            /// ✅ الفئات (Categories)
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: safeHorizontalPadding,
              ),
              sliver: SliverToBoxAdapter(
                child: HomeCategories(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
              ),
            ),
    
            /// ✅ "Top Selling" العنوان
            SliverPadding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: safeHorizontalPadding,
              ),
              sliver: const SliverToBoxAdapter(
                child: TextsInHomeview(text: 'Top Selling'),
              ),
            ),
    
            /// ✅ قائمة المنتجات الأكثر مبيعًا
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              sliver: SliverToBoxAdapter(
                child: TopsellingListview(screenHeight: screenHeight),
              ),
            ),
    
            /// ✅ "New In" العنوان
            SliverPadding(
              padding: EdgeInsets.only(left: safeHorizontalPadding),
              sliver: const SliverToBoxAdapter(
                child: TextsInHomeview(
                  text: 'New In',
                  color: AppColors.primary,
                ),
              ),
            ),
    
            /// ✅ قائمة المنتجات الجديدة
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              sliver: SliverToBoxAdapter(
                child: NewInProducts(screenHeight: screenHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
