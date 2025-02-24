import 'package:clothshop/core/utils/app_strings.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/authintication/domain/entities/signup_entity.dart';
import 'package:clothshop/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
    required this.cubit,
  });

  final AuthinticationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (cubit.formKey.currentState!.validate()) {
            cubit.signup(
              SignupEntity(
                firstname: cubit.firstnameController.text,
                lastname: cubit.lastnameController.text,
                email: cubit.emailController.text,
                password: cubit.passwordController.text,
                age: cubit.selectedAge!,
                ''
              ),
            );
          }
        },
        child: Text(
          AppStrings.continueText,
          style: TextStyles.authtitle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}