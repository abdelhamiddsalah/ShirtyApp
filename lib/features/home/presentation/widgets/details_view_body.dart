import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/widgets/filled_container.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class DetailsViewBody extends StatelessWidget {
  final ProductEntity product;
  const DetailsViewBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, screenWidth),
            SizedBox(height: screenHeight * 0.02),
            _buildProductImage(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.03),
            _buildProductInfo(),
            SizedBox(height: screenHeight * 0.03),
            _buildCustomContainer(screenWidth, screenHeight, 'Size', trailing: Row(
              children: [Text('S', style: TextStyles.textinhome), Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey)],
            )),
            SizedBox(height: screenHeight * 0.03),
            _buildCustomContainer(screenWidth, screenHeight, 'Color', trailing: Row(
              children: [Container(height: screenHeight * 0.05, width: screenWidth * 0.05, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)), Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey)],
            )),
            SizedBox(height: screenHeight * 0.03),
            _buildQuantityContainer(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.03),
            _buildDescription(),
            SizedBox(height: screenHeight * 0.03),
            _buildShippingInfo(),
            SizedBox(height: screenHeight * 0.03),
            _buildReviewsSection(context),
            SizedBox(height: screenHeight * 0.04),
            _buildAddToCartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double screenWidth) {
    return Row(
      children: [
        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios)),
        Spacer(),
        FilledConatiner(icon: Icons.favorite_border, screenWidth: screenWidth * 0.9),
      ],
    );
  }

  Widget _buildProductImage(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.5,
      color: Colors.white,
      child: Image.network(product.image!, height: screenHeight * 0.5, width: screenWidth * 0.9),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name.toString(), style: TextStyles.textinhome),
        SizedBox(height: 10),
        Text('\$${product.price}', style: TextStyles.textinhome.copyWith(color: AppColors.primary)),
      ],
    );
  }

  Widget _buildQuantityContainer(double screenWidth, double screenHeight) {
    return _buildCustomContainer(screenWidth, screenHeight, 'Quantity', trailing: Row(
      children: [
        FilledConatiner(icon: Icons.add, screenWidth: screenWidth * 0.9),
        SizedBox(width: screenWidth * 0.04),
        Text('0', style: TextStyles.textinhome),
        SizedBox(width: screenWidth * 0.04),
        FilledConatiner(icon: Icons.remove, screenWidth: screenWidth * 0.9),
      ],
    ));
  }

  Widget _buildCustomContainer(double screenWidth, double screenHeight, String text, {required Widget trailing}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      height: screenHeight * 0.09,
      width: screenWidth,
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(text, style: TextStyles.textinhome), trailing],
      ),
    );
  }

  Widget _buildDescription() {
    return Text(product.description!, style: TextStyles.textinhome.copyWith(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w100));
  }

  Widget _buildShippingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shipping & Returns', style: TextStyles.textinhome),
        SizedBox(height: 10),
        Text('Free Standard Shipping and free 60-day Returns', style: TextStyles.textinhome.copyWith(color: Colors.grey, fontSize: 16)),
      ],
    );
  }

  Widget _buildReviewsSection( context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reviews', style: TextStyles.textinhome),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.reviewspage,arguments: {
    'productId': product.productId,
    'categoryId': product.categoryId,
  },);
              },
              child: Text('See All', style: TextStyles.seealltext.copyWith(color: AppColors.primary))),
          ],
        ),
        SizedBox(height: 10),
        Text('4.5 Ratings', style: TextStyles.textinhome),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('\$${product.price}', style: TextStyles.textinhome),
          Text('Add to Cart', style: TextStyles.textinhome),
        ],
      ),
    );
  }
}