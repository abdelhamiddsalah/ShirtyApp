
import 'package:clothshop/core/widgets/appbartop.dart';
import 'package:clothshop/core/widgets/details_shopping_prices.dart';
import 'package:clothshop/features/cart/domain/entities/cart_entity.dart';
import 'package:clothshop/features/checkout/presentation/widgets/field_checkout.dart';
import 'package:flutter/material.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});
// final CartEntity cart;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.05, vertical: screenHeight*0.05),
        child: Column(
          children: [
            const Appbartop(),
            SizedBox(height: screenHeight * 0.05),
            const FieldCheckout(text1: 'Shipping Address', text2: 'Add Shipping Address'),
            SizedBox(height: screenHeight * 0.05),
            const FieldCheckout(text1: 'Payment Method', text2: 'Add Payment Method'),
            SizedBox(height: screenHeight * 0.05),
          //  DetailsAboutShoppingPrices(cart: cart,)
        
          
             
            
          ],
        ),
      ),
    );
  }
}
