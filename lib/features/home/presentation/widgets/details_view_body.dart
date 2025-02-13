import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/widgets/filled_container.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';

class DetailsViewBody extends StatelessWidget {
  final ProductEntity product;
  const DetailsViewBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenHeight * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Spacer(),
                FilledConatiner(
                  icon: Icons.favorite_border,
                  screenWidth: screenWidth * 0.9,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth,
              height: screenHeight * 0.5,
              color: Colors.white,
              child: Image.network(
                product.image!,
                height: screenHeight * 0.5,
                width: screenWidth * 0.9,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(product.name.toString(), style: TextStyles.textinhome),
            SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: TextStyles.textinhome.copyWith(color: AppColors.primary),
            ),
            SizedBox(height: screenHeight * 0.03),
            ProductColorsDisplay(
              product: product,
              onColorSelected: (selectedColor) {
                print('Selected color: $selectedColor');
              },
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              onPressed: () {
                context.read<CartCubit>().addToCart(product);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${product.price}', style: TextStyles.textinhome),
                  Text('Add to Cart', style: TextStyles.textinhome),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductColorsDisplay extends StatelessWidget {
  final ProductEntity product;
  final Function(String) onColorSelected;

  const ProductColorsDisplay({
    Key? key,
    required this.product,
    required this.onColorSelected,
  }) : super(key: key);

  List<String> getColors() {
    if (product.colors == null) return [];
    
    // تحويل List? إلى List<String>
    return List<String>.from(product.colors!.map((color) => color.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final colors = getColors();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Colors:', style: TextStyles.textinhome),
        SizedBox(height: 10),
        if (colors.isEmpty)
          Text(
            'No colors available',
            style: TextStyles.textinhome.copyWith(color: Colors.grey),
          )
        else
          Container(
            width: screenWidth,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: colors.map((color) => InkWell(
                onTap: () => onColorSelected(color),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    color,
                    style: TextStyles.textinhome.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
      ],
    );
  }
}