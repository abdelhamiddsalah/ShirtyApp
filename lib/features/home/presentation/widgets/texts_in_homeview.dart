import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:clothshop/features/home/presentation/widgets/shop_by_categories.dart';
import 'package:clothshop/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextsInHomeview extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onTap;

  const TextsInHomeview({
    super.key, 
    required this.text, 
    this.color, 
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text, 
          style: TextStyles.textinhome.copyWith(color: color)
        ),
        GestureDetector(
          onTap: () {
            // Create a new instance of CategoriesCubit
            //final categoriesCubit = sl<CategoriesCubit>();
            
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShopByCategories(),
              ),
            );
          },
          child: const Text('See All', style: TextStyles.seealltext),
        ),
      ],
    );
  }
}