import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/checkout/presentation/screens/checkout_view.dart';
import 'package:clothshop/core/utils/app_colors.dart';

class DetailsAboutShoppingPrices extends StatelessWidget {
  final List<CartItemEntity> cartItems;
  final CartCubit cartCubit;
  final String text1;
  final void Function()? onPressed;

  const DetailsAboutShoppingPrices({
    super.key,
    required this.cartItems,
    required this.cartCubit, required this.text1, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final total = cartItems.fold(
      0.0,
      (previousValue, element) => previousValue + element.totalPrice,
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      decoration: const BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          _buildPriceRow('SubTotal:', total, screenWidth),
          SizedBox(height: screenHeight * 0.02),
          _buildPriceRow('Shipping:', 0.0, screenWidth),
          SizedBox(height: screenHeight * 0.02),
          _buildPriceRow('Total:', total, screenWidth),
          Divider(thickness: 1, color: Colors.grey.shade300, height: 20),
          _buildCheckoutButton(context, screenHeight, screenWidth),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(
    BuildContext context,
    double screenHeight,
    double screenWidth,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: cartCubit,
                child: const CheckoutView(),
              ),
            ),
          );
        },
        child: Text(
          text1,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: screenWidth * 0.04)),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}