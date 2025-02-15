import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldSearch extends StatelessWidget {
  final String title;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextEditingController? textController; // استقبال المتغير
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const TextFieldSearch({
    super.key,
    required this.title,
    this.obscureText,
    this.suffixIcon,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
    this.textController,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController, // استخدم الـ Controller الممرر
      focusNode: focusNode, // استخدم FocusNode الممرر
      autofocus: true,
      onChanged: (value) {
        context.read<ProductsCubit>().getAllProducts(value);
      },
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
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
