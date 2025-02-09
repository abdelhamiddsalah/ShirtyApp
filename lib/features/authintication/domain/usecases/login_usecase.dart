import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/usecases/authusecase.dart';
import 'package:clothshop/features/authintication/data/models/login_model.dart';
import 'package:clothshop/features/authintication/domain/entities/login_entity.dart';
import 'package:clothshop/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase implements UseCases<LoginModel, LoginEntity> {
  final AuthRepositries authRepositries;
  LoginUsecase(this.authRepositries);
  @override
  Future<Either<Failure, LoginModel>> call(LoginEntity loginentity) async{
    return await authRepositries.login(loginentity);
  }
}