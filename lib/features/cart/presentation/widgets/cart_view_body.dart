import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/cart/presentation/widgets/container_in_cart.dart';
import 'package:flutter/material.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('Cart', style: TextStyles.authtitle),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Remove all'),
              ],
            ),
            SizedBox(height: 20,),
            ContainerIncart(
            productId: '1',
            productName: 'T-Shirt',
            size: 'M',
            color: 'Black',
            onRemove: () {
              
            }, price: 20.0,
            ),
            Spacer(),
             ElevatedButton(onPressed: () {}, child: Text('Checkout'))
          ],
        ),
      ),
    );
  }
}