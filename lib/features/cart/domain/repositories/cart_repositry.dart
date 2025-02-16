import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepositry {
  Future<Either<Failure, List<CartItemEntity>>> getcarts();
}