import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class FieldCheckout extends StatelessWidget {
  const FieldCheckout({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return Container(
       width: double.infinity,
       height: screenHight*0.06,
       decoration: BoxDecoration(
         color: AppColors.secondBackground,
         borderRadius: BorderRadius.circular(10),
       ),
       child: Row(
        children: [
         Column(
          children: [
            Text(text1, style: TextStyles.textinhome,),
            SizedBox(height: screenHight*0.01,),
            Text(text2, style: TextStyles.textinhome,),
          ],
         ),
         Spacer(),
         Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
       ]),
    );
  }
}