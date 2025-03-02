import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/cart/domain/repositories/cart_repositry.dart';
import 'package:dartz/dartz.dart';

class DeletecartUsecase {
  final CartRepositry cartRepositry;
  DeletecartUsecase(this.cartRepositry);

  Future<Either<Failure, void>> call(String cartId,String selectedSize, String selectedColor) async {
    return await cartRepositry.deletecart(cartId, selectedSize,  selectedColor);
  }
}
