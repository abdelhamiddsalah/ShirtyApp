import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepositry {
  Future<Either<Failure, List<CartItemEntity>>> getcarts();
  Future<Either<Failure, List<CartItemEntity>>> deletecart(String cartId,String selectedSize, String selectedColor);

  Future<Either<Failure, CartItemEntity>> addtocart(CartItemEntity cartItem, String userId);
}