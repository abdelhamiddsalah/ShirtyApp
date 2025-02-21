import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/profile/data/models/complaint_model.dart';
import 'package:clothshop/features/profile/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepositry {
  Future<Either<Failure, UserEntity>> getUserData( String userId);
  Future<void> updateUserData();
  Future<void> logout();
  Future<Either<Failure, void>> addcomplaint(ComplaintModel complaint);
}