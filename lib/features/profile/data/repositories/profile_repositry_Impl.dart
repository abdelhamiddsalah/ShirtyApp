import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/network/network_info.dart';
import 'package:clothshop/core/services/firebase_auth_services.dart';
import 'package:clothshop/features/profile/data/datasources/local_profile_datasource.dart';
import 'package:clothshop/features/profile/data/datasources/remote_profile_datasource.dart';
import 'package:clothshop/features/profile/domain/entities/user_entity.dart';
import 'package:clothshop/features/profile/domain/repositories/profile_repositry.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositryImpl extends ProfileRepositry{
  final LocalProfileDatasource localProfileDatasource;
  final RemoteProfileDatasource remoteProfileDatasource;
  final NetworkInfo networkInfo;
  final FirebaseAuthServices firebaseAuthServices;

  ProfileRepositryImpl(this.firebaseAuthServices, {required this.localProfileDatasource,required this.remoteProfileDatasource,required this.networkInfo});
  @override
  Future<Either<Failure, List<UserEntity>>> getUserData( String userId) async{
    try {
      if (await networkInfo.isConnected) {
        return await _fetchRemoteProfile( userId);
      } else {
        return await _getLocalProfile();
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch categories: ${e.toString()}'));
    }
  }

   Future<Either<Failure, List<UserEntity>>> _fetchRemoteProfile( String userId) async {
    try {
      final profiledata = await remoteProfileDatasource.getUserData( userId);
      await localProfileDatasource.cacheprofile(profiledata); // Cache البيانات
      return Right(profiledata);
    } catch (e) {
      return await _getLocalProfile(); // في حالة فشل الـ API، نحاول من الكاش
    }
  }
  Future<Either<Failure, List<UserEntity>>> _getLocalProfile() async {
    try {
      final profiledata = await localProfileDatasource.getlocalProfile();
      if (profiledata.isEmpty) {
        return const Left(CacheFailure('No cached data available'));
      }
      return Right(profiledata);
    } catch (e) {
      return Left(CacheFailure('Failed to retrieve cached data: ${e.toString()}'));
    }
  }

  @override
  Future<void> logout() async{
    await firebaseAuthServices.logout();
  }

  @override
  Future<void> updateUserData() {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }

  
    }
  

  /// 🔹 دالة خاصة لجلب البيانات من الكاش
  
