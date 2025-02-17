import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/domain/repositories/cart_repositry.dart';
import 'package:dartz/dartz.dart';

class DeletecartUsecase {
  final CartRepositry cartRepositry;
  DeletecartUsecase(this.cartRepositry);
  Future<Either<Failure, List<CartItemEntity>>> call(String cartId) async {
    return await cartRepositry.deletecart(cartId);
  }
}