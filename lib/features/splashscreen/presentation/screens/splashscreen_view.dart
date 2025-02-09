import 'package:clothshop/core/services/firebase_auth_services.dart';
import 'package:clothshop/features/authintication/data/repositories/auth_repositry_impl.dart';
import 'package:clothshop/features/authintication/domain/usecases/isLoggined_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothshop/config/routing/routes.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/features/splashscreen/presentation/cubit/splashscreen_cubit.dart';
import 'package:clothshop/features/splashscreen/presentation/widgets/splashscreen_view_body.dart';

class SplashscreenView extends StatelessWidget {
  const SplashscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashscreenCubit(
        IslogginedUsecase(
          AuthRepositryImpl(firebaseAuthServices: FirebaseAuthServices()),
        ),
      )..display(),
      child: BlocListener<SplashscreenCubit, SplashscreenState>(
        listener: (context, state) {
          if (state is Authinticated) {
            Navigator.pushReplacementNamed(context, Routes.home);
          } else if (state is UnAuthinticated) {
            Navigator.pushReplacementNamed(context, Routes.onboarding);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: const SplashscreenViewBody(),
        ),
      ),
    );
  }
}