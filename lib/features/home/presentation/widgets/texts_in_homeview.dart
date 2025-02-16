import 'package:clothshop/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class TextsInHomeview extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onTap;
  const TextsInHomeview({super.key, required this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyles.textinhome.copyWith(color: color )),
        GestureDetector(
          onTap: onTap,
          child: const Text('See All', style: TextStyles.seealltext)),
      ],
    );
  }
}