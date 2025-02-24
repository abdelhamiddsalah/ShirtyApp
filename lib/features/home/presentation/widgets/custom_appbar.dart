// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/widgets/filled_container.dart';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomAppbarinhome extends StatelessWidget {
  const CustomAppbarinhome({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
   //  final cartCubit = sl<CartCubit>(); 
    return SizedBox(
      height: screenHeight * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Image Section
          BlocProvider(
            create: (context) => sl<ProfileCubit>(),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                String? imagePath;
                if (state is ImagePicked) {
                  imagePath = state.imagePath;
                } else {
                  imagePath = context.read<ProfileCubit>().prefs.getString(
                    ProfileCubit.KEY_PROFILE_IMAGE,
                  );
                }
    
                return GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: screenHeight * 0.03,
                    backgroundImage:
                        imagePath != null
                            ? FileImage(File(imagePath))
                            : const AssetImage(
                                  'assets/default_profile_image.png',
                                )
                                as ImageProvider,
                    backgroundColor: AppColors.secondBackground,
                  ),
                );
              },
            ),
          ),
    
          // Men Text Container
          Container(
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.01,
            ),
            child: Text(
              'Men',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
    
          // Cart Icon
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  context.push(Routes.cart);
                },
                child: Stack(
                  children: [
                    FilledConatiner(
                      screenWidth: screenWidth,
                      icon: Icons.shopping_bag_outlined,
                    ),
                 
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                         '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
