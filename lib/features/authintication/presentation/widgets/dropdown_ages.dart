import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/features/authintication/presentation/cubit/agescubit/cubit/ages_cubit.dart';
import 'package:clothshop/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/features/authintication/presentation/widgets/ages.dart';

class Dropdownages extends StatelessWidget {
  const Dropdownages({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<AuthinticationCubit, AuthinticationState>(
      builder: (context, state) {
        var authCubit = context.read<AuthinticationCubit>();
        return GestureDetector(
          onTap: () {
            final agesCubit = context.read<AgesCubit>();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(screenWidth * 0.04),
                ),
              ),
              builder: (context) {
                return SizedBox(
                  height: screenHeight * 0.7,
                  child: BlocProvider.value(
                    value: agesCubit..getAges(),
                    child: Ages(
                      onAgeSelected: (age) {
                        authCubit.updateSelectedAge(age);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: BlocBuilder<AuthinticationCubit, AuthinticationState>(
            builder: (context, state) {
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
            },
          ),
        );
      },
    );
  }
}
