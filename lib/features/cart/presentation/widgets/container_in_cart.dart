import 'package:clothshop/constants/images.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerIncart extends StatelessWidget {
  final String productId;
  final String productName;
  final String size;
  final String color;
  final double price;
  final VoidCallback onRemove;

  const ContainerIncart({
    super.key,
    required this.productId,
    required this.productName,
    required this.size,
    required this.color,
    required this.price,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(productId), // مفتاح فريد لكل منتج
      direction: DismissDirection.endToStart, // سحب فقط من اليمين لليسار
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
        onRemove(); // حذف المنتج من القائمة
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
            Image.asset(Assets.imagesProfile),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productName, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Size - $size'),
                    const SizedBox(width: 10),
                    Text('Color - $color'),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$$price'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // قم بإنقاص العدد هنا
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
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        // قم بزيادة العدد هنا
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
