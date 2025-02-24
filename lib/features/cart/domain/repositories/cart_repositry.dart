import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/cart/data/models/cart_item_model.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepositry {
  Future<Either<Failure, List<CartItemEntity>>> getcarts();
  Future<Either<Failure, List<CartItemEntity>>> deletecart(String cartId);
  Future<Either<Failure, CartItemEntity>> addtocart(CartItemModel cartItem, String userId);
}