import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/checkout/domain/entities/address_entity.dart';
import 'package:clothshop/features/checkout/domain/repositories/checkout_repositry.dart';
import 'package:dartz/dartz.dart';

class GetaddressUsecase {
  final CheckoutRepositry addressRepository;

  GetaddressUsecase(this.addressRepository);

  Future<Either<Failure, AddressEntity>> call(String addressId) async {
    return await addressRepository.getUserAddress(addressId);
  }
}