import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class ProductsUsecase{
 final HomeRepositry homeRepositry;
  ProductsUsecase(this.homeRepositry);
  Future<Either<Failure, List<ProductEntity>>> call(String path1, String path2,String documentId) {
    var result = homeRepositry.getProducts(path1, path2, documentId);
    return result;
  }

}