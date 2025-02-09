import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/network/network_info.dart';
import 'package:clothshop/features/home/data/datasources/category_datasources/local_datasource.dart';
import 'package:clothshop/features/home/data/datasources/category_datasources/remote_datasource.dart';
import 'package:clothshop/features/home/data/datasources/product_datasources/local_productdatasource.dart';
import 'package:clothshop/features/home/data/datasources/product_datasources/remote_productdatasource.dart';
import 'package:clothshop/features/home/data/models/product_model.dart';
import 'package:clothshop/features/home/domain/entities/category_entity.dart';
import 'package:clothshop/features/home/domain/entities/product_entity.dart';
import 'package:clothshop/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class HomeRepostriesImpel extends HomeRepositry {
  final NetworkInfo networkInfo;
  final RemoteDatasource remoteDatasource;
  final LocalDatasource localDatasource;
  final LocalProductdatasource localProductdatasource;
  final RemoteProductdatasource remoteProductdatasource;

  HomeRepostriesImpel(
    this.networkInfo,
    this.remoteDatasource,
    this.localDatasource,
    this.localProductdatasource,
    this.remoteProductdatasource,
  );

  /// ✅ جلب الفئات (Categories)
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      if (await networkInfo.isConnected) {
        return await _fetchRemoteCategories();
      } else {
        return await _getLocalCategories();
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch categories: ${e.toString()}'));
    }
  }

  /// 🔹 دالة خاصة لجلب البيانات من Firestore
  Future<Either<Failure, List<CategoryEntity>>> _fetchRemoteCategories() async {
    try {
      final categories = await remoteDatasource.getCategories();
      await localDatasource.cacheCategories(categories); // Cache البيانات
      return Right(categories);
    } catch (e) {
      return await _getLocalCategories(); // في حالة فشل الـ API، نحاول من الكاش
    }
  }

  /// 🔹 دالة خاصة لجلب البيانات من الكاش
  Future<Either<Failure, List<CategoryEntity>>> _getLocalCategories() async {
    try {
      final categories = await localDatasource.getLastCategories();
      if (categories.isEmpty) {
        return Left(CacheFailure('No cached data available'));
      }
      return Right(categories);
    } catch (e) {
      return Left(CacheFailure('Failed to retrieve cached data: ${e.toString()}'));
    }
  }

  /// ✅ جلب المنتجات (Products)
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
      String path1, String path2, String documentId) async {
    return await _fetchProducts(path1, path2, documentId);
  }

  /// 🔹 دالة خاصة لجلب المنتجات من الـ API أو الكاش
  Future<Either<Failure, List<ProductEntity>>> _fetchProducts(
      String path1, String path2, String documentId) async {
    if (await networkInfo.isConnected) {
      return await _fetchRemoteProducts(path1, path2, documentId);
    } else {
      return await _fetchLocalProducts();
    }
  }

  /// 🔹 جلب المنتجات من Firestore
  Future<Either<Failure, List<ProductEntity>>> _fetchRemoteProducts(
      String path1, String path2, String documentId) async {
    try {
      List<ProductModel> products =
          await remoteProductdatasource.getremoteProducts(path1, path2, documentId);
      return Right(products); // ✅ لا حاجة لتحويل `ProductModel` إلى `ProductEntity` لأنه يرثها
    } catch (e) {
      return Left(ServerFailure('Server error: ${e.toString()}'));
    }
  }

  /// 🔹 جلب المنتجات من الكاش
  Future<Either<Failure, List<ProductEntity>>> _fetchLocalProducts() async {
    try {
      List<ProductModel> products = await localProductdatasource.getlocalProducts();
      return Right(products);
    } catch (e) {
      return Left(CacheFailure('Cache error: ${e.toString()}'));
    }
  }
}
