import 'package:clothshop/features/cart/data/models/cart_item_model.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/home/presentation/widgets/details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddToCartInDetails extends StatelessWidget {
  final DetailsViewBody widget;
  final String? selectedSize;
  final String? selectedColor;
  final int quantity;
  
  const AddToCartInDetails({
    Key? key,
    required this.widget,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     onPressed: () {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please sign in to add items to cart'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
  
  if (selectedSize == null || selectedColor == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select size and color'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
  
  final cartCubit = context.read<CartCubit>();
  // Check if the exact same product with same size and color exists
  final existingItemIndex = cartCubit.cartItems.indexWhere(
    (item) => 
      item.id == widget.product.productId &&
      item.selectedSize == selectedSize &&
      item.selectedColor == selectedColor,
  );
  
  // Create cart item with the specified quantity
  final cartItem = CartItemModel(
    selectedColor: selectedColor!,
    selectedSize: selectedSize!,
    quantity: quantity, // Use the quantity from the UI
    totalPrice: cartCubit.calculateUpdatedTotalPrice(
      widget.product.price.toDouble(),
      quantity,
    ),
    name: widget.product.name,
    image: widget.product.image,
    price: widget.product.price.toDouble(),
    id: widget.product.productId,
  );
  
  // Add to cart with the quantity from UI
  cartCubit.addToCart(cartItem, userId);
},
      child: const Row(
        children: [
          Icon(Icons.add_shopping_cart),
          Spacer(),
          Text('Add to Cart'),
        ],
      ),
    );
  }
}