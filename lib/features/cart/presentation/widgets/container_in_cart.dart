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
      key: Key(cartItemEntity.product.productId.toString()),
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
        onRemove();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 140,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            Image.network(cartItemEntity.product.image, width: 80, height: 80),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItemEntity.product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text('Size: ${cartItemEntity.product.sizes[0]}'),
                  const SizedBox(height: 5),
                  Text('Color: ${cartItemEntity.product.colors[0]}'),
                  const SizedBox(height: 5),
                  Text('\$${cartItemEntity.product.price}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // context.read<CartCubit>().increaseQuantity(cartItemEntity.product);
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
                const SizedBox(height: 8),
                Text('2'), // TODO: استبدلها بالكمية الفعلية من الـ Cubit
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // context.read<CartCubit>().decreaseQuantity(cartItemEntity.product);
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.remove, color: Colors.white, size: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
