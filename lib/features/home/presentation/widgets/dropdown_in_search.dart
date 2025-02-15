import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class DropDownForChoiceInSearch extends StatelessWidget {
  const DropDownForChoiceInSearch({
    super.key,
    required this.screenWidth, required this.text1,
  });

  final double screenWidth;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.25,
      height: screenWidth * 0.1, // تأكد من أن العرض والارتفاع متساويان ليكون الشكل دائريًا
      decoration: BoxDecoration(
        color: Colors.transparent, // الخلفية شفافة
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary, width: 2), // حدود شفافة قليلاً
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text1,
              style: TextStyles.textinhome.copyWith(
                fontSize: screenWidth * 0.04,
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}