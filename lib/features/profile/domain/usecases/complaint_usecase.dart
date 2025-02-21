import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/usecases/authusecase.dart';
import 'package:clothshop/features/profile/domain/repositories/profile_repositry.dart';
import 'package:dartz/dartz.dart';

class ComplaintUsecase implements UseCases{
  final ProfileRepositry profileRepositry;
  ComplaintUsecase(this.profileRepositry);
  @override
  Future<Either<Failure, void>> call(params) {
    return profileRepositry.addcomplaint(params);
  }

}