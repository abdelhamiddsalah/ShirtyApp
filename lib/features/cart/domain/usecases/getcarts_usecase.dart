import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/domain/repositories/cart_repositry.dart';
import 'package:dartz/dartz.dart';

class GetcartsUsecase {
  final CartRepositry cartRepositry;
  GetcartsUsecase(this.cartRepositry);

  Future<Either<Failure, List<CartItemEntity>>> call() async {
    return await cartRepositry.getcarts();
  }
}