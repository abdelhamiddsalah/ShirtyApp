import 'package:clothshop/core/widgets/activebar_items.dart';
import 'package:clothshop/core/widgets/inactive_bottom_navbaritems.dart';
import 'package:clothshop/features/home/domain/entities/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class NavigationbarItems extends StatelessWidget {
  const NavigationbarItems({super.key, required this.isSelected, required this.bottomNavBar});
   final bool isSelected;
   final BottomNavBar bottomNavBar;
  @override
  Widget build(BuildContext context) {
    return isSelected?  ActivItem(
      assetName: bottomNavBar.activeImage
    ) :  InactiveItems(assetName: bottomNavBar.inactiveImage);
      }
}