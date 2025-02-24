import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/cart/data/models/cart_item_model.dart';
import 'package:clothshop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:clothshop/features/cart/domain/repositories/cart_repositry.dart';
import 'package:dartz/dartz.dart';

class AddcartUsecase {
  final CartRepositry cartRepository;

  AddcartUsecase(this.cartRepository);

  Future<Either<Failure, CartItemEntity>> call(CartItemModel cart, String userId) async {
    return cartRepository.addtocart(cart, userId);
  }
}