import 'package:clothshop/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final bool? obscureText; // اجعلها غير قابلة لأن تكون null
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    required this.title,
    this.obscureText , this.controller, this.suffixIcon, this.keyboardType, this.prefixIcon, this.validator, // القيمة الافتراضية هنا
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller:controller ,
      obscureText: obscureText?? false, // لن يحدث خطأ لأن القيمة مضمونة
      decoration: InputDecoration(
        prefixIcon:prefixIcon ,
        suffixIcon: suffixIcon,
        hintText: title,
        hintStyle: TextStyles.authtitle.copyWith(
          fontSize: 16,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
