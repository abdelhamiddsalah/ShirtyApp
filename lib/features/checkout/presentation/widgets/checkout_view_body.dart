import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/core/widgets/appbartop.dart';
import 'package:clothshop/core/widgets/bottom_partin_cartandcheckout.dart';
import 'package:clothshop/features/checkout/presentation/widgets/field_checkout.dart';
import 'package:flutter/material.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Appbartop(),
          SizedBox(height: screenHeight * 0.05),
          FieldCheckout(text1: 'Shipping Address', text2: 'Add Shipping Address'),
          SizedBox(height: screenHeight * 0.05),
          FieldCheckout(text1: 'Payment Method', text2: 'Add Payment Method'),
          SizedBox(height: screenHeight * 0.05),

          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                // إنشاء كائن CartEntity من البيانات الموجودة في Cubit
             //   final cartEntity = state.cartEntity;

                return BottomPartIncartandcheckout(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
