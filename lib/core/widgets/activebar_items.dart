import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivItem extends StatelessWidget {
  const ActivItem({super.key, required this.assetName});
final String assetName ;
  @override
  Widget build(BuildContext context) {
    final screenhight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenhight * 0.03,
      width: screenwidth * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(assetName),
    );
  }
}