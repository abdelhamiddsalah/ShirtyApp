import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/usecases/authusecase.dart';
import 'package:clothshop/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:dartz/dartz.dart';

class ForgetpasswordUsecase implements UseCases<String, String>{

  final AuthRepositries authRepositries;
  ForgetpasswordUsecase( this.authRepositries);

  @override
  Future<Either<Failure, String>> call(String email) async{
    return await authRepositries.forgotPasswordrepo(email);
  }
}