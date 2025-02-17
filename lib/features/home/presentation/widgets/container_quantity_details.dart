import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:clothshop/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerQuantityInDetails extends StatelessWidget {
  const ContainerQuantityInDetails({
    super.key,
    required this.text1,
    required this.product,
  });

  final String text1;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => sl<OrdersCubit>(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
  builder: (context, state) {
    int quantity = state is OrdersLoaded ? state.quantity : 0; // ✅ التأكد من حالة الكيوبت

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1, style: TextStyles.textinhome),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<OrdersCubit>().decreasecount();
                },
                child: Container(
                  width: screenWidth * 0.07,
                  height: screenHeight * 0.07,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
              ),
              SizedBox(width: screenWidth * 0.05),
              Text(
                quantity.toString(), // ✅ عرض الكمية المحدثة بشكل صحيح
                style: TextStyles.textinhome,
              ),
              SizedBox(width: screenWidth * 0.05),
              GestureDetector(
                onTap: () {
                  context.read<OrdersCubit>().increasecount();
                },
                child: Container(
                  width: screenWidth * 0.07,
                  height: screenHeight * 0.07,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  },
)

    );
  }
}
