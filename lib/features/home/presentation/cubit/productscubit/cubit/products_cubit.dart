import 'package:bloc/bloc.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:clothshop/features/home/domain/usecases/new_products_usecase.dart';
import 'package:clothshop/features/home/domain/usecases/products_usecase.dart';
import 'package:equatable/equatable.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsUsecase productsUseCase;
  final NewProductsUsecase newProductsUsecase;
  final GetAllProductsUsecase getAllProductsUsecase;
  ProductsCubit(this.productsUseCase, this.newProductsUsecase, this.getAllProductsUsecase) : super(ProductsInitial());

  Future<void> getProducts(String categoryId) async {
    emit(ProductsLoading());
    var result = await productsUseCase.call( categoryId);
    result.fold((l) => emit(ProductsError(message: l.message)), (r) => emit(ProductsLoaded(products: r)));
  }

  Future<void> getNewProducts() async {
    emit(ProductsLoading());
    var result = await newProductsUsecase.call();
    result.fold((l) => emit(ProductsError(message: l.message)), (r) => emit(ProductsLoaded(products: r)));
  }

  Future<void> getAllProducts(String query) async {
  emit(ProductsLoading());
  var result = await getAllProductsUsecase.call(query);
  result.fold(
    (l) => emit(ProductsError(message: l.message)),
    (r) => emit(ProductsLoaded(products: r)),
  );
}

}
