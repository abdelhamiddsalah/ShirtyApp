import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ContainerQuantityInDetails extends StatelessWidget {
  const ContainerQuantityInDetails({super.key, required this.text1});
  final String text1;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        ),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(text1, style: TextStyles.textinhome,),
        Row(
          children: [
            Container(
              width: screenWidth * 0.07,
              height: screenHeight * 0.07,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.remove, color: Colors.white,),
            ),
            SizedBox(width: screenWidth * 0.05,),
            Text('1', style: TextStyles.textinhome,),
            SizedBox(width: screenWidth * 0.05,),
            Container(
              width: screenWidth * 0.07,
              height: screenHeight * 0.07,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white,),
            ),
          ],
        )
      ]),
    );
  }
}