import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class NewProductsUsecase {
  final HomeRepositry homeRepositry;
  NewProductsUsecase(this.homeRepositry);
  Future<Either<Failure, List<ProductEntity>>> call() async {
    var result = homeRepositry.getNewProducts();
    return result;
  }
}