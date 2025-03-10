import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/services/firebase_auth_services.dart';
import 'package:clothshop/features/profile/data/models/user_model.dart';

abstract class RemoteProfileDatasource {
  Future<UserModel> getUserData(String userId);
}

class RemoteProfileDatasourceImpl implements RemoteProfileDatasource {
  final FirebaseAuthServices firebaseAuthServices;

  RemoteProfileDatasourceImpl({required this.firebaseAuthServices});

  @override
  Future<UserModel> getUserData(String userId) async {
    final data = await firebaseAuthServices.getUserData(userId);
    if (data != null) {
      return UserModel.fromJson(data);
    } else {
      throw const ServerFailure("No data found for this user.");
    }
  }
}
