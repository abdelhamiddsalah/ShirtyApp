import 'package:clothshop/core/widgets/position_appbar_in_auth.dart';
import 'package:clothshop/features/authintication/presentation/widgets/form_signup.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:clothshop/config/extentions/extension.dart';
import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
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
                 PositionAppBarInAuth(screenHeight: screenHeight),
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
                      minHeight: screenHeight * 0.7,
                      maxHeight: screenHeight * 0.8,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.02,
                        ),
                        child: FormSignup(cubit: cubit, screenHeight: screenHeight),
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
