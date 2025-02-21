import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/constants/images.dart';
import 'package:clothshop/core/widgets/empty_container.dart';
import 'package:clothshop/features/authintication/presentation/cubit/forgetpassword/cubit/forgetpasswordreset_cubit.dart';
import 'package:clothshop/features/authintication/presentation/widgets/forgetpassword_stack.dart';
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
            body: FrgetpasswordStack(screenHeight: screenHeight, screenWidth: screenWidth, cubit: cubit),
          ),
        );
      },
    );
  }
}