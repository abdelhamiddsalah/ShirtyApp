import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/usecases/authusecase.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/orders/domain/entities/addtocart.dart';
import 'package:clothshop/features/orders/domain/repositories/addtocart_repositry.dart';
import 'package:dartz/dartz.dart';

class AddtocartUsecase implements UseCases<Addtocart, AddtocartModel> {
  final AddtocartRepositry addtocartRepositry;
  AddtocartUsecase({required this.addtocartRepositry});

  @override
  Future<Either<Failure, Addtocart>> call(AddtocartModel params)async {
    return addtocartRepositry.addtocart(params);
  }
}