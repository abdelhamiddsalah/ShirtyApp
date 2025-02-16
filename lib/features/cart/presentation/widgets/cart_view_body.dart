import 'package:clothshop/core/widgets/details_shopping_prices.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:clothshop/features/cart/domain/entities/cart_entity.dart';
import 'package:clothshop/features/cart/presentation/widgets/container_in_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});
  //final List<CartItemEntity> cartItems;

  @override
  Widget build(BuildContext context) {
    // final cart = CartEntity(items: cartItems);

    return BlocBuilder<CartCubit, CartEntity>(
      builder: (context, cart) {
         print('CartViewBody rebuild - Items in cart: ${cart.products.length}');
        if (cart.products.isEmpty) {
          return const Center(
            child: Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }
    
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.06,
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Column(
              children: [
                // العنوان
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    const Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
    
                // عرض عناصر السلة
                Expanded(
                  child: ListView.builder(
                    
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                        final product = cart.products[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: ContainerIncart(
                          index: index,
                          cartItem: product,
                          onRemove: () {
                            context.read<CartCubit>().removeFromCart(product.productId);
                          },
                        ),
                      );
                    },
                  ),
                ),
    
                // الحاوية السفلية (الإجمالي والشحن + زر الدفع)
                DetailsAboutShoppingPrices(cart: cart),
              ],
            ),
          ),
        );
      },
    );
  }
}
