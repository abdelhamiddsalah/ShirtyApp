// ignore_for_file: file_names

import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:dartz/dartz.dart';

class IslogginedUsecase{
  final AuthRepositries authRepositries;
  IslogginedUsecase(this.authRepositries);
  Future<Either<Failure, bool>> call() async {
    return await authRepositries.isLoggedIn();
  }
}