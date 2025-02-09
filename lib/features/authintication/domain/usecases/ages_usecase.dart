import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/usecases/authusecase.dart';
import 'package:clothshop/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class AgesUsecase implements UseCases<dynamic, List<QueryDocumentSnapshot>> {
  final AuthRepositries authRepositries;

  AgesUsecase(this.authRepositries);

  @override
  Future<Either<Failure, List<QueryDocumentSnapshot>>> call(dynamic age) async {
    return authRepositries.getages();
  }
}
