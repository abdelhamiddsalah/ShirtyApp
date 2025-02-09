import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/usecases/authusecase.dart';
import 'package:clothshop/features/home/domain/entities/category_entity.dart';
import 'package:clothshop/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class CategoryUsecase implements UseCases<List<CategoryEntity>, Noparams> {
  final HomeRepositry homeRepositry;

  CategoryUsecase(this.homeRepositry);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(Noparams params) {
    var result = homeRepositry.getCategories();
    return result;
  }
}
