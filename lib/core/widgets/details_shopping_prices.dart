import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/features/cart/domain/entities/cart_entity.dart';
import 'package:flutter/material.dart';

class DetailsAboutShoppingPrices extends StatelessWidget {
  const DetailsAboutShoppingPrices({
    super.key,
    required this.cart,
  });

  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: 20,
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
          // الإجمالي والشحن
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('SubTotal:', style: TextStyle(fontSize: 16)),
              Text(
                '\$${cart.subtotal.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Shipping:', style: TextStyle(fontSize: 16)),
              Text(
                '\$${cart.shippingCost.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total:', style: TextStyle(fontSize: 16)),
              Text(
                '\$${cart.total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
    
          Divider(
            thickness: 1,
            color: Colors.grey.shade300,
            height: 20,
          ),
    
          // زر الدفع
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // اضف هنا منطق الدفع
              },
              child: const Text('Checkout', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
