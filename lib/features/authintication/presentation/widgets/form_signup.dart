import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/services/firebase_auth_services.dart';
import 'package:clothshop/core/utils/app_strings.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/validations/validation.dart';
import 'package:clothshop/core/widgets/custom_textfield.dart';
import 'package:clothshop/core/widgets/rows_in_auth.dart';
import 'package:clothshop/features/authintication/data/repositories/auth_repositry_impl.dart';
import 'package:clothshop/features/authintication/domain/usecases/ages_usecase.dart';
import 'package:clothshop/features/authintication/presentation/cubit/agescubit/cubit/ages_cubit.dart';
import 'package:clothshop/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:clothshop/features/authintication/presentation/widgets/dropdown_ages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormSignup extends StatelessWidget {
  const FormSignup({
    super.key,
    required this.cubit,
    required this.screenHeight,
  });

  final AuthinticationCubit cubit;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.signupname,
            style: TextStyles.authtitle.copyWith(
              fontSize: screenHeight * 0.03,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.firstname,
            controller: cubit.firstnameController,
            validator: Validation.validateName,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.lastname,
            controller: cubit.lastnameController,
            validator: Validation.validateName,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.email,
            controller: cubit.emailController,
            validator: Validation.validateEmail,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.password,
            obscureText: context.watch<AuthinticationCubit>().isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            validator: Validation.validatePassword,
            controller: cubit.passwordController,
            suffixIcon: IconButton(
              icon: Icon(
                context.watch<AuthinticationCubit>().isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                cubit.togglePasswordVisibility();
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          BlocProvider(
            create: (context) => AgesCubit(
              AgesUsecase(
                AuthRepositryImpl(
                  firebaseAuthServices: FirebaseAuthServices(),
                ),
              ),
            ),
            child: const Dropdownages(),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.signup();
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
            text1: 'Already have an account?',
            text2: AppStrings.signinname,
            onPressed: () {
              Navigator.pushNamed(context, Routes.login);
            },
          ),
        ],
      ),
    );
  }
}