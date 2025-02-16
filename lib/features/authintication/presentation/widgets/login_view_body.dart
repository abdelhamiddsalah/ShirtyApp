import 'package:clothshop/config/extentions/extension.dart';
import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/app_strings.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/validations/validation.dart';
import 'package:clothshop/core/widgets/applogo.dart';
import 'package:clothshop/core/widgets/custom_textfield.dart';
import 'package:clothshop/core/widgets/rows_in_auth.dart';
import 'package:clothshop/features/authintication/domain/entities/login_entity.dart';
import 'package:clothshop/features/authintication/presentation/cubit/logincubit/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// ... rest of imports stay the same

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (state is LoginFailure) {
          errormessage(context, state.message);
        }
      },
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                // Top Container with Logo
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.25,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [AppLogo()],
                    ),
                  ),
                ),
                
                Positioned(
                  top: screenHeight * 0.19,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: screenHeight * 0.4,
                      maxHeight: screenHeight * 0.8,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.02,
                        ),
                        child: Form(
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}