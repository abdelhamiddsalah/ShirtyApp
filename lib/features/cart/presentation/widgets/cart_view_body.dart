import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/core/widgets/details_shopping_prices.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/cart/presentation/widgets/container_in_cart.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartError) {
            return Center(child: Text(state.message));
          }
          if (state is CartLoaded) {
            return _buildLoadedState(context, state);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, CartLoaded state) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        top: screenWidth * 0.06,
        left: screenWidth * 0.03,
        right: screenWidth * 0.03,
      ),
      child: Column(
        children: [
          _buildHeader(context),
          SizedBox(height: screenHeight * 0.02),
          _buildCartCount(state),
          _buildCartList(context, state),
          if (state.cartItems.isNotEmpty)
            DetailsAboutShoppingPrices(
              text1: 'Checkout',
              cartItems: state.cartItems,
              cartCubit: context.read<CartCubit>(),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
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
    );
  }

  Widget _buildCartCount(CartLoaded state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('You have ${state.cartItems.length} items in your cart'),
      ],
    );
  }

  Widget _buildCartList(BuildContext context, CartLoaded state) {
    return Expanded(
      child: state.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: ContainerIncart(
                    index: index,
                    onRemove: () {
                      context.read<CartCubit>().deletecart(
                            state.cartItems[index].productId,
                          );
                    },
                    cartItemEntity: state.cartItems[index],
                  ),
                );
              },
            ),
    );
  }
}
