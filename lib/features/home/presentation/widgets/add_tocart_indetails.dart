import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/cart/data/models/cart_item_model.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
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
    super.key,
    required this.widget,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity,
  });

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

  final productscubit = context.read<ProductsCubit>();
  final cartCubit = context.read<CartCubit>();

  // إنشاء عنصر السلة
  final cartItem = CartItemModel(
    selectedColor: selectedColor!,
    selectedSize: selectedSize!,
    quantity: quantity,
    totalPrice: cartCubit.calculateUpdatedTotalPrice(
      widget.product.price.toDouble(),
      quantity,
    ),
    name: widget.product.name,
    image: widget.product.image,
    price: widget.product.price.toDouble(),
    id: widget.product.productId,
  );

  // إضافة المنتج إلى السلة وإظهار رسالة نجاح
  cartCubit.addToCart(cartItem, userId).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product added to cart successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  });

  productscubit.incrementSalesCount(widget.product.productId);
},

      child: const Row(
        children: [
          Icon(Icons.add_shopping_cart,color: Colors.white,),
          Spacer(),
          Text('Add to Cart',style: TextStyles.textinhome,),
        ],
      ),
    );
  }
}
