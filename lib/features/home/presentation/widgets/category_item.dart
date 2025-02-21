import 'package:flutter/material.dart';
import 'package:clothshop/features/home/domain/entities/category_entity.dart';
import 'package:clothshop/features/home/presentation/widgets/products_gridview.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;
  final double screenWidth;
  final double screenHeight;

  const CategoryItem({super.key, required this.category, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductsGridView(categoryId: category.id)),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: screenWidth * 0.05),
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.13,
              height: screenWidth * 0.13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(category.image.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              category.title.toString(),
              style: TextStyle(fontSize: screenWidth * 0.035),
            ),
          ],
        ),
      ),
    );
  }
}
