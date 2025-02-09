import 'package:bloc/bloc.dart';
import 'package:clothshop/features/authintication/domain/entities/login_entity.dart';
import 'package:clothshop/features/authintication/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  LoginCubit(this.loginUsecase) : super(LoginInitial());

  bool isPasswordVisible = true;
void togglePasswordVisibility() {
  isPasswordVisible = !isPasswordVisible;
  emit(Loginvisibility(isPasswordVisible));  // إصدار الحالة عند تغيير الرؤية
}
 
  Future<void> login(LoginEntity loginentity) async {
    emit(LoginLoading());
    final result = await loginUsecase(loginentity);
    result.fold((l) => emit(LoginFailure(message: l.message)), (r) => emit(LoginSuccess()));
  }
}
