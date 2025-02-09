// ignore_for_file: sort_child_properties_last
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/widgets/navbar_items.dart';
import 'package:clothshop/features/home/domain/entities/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {

  int index = 0;
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: bottomNavBar.asMap().entries.map((entry) {
          var index = entry.key;
          var bottomNavBar = entry.value;
          return GestureDetector(
            child: NavigationbarItems(
              bottomNavBar: bottomNavBar,
              isSelected: index == this.index,
            ),
          );
        }).toList()
      ),
      height: screenheight * 0.07,
      width: screenwidth,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(screenwidth * 0.05),
          topRight: Radius.circular(screenwidth * 0.05),
        ),
        boxShadow: [ 
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,       
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ]
      )
    );
  }
}
