import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/network/network_info.dart';
import 'package:clothshop/core/services/firebase_add_services.dart';
import 'package:clothshop/core/services/firebase_auth_services.dart';
import 'package:clothshop/features/profile/data/datasources/local_profile_datasource.dart';
import 'package:clothshop/features/profile/data/datasources/remote_profile_datasource.dart';
import 'package:clothshop/features/profile/data/models/complaint_model.dart';
import 'package:clothshop/features/profile/domain/entities/user_entity.dart';
import 'package:clothshop/features/profile/domain/repositories/profile_repositry.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositryImpl extends ProfileRepositry {
  final LocalProfileDatasource localProfileDatasource;
  final RemoteProfileDatasource remoteProfileDatasource;
  final NetworkInfo networkInfo;
  final FirebaseAuthServices firebaseAuthServices;
  final FirebaseAddServices firebaseAddServices;

  ProfileRepositryImpl(
    this.firebaseAuthServices, this.firebaseAddServices,
    {required this.localProfileDatasource,
    required this.remoteProfileDatasource,
    required this.networkInfo});

  @override
  Future<Either<Failure, UserEntity>> getUserData(String userId) async {
    try {
      if (await networkInfo.isConnected) {
        final profileData = await remoteProfileDatasource.getUserData(userId);
        await localProfileDatasource.cacheprofile(profileData);
        return Right(profileData);
      } else {
        final profileData = await localProfileDatasource.getlocalProfile();
        if (profileData == null) {
          throw const ServerFailure("No data found for this user.");
        }
        return Right(profileData);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuthServices.logout();
  }

  @override
  Future<void> updateUserData() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> addcomplaint(ComplaintModel complaint) async{
    try {
      await firebaseAddServices.addComplaint(complaint);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
  }
}
}


/* try {
      if (await networkInfo.isConnected) {
        return await _fetchRemoteProfile(userId);
      } else {
        return await _getLocalProfile();
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch profile: ${e.toString()}'));
    }
  }

  Future<Either<Failure, UserEntity>> _fetchRemoteProfile(String userId) async {
    try {
      final profileData = await remoteProfileDatasource.getUserData(userId);
      await localProfileDatasource.cacheprofile(profileData);
      return Right(profileData);
    } catch (e) {
      return await _getLocalProfile();
    }
  }

  Future<Either<Failure, UserEntity>> _getLocalProfile() async {
  try {
    final profileData = await localProfileDatasource.getlocalProfile();
    if (profileData == null) {
      return Left(CacheFailure('No cached profile data available'));
    }
    return Right(profileData);
  } catch (e) {
    // Log the error, but don't crash
    print('Cache error in repository: ${e.toString()}');
    return Left(CacheFailure('Failed to access cached data'));
  }
}*/