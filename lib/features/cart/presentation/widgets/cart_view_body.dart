
import 'package:clothshop/core/widgets/details_shopping_prices.dart';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/cart/presentation/widgets/container_in_cart.dart';
import 'package:go_router/go_router.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider.value(
      value: sl<CartCubit>(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: screenWidth * 0.06,
            left: screenWidth * 0.03,
            right: screenWidth * 0.03,
          ),
          child: Column(
            children: [
              _buildHeader(context),
              SizedBox(height: screenHight * 0.02),
              BlocConsumer<CartCubit, CartState>(
                listener: (context, state) {
                  // Listener for cart state changes if needed
                },
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CartError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is CartLoaded) {
                    return Expanded(
                      child: Column(
                        children: [
                          _buildCartCount(state.cartItems.length),
                          _buildCartList(context, state.cartItems),
                         DetailsAboutShoppingPrices(
  text1: 'Checkout',
  cartItems: state.cartItems,
  cartCubit: context.read<CartCubit>(),
  onCheckoutPressed: () async{
    await context.push('/checkout');
 await   context.read<CartCubit>().clearCart();
  },
),

                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      const Text(
        'Cart',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget _buildCartCount(int itemCount) {
  return BlocBuilder<CartCubit, CartState>(
    builder: (context, state) {
      final count = state is CartLoaded ? state.cartItems.length : 0;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have $count items in your cart'),
        ],
      );
    },
  );
}

Widget _buildCartList(BuildContext context, List<CartItemEntity> cartItems) {
  return Expanded(
    child: cartItems.isEmpty
        ? const Center(child: Text('Your cart is empty'))
        : ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                child: ContainerIncart(
                  index: index,
                  onRemove: () {
                    // Make sure to pass the correct parameters
                    context.read<CartCubit>().deletecart(
                      item.id.toString(),
                      item.selectedSize.toString(),
                      item.selectedColor.toString()
                    );
                    print('Item removed from cart: ${item.id}');
                  },
                  cartItemEntity: item,
                ),
              );
            },
          ),
  );
}