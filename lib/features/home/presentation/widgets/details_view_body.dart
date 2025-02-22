// ignore_for_file: library_private_types_in_public_api
import 'package:clothshop/features/home/presentation/widgets/add_tocart_indetails.dart';
import 'package:clothshop/features/home/presentation/widgets/container_quantity_details.dart';
import 'package:clothshop/features/home/presentation/widgets/products_options_details.dart';
import 'package:clothshop/features/home/presentation/widgets/reviews_in_details.dart';
import 'package:flutter/material.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';

class DetailsViewBody extends StatefulWidget {
  final ProductEntity product;
  const DetailsViewBody({super.key, required this.product});

  @override
  _DetailsViewBodyState createState() => _DetailsViewBodyState();
}

class _DetailsViewBodyState extends State<DetailsViewBody> {
  String? selectedColor;
  String? selectedSize;
  double averageRating = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateAverageRating();
  }

  void _calculateAverageRating() {
    if (widget.product.reviews.isNotEmpty) {
      averageRating =
          widget.product.reviews
              .map((review) => review.rating)
              .reduce((a, b) => a + b) /
          widget.product.reviews.length;
    } else {
      averageRating = 0.0;
    }
  }

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
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth,
              height: screenHeight * 0.5,
              color: Colors.white,
              child: Image.network(
                widget.product.image,
                height: screenHeight * 0.5,
                width: screenWidth * 0.9,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              children: [
                const Text('Name: ', style: TextStyles.textinhome),
                const Spacer(),
                Text(
                  widget.product.name.toString(),
                  style: TextStyles.textinhome.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              children: [
                const Text('Price: ', style: TextStyles.textinhome),
                const Spacer(),
                Text(
                  '\$${widget.product.price}',
                  style: TextStyles.textinhome.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            ProductOptionsDisplay(
              title: 'Sizes',
              options: widget.product.sizes.cast<String>(),
              selectedOption: selectedSize,
              onOptionSelected: (option) {
                setState(() {
                  selectedSize = option;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.01),
            ProductOptionsDisplay(
              title: 'Colors',
              options: widget.product.colors.cast<String>(),
              selectedOption: selectedColor,
              onOptionSelected: (option) {
                setState(() {
                  selectedColor = option;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            ContainerQuantityInDetails(
              text1: 'Quantity',
              product: widget.product,
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              widget.product.description.toString(),
              style: TextStyles.textinhome.copyWith(
                color: Colors.grey,
                fontSize: screenWidth * 0.038,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text('Shipping & Returns', style: TextStyles.textinhome),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Free Standard Shipping and free 60 day returns',
              style: TextStyles.textinhome.copyWith(
                color: Colors.grey,
                fontSize: screenWidth * 0.038,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            ReviewsInDetails(widget: widget, screenHeight: screenHeight, averageRating: averageRating),
            SizedBox(height: screenHeight * 0.03),
            AddToCartInDetails(selectedSize: selectedSize, selectedColor: selectedColor, widget: widget),
          ],
        ),
      ),
    );
  }
}