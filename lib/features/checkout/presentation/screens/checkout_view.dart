import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return BlocProvider(
            create: (context) => sl<CheckoutCubit>(),
           // child: CheckoutViewBody(cartItems: state.cartItems),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
