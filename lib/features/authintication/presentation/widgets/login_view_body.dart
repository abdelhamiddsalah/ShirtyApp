import 'package:clothshop/config/extentions/extension.dart';
import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/features/authintication/presentation/cubit/logincubit/cubit/login_cubit.dart';
import 'package:clothshop/features/authintication/presentation/widgets/login_stack.dart';
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
            body: LoginStack(screenHeight: screenHeight, screenWidth: screenWidth, cubit: cubit),
          ),
        );
      },
    );
  }
}