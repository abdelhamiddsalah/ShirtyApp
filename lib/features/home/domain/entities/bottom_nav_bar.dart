import 'package:clothshop/constants/images.dart';

class BottomNavBar {
  final String activeImage, inactiveImage;
  BottomNavBar({required this.activeImage, required this.inactiveImage});
}

List<BottomNavBar> bottomNavBar = [
  BottomNavBar(
      activeImage: Assets.imagesHome2,
      inactiveImage: Assets.imagesUnhome2),
  BottomNavBar(
      activeImage: Assets.imagesNoootificationbing,
      inactiveImage: Assets.imagesUnnotificationbing),
  BottomNavBar(
      activeImage: Assets.imagesReceipt1,
      inactiveImage: Assets.imagesUnreceipt1),
  BottomNavBar(
    activeImage: Assets.imagesProfile,
     inactiveImage: Assets.imagesUnprofile
     ),
    ];