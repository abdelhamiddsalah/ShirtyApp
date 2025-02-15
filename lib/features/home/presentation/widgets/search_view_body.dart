import 'package:clothshop/constants/images.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/widgets/product_item.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:clothshop/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

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
                        child: TextFieldSearch(title: 'Search'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Expanded(
                  child: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsLoaded) {
                        return state.products.isEmpty
                            ? notFound()
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: state.products.length,
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.secondBackground,
                                  ),
                                  child: Center(
                                    child: ProductItem(
                                      productEntity: state.products[index],
                                    ),
                                  ),
                                ),
                              );
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
          onPressed: () {},
          child: Text('Explore Categories', style: TextStyles.textinhome),
        ),
      ],
    ),
  );
}

class TextFieldSearch extends StatelessWidget {
  final String title;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const TextFieldSearch({
    super.key,
    required this.title,
    this.obscureText,
    this.suffixIcon,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        context.read<ProductsCubit>().getAllProducts(value);
      },
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: title,
        hintStyle: TextStyles.authtitle.copyWith(
          fontSize: 16,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
