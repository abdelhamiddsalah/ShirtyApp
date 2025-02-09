import 'package:bloc/bloc.dart';
import 'package:clothshop/features/authintication/domain/usecases/isLoggined_usecase.dart';
import 'package:equatable/equatable.dart';

part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  final IslogginedUsecase islogginedUsecase;

  SplashscreenCubit(this.islogginedUsecase) : super(SplashscreenInitial());

  void display() async {
    emit(SplashscreenDisplay());
    await Future.delayed(const Duration(seconds: 3));
    authinticateduser();  // استدعاء التحقق بعد انتهاء المهلة
  }

 void authinticateduser() async {
  final result = await islogginedUsecase.call();
  result.fold(
    (l) {
      print("User is NOT authenticated");
      emit(UnAuthinticated());
    },
    (r) {
      print("User is authenticated");
      emit(Authinticated());
    },
  );
}

}
