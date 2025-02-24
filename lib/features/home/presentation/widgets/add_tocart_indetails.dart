import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/cart/data/models/cart_item_model.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/home/presentation/widgets/details_view_body.dart';
import 'package:clothshop/features/orders/domain/entities/addtocart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddToCartInDetails extends StatelessWidget {
  const AddToCartInDetails({
    super.key,
    required this.selectedSize,
    required this.selectedColor,
    required this.widget,
  });

  final String? selectedSize;
  final String? selectedColor;
  final DetailsViewBody widget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is Addtocart) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to cart successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is CartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return state is CartLoading
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () {
                  final userId = FirebaseAuth.instance.currentUser?.uid;
                  
                  if (userId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please sign in to add items to cart'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (selectedSize == null || selectedColor == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select size and color'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  context.read<CartCubit>().addToCart(
                    CartItemModel(
                      product: widget.product.toModel(),
                      quantity: 1,
                      totalPrice: widget.product.price.toDouble(),
                    ),
                    userId,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.product.price}',
                        style: TextStyles.textinhome,
                      ),
                      const Text(
                        'Add to Cart',
                        style: TextStyles.textinhome,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}