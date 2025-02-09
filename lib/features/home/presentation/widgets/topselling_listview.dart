import 'package:clothshop/core/widgets/product_item.dart';
import 'package:flutter/material.dart';

class TopsellingListview extends StatelessWidget {
  const TopsellingListview({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(), // تغيير الـ physics للسماح بالـ scroll
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product_details');
            },
            child: ProductItem(
              productName: 'Product ${index + 1}',
              price: 29.99,
            ),
          ),
        ),
      ),
    );
  }
}