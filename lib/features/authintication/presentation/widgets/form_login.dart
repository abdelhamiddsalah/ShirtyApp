import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/utils/app_strings.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/validations/validation.dart';
import 'package:clothshop/core/widgets/custom_textfield.dart';
import 'package:clothshop/core/widgets/rows_in_auth.dart';
import 'package:clothshop/features/authintication/domain/entities/login_entity.dart';
import 'package:clothshop/features/authintication/presentation/cubit/logincubit/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({
    super.key,
    required this.cubit,
    required this.screenHeight,
  });

  final LoginCubit cubit;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.signinname,
            style: TextStyles.authtitle.copyWith(
              fontSize: screenHeight * 0.03,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.email,
            controller: cubit.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: Validation.validateEmail,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.password,
            obscureText: context.watch<LoginCubit>().isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            validator: Validation.validatePassword,
            controller: cubit.passwordController,
            suffixIcon: IconButton(
              icon: Icon(
                context.watch<LoginCubit>().isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                cubit.togglePasswordVisibility();
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgetpassword);
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyles.authtitle.copyWith(fontSize: screenHeight * 0.02),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (cubit.formkey.currentState!.validate()) {
                  cubit.login(
                    LoginEntity(
                      email: cubit.emailController.text,
                      password: cubit.passwordController.text,
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
          ),
          SizedBox(height: screenHeight * 0.03),
          RowsInAuth(
            text1: 'Don\'t have an account?',
            text2: AppStrings.signupname,
            onPressed: () async {
              Navigator.pushNamed(context, Routes.register);
            },
          ),
        ],
      ),
    );
  }
}