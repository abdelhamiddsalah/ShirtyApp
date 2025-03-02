import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerIncart extends StatelessWidget {
  final CartItemEntity cartItemEntity;
  final VoidCallback onRemove;
  final int index;

  const ContainerIncart({
    super.key,
    required this.onRemove,
    required this.cartItemEntity,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        // Use a key that includes all unique identifiers
        final uniqueKey = Key('${cartItemEntity.id}_${cartItemEntity.selectedSize}_${cartItemEntity.selectedColor}');
        
        return Dismissible(
          key: uniqueKey,
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary,
            ),
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            // Call onRemove which should handle both UI and data updates
            onRemove();
          },
          child: Container(
            // Rest of your container code remains the same
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 140,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                Image.network(
                  cartItemEntity.image,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItemEntity.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text('Size: ${cartItemEntity.selectedSize}'),
                      const SizedBox(height: 5),
                      Text('Color: ${cartItemEntity.selectedColor}'),
                      const SizedBox(height: 5),
                      Text(
                        '\$${cartItemEntity.price}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      cartItemEntity.quantity.toString(),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}