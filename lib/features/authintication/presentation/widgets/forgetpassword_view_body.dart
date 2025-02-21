import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/constants/images.dart';
import 'package:clothshop/core/widgets/custom_appbar.dart';
import 'package:clothshop/core/widgets/empty_container.dart';
import 'package:clothshop/core/widgets/position_appbar_in_auth.dart';
import 'package:clothshop/features/authintication/presentation/cubit/forgetpassword/cubit/forgetpasswordreset_cubit.dart';
import 'package:clothshop/features/authintication/presentation/widgets/form_forgetpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:clothshop/config/extentions/extension.dart';
// ... rest of imports

class ForgetpasswordViewBody extends StatelessWidget {
  const ForgetpasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return BlocConsumer<ForgetpasswordresetCubit, ForgetpasswordresetState>(
      listener: (context, state) {
        if (state is ForgetpasswordresetSuccess) {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => EmptyContainer(
                Assets.imagesEmailSending,
                'We Sent you an email to reset your password',
                'Go to login',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
              )
            )
          );
        } else if (state is ForgetpasswordresetError) {
          errormessage(context, state.message);
        }
      },
      builder: (context, state) {
        var cubit = context.read<ForgetpasswordresetCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is ForgetpasswordresetLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                PositionAppBarInAuth(screenHeight: screenHeight),
                Positioned(
                  top: screenHeight * 0.084,
                  left: screenWidth * 0.05,
                  child: const Customappbar()
                ),
                Positioned(
                  top: screenHeight * 0.21,
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
                      minHeight: screenHeight * 0.3,
                      maxHeight: screenHeight * 0.8,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.02,
                        ),
                        child: FormForgetpassword(cubit: cubit, screenHeight: screenHeight),
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