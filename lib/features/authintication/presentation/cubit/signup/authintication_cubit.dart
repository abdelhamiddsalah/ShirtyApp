import 'package:bloc/bloc.dart';
import 'package:clothshop/features/authintication/domain/entities/signup_entity.dart';
import 'package:clothshop/features/authintication/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'authintication_state.dart';

class AuthinticationCubit extends Cubit<AuthinticationState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Authusecase authusecase;

  String? selectedAge;
  bool isPasswordVisible = true;
  AuthinticationCubit(this.authusecase) : super(AuthinticationInitial());

  void updateSelectedAge(String age) {
    selectedAge = age;
  }

 void togglePasswordVisibility() {
  isPasswordVisible = !isPasswordVisible;
  emit(Authinticationvisibility(isPasswordVisible));  // إصدار الحالة عند تغيير الرؤية
}

  Future<void> signup( SignupEntity signupentity) async {
    if (selectedAge == null || selectedAge == "Select Age") {
      emit(const AuthinticationFailure(message: "Please select an age."));
      return;
    }
    emit(AuthinticationLoading());


    final result = await authusecase(signupentity);

    result.fold(
      (failure) => emit(AuthinticationFailure(message: failure.message)),
      (signupModel) => emit(AuthinticationSuccess()),
    );
  }
}
