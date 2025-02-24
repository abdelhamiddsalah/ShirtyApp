import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerQuantityInDetails extends StatelessWidget {
  const ContainerQuantityInDetails({
    super.key,
    required this.text1,
    required this.product,
  });

  final String text1;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1, style: TextStyles.textinhome),
          Row(
            children: [
              _QuantityButton(
                icon: Icons.remove,
                onTap: () {
                  if (userId != null) {
                    context.read<CartCubit>().decrementQuantity(
                      CartItemEntity(
                        product: product,
                        quantity: product.quantity,
                        totalPrice: product.price.toDouble() * product.quantity,
                      ),
                      userId,
                    );
                  }
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(width: screenWidth * 0.05),
              BlocSelector<CartCubit, CartState, int>(
                selector: (state) {
                  if (state is CartLoaded) {
                    final cartItem = state.cartItems.firstWhere(
                      (item) => item.product.productId == product.productId,
                      orElse: () => CartItemEntity(
                        product: product,
                        quantity: 0,
                        totalPrice: 0,
                      ),
                    );
                    return cartItem.quantity;
                  }
                  return 0;
                },
                builder: (context, quantity) {
                  return Text(
                    '$quantity',
                    style: TextStyles.textinhome,
                  );
                },
              ),
              SizedBox(width: screenWidth * 0.05),
              _QuantityButton(
                icon: Icons.add,
                onTap: () {
                  if (userId != null) {
                    context.read<CartCubit>().incrementQuantity(
                      CartItemEntity(
                        product: product,
                        quantity: product.quantity,
                        totalPrice: product.price.toDouble() * product.quantity,
                      ),
                      userId,
                    );
                  }
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onTap,
    required this.screenWidth,
    required this.screenHeight,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.07,
        height: screenHeight * 0.07,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}