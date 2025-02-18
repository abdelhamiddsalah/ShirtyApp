import 'package:clothshop/core/widgets/appbartop.dart';
import 'package:clothshop/core/widgets/details_shopping_prices.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/checkout/presentation/widgets/address_bottomsheet.dart';
import 'package:clothshop/features/checkout/presentation/widgets/field_checkout.dart';
import 'package:clothshop/features/checkout/presentation/widgets/payment_bottomsheet.dart';
import 'package:clothshop/features/payments/payment_manager.dart';
import 'package:clothshop/features/payments/paymob_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';

class CheckoutViewBody extends StatefulWidget {
  final List<CartItemEntity> cartItems;
  
  const CheckoutViewBody({super.key, required this.cartItems});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  String _selectedAddress = 'Add Shipping Address';
  String _selectedPayment = 'Add Payment Method';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.05,
        ),
        child: Column(
          children: [
            const Appbartop(),
            SizedBox(height: screenHeight * 0.05),
            FieldCheckout(
              text1: 'Shipping Address',
              text2: _selectedAddress,
              onTap: () => _showAddressBottomSheet(context),
            ),
            SizedBox(height: screenHeight * 0.03),
            FieldCheckout(
              text1: 'Payment Method',
              text2: _selectedPayment,
              onTap: () => _showPaymentBottomSheet(context),
            ),
            const Spacer(),
            DetailsAboutShoppingPrices(
              text1: 'Pay Now',
              onPressed: () {
                
              },
              cartItems: widget.cartItems,
              cartCubit: context.read<CartCubit>(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddressBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddressBottomSheet(),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedAddress = '${result['address']}, ${result['city']}\n${result['state']}, ${result['zip']}';
      });
    }
  }

  Future<void> _showPaymentBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const PaymentMethodBottomSheet(),
    );

    if (result != null) {
      setState(() {
        _selectedPayment = result == 'stripe' ? 'Pay with Stripe' : 'Pay with Paymob';
      });
      
      // Handle payment method selection
      switch (result) {
        case 'stripe':
          await PaymentManager.makePayment(100, 'USD');
          break;
        case 'paymob':
          //Uri.parse(PaymobManager().(100, 'EGP'));
          break;
      }
    }
  }
}