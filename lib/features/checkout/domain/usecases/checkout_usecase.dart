import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/checkout/data/models/address_model.dart';
import 'package:clothshop/features/checkout/domain/entities/address_entity.dart';
import 'package:clothshop/features/checkout/domain/repositories/checkout_repositry.dart';
import 'package:dartz/dartz.dart';

class CheckoutUsecase {
  final CheckoutRepositry checkoutRepositry;

  CheckoutUsecase(this.checkoutRepositry);

  Future<Either<Failure, AddressEntity>> call(AddressModel address, String userid) async {
    return checkoutRepositry.addAddress(address, userid);
  }
}