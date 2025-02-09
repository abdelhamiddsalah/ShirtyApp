import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/usecases/authusecase.dart';
import 'package:clothshop/features/authintication/data/models/signup_model.dart';
import 'package:clothshop/features/authintication/domain/entities/signup_entity.dart';
import 'package:clothshop/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:dartz/dartz.dart';

class Authusecase implements UseCases<SignupModel, SignupEntity> {
  final AuthRepositries authRepositries;

  Authusecase(this.authRepositries);

  @override
  Future<Either<Failure, SignupModel>> call(SignupEntity signupentity) async{
    return await authRepositries.signup(signupentity);
  }
}
