import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InactiveItems extends StatelessWidget {
  const InactiveItems({super.key, required this.assetName});

  final String assetName;
  @override
  Widget build(BuildContext context) {
    final screenhight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return SvgPicture.asset(assetName, height: screenhight * 0.03, width: screenwidth * 0.05,);
  }
}