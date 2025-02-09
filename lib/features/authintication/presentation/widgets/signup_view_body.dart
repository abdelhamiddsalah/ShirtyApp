import 'package:clothshop/core/validations/validation.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:clothshop/config/extentions/extension.dart';
import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/services/firebase_auth_services.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/app_strings.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/core/widgets/applogo.dart';
import 'package:clothshop/core/widgets/custom_textfield.dart';
import 'package:clothshop/core/widgets/rows_in_auth.dart';
import 'package:clothshop/features/authintication/data/repositories/auth_repositry_impl.dart';
import 'package:clothshop/features/authintication/domain/usecases/ages_usecase.dart';
import 'package:clothshop/features/authintication/presentation/cubit/agescubit/cubit/ages_cubit.dart';
import 'package:clothshop/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:clothshop/features/authintication/presentation/widgets/dropdown_ages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return BlocConsumer<AuthinticationCubit, AuthinticationState>(
      listener: (context, state) {
        if (state is AuthinticationSuccess) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (state is AuthinticationFailure) {
          errormessage(context, state.message);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthinticationCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is AuthinticationLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.25,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
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
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: screenHeight * 0.7,
                      maxHeight: screenHeight * 0.8,
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.02,
                        ),
                        child: Form(
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
                                child: Dropdownages(),
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