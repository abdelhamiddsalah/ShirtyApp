import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/orders/domain/entities/addtocart.dart';
import 'package:dartz/dartz.dart';

abstract class AddtocartRepositry {
  Future<Either<Failure, Addtocart>> addtocart(AddtocartModel addtocartModel);
}