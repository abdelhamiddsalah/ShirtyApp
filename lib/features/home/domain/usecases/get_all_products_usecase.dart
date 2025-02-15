import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class GetAllProductsUsecase {
  final HomeRepositry homeRepositry;

  GetAllProductsUsecase(this.homeRepositry);

  Future<Either<Failure, List<ProductEntity>>> call(String query) async {
    return await homeRepositry.getAllproducts(query);
  }
}
