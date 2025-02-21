import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:flutter/material.dart';

class ContainerAges extends StatelessWidget {
  const ContainerAges({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.authCubit,
  });

  final double screenHeight;
  final double screenWidth;
  final AuthinticationCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.07,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: AppColors.secondBackground),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              authCubit.selectedAge ?? 'Select Age',
              style: TextStyle(
                color: AppColors.background,
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: AppColors.background,
            size: screenWidth * 0.06,
          ),
        ],
      ),
    );
  }
}
