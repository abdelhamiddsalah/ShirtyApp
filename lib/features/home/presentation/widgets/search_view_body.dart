import 'package:clothshop/constants/images.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:clothshop/features/home/presentation/widgets/dropdown_in_search.dart';
import 'package:clothshop/features/home/presentation/widgets/gridview_for_products.dart';
import 'package:clothshop/features/home/presentation/widgets/textfield_in_search.dart';
import 'package:clothshop/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  late TextEditingController textController;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => sl<ProductsCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
              vertical: screenHeight * 0.03,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: screenWidth * 0.14,
                        height: screenHeight * 0.064,
                        decoration: BoxDecoration(
                          color: AppColors.secondBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Expanded(
                      child: Material(
                        type: MaterialType.transparency,
                        child: TextFieldSearch(
                          title: 'Search',
                          textController: textController, // تمرير المتغير هنا
                          focusNode: focusNode, // تمرير focusNode هنا
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.primary,
                            size: screenWidth * 0.05,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              textController.clear();
                              focusNode.unfocus(); // إلغاء التركيز عند الضغط
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.primary,
                              size: screenWidth * 0.05,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
    mainAxisAlignment: MainAxisAlignment.start,
  children: [
    DropDownForChoiceInSearch(screenWidth: screenWidth, text1: 'Price'),
    SizedBox(width: screenWidth * 0.02),
    DropDownForChoiceInSearch(screenWidth: screenWidth, text1: 'Sizes'),
    SizedBox(width: screenWidth * 0.02),
    DropDownForChoiceInSearch(screenWidth: screenWidth, text1: 'Colors'),
  ],
),
                SizedBox(height: screenHeight * 0.03),
                Expanded(
                  child: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsLoaded) {
                        return state.products.isEmpty
                            ? notFound()
                            : GridViewForProducts(products: state.products);
                      } else if (state is ProductsError) {
                        return Center(child: Text(state.message));
                      } else {
                        return Center(child: Container());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget notFound() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.imagesNotFound),
        const SizedBox(height: 20),
        Text(
          'Sorry, We could not find any matching results for your search',
          style: TextStyles.textinhome,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigator.pushNamed(context, Routes.c);
          },
          child: Text('Explore Categories', style: TextStyles.textinhome),
        ),
      ],
    ),
  );
}