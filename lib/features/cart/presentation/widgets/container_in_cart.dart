import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flutter/material.dart';

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
    return Dismissible(
      key: Key(cartItemEntity.productId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        onRemove();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Image.network(cartItemEntity.productimage, width: 80, height: 80),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItemEntity.productname, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Size - ${cartItemEntity.productSelectedsize}'),
                    const SizedBox(width: 10),
                    Text('Color - ${cartItemEntity.productSelectedcolor}'),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${cartItemEntity.mainprice}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                     //   context.read<CartCubit>().decreaseQuantity(cartItemEntity.product);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration:  const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.remove, color: Colors.white, size: 15),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        //context.read<CartCubit>().increaseQuantity(cartItemEntity.product);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.add, color: Colors.white, size: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}