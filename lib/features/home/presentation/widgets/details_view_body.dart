import 'package:clothshop/features/home/presentation/widgets/container_quantity_details.dart';
import 'package:clothshop/features/home/presentation/widgets/products_options_details.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:clothshop/features/reviews/presentation/widgets/reviews_view_body.dart';
import 'package:clothshop/injection.dart';
import 'package:flutter/material.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/widgets/filled_container.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                const Spacer(),
                FilledConatiner(
                  icon: Icons.favorite_border,
                  screenWidth: screenWidth * 0.9,
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
            Row(
              children: [
                const Text('Reviews', style: TextStyles.textinhome),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ReviewsView(product: widget.product),
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: TextStyles.textinhome.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              children: [
                widget.product.reviews.isNotEmpty
                    ? RatingBarIndicator(
                      rating: averageRating,
                      itemBuilder:
                          (context, index) =>
                              const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 24.0,
                    )
                    : RatingBarIndicator(
                      rating: averageRating,
                      itemBuilder:
                          (context, index) =>
                              const Icon(Icons.star, color: Colors.grey),
                      itemCount: 5,
                      itemSize: 24.0,
                    ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),

            BlocProvider(
              create: (context) => sl<OrdersCubit>(),
              child: BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  return  
                  state is OrdersLoading ? const CircularProgressIndicator() : ElevatedButton(
                  onPressed: () {
  if (selectedSize == null || selectedColor == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select size and color')),
    );
    return;
  }

  context.read<OrdersCubit>().addtocart(AddtocartModel(
    productId: widget.product.productId,
    quantity: 1, 
    productname: widget.product.name,
    mainprice: widget.product.price.toDouble(),
    productimage: widget.product.image,
    productSelectedcolor: selectedColor!,
    productSelectedsize: selectedSize!,
    createDate: DateTime.now().toString(),
    totalprice: widget.product.price.toDouble(),
     widget.product.salescount??1
  ));
},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.product.price}',
                          style: TextStyles.textinhome,
                        ),
                        const Text('Add to Cart', style: TextStyles.textinhome),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
