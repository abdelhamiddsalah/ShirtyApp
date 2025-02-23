import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/checkout/data/models/address_model.dart';
import 'package:clothshop/features/checkout/domain/entities/address_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CheckoutRepositry {
 Future<Either<Failure, AddressEntity>> addAddress(AddressModel address, String userid);
 Future<Either<Failure, AddressEntity>> getUserAddress(String userId);
}