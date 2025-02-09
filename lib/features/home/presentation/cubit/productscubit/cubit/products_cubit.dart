import 'package:bloc/bloc.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/domain/usecases/products_usecase.dart';
import 'package:equatable/equatable.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsUsecase productsUseCase;
  ProductsCubit(this.productsUseCase) : super(ProductsInitial());

  Future<void> getProducts(String path1, String path2,String documentId) async {
    emit(ProductsLoading());
    var result = await productsUseCase.call(path1, path2,documentId);
    result.fold((l) => emit(ProductsError(message: l.message)), (r) => emit(ProductsLoaded(products: r)));
  }
}
