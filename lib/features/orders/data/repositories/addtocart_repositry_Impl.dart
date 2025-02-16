// ignore_for_file: file_names
import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/services/firestore_services.dart';
import 'package:clothshop/features/orders/data/models/addtocart_model.dart';
import 'package:clothshop/features/orders/domain/entities/addtocart.dart';
import 'package:clothshop/features/orders/domain/repositories/addtocart_repositry.dart';
import 'package:dartz/dartz.dart';

class AddtocartRepositryImpl extends AddtocartRepositry{
 final FirestoreService firestoreService;

  AddtocartRepositryImpl({required this.firestoreService});
  @override
  Future<Either<Failure, Addtocart>> addtocart(AddtocartModel addtocartModel) async {
    try {
      final result = await firestoreService.addToCart(addtocartModel);
      return result.fold(
        (failure) => Left(failure),
        (addtocart) => Right(addtocart as Addtocart),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}