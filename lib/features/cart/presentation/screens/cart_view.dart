import 'package:clothshop/features/cart/presentation/widgets/cart_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          // Pass the cart items to CartViewBody when state is loaded
          return CartViewBody(cartItems: state.cart.items);
        } else {
          // Show loading or empty state
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}