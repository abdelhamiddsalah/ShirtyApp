import 'package:clothshop/core/services/firebase_auth_services.dart';
import 'package:clothshop/features/profile/data/models/user_model.dart';

abstract class RemoteProfileDatasource {
  Future<List<UserModel>> getUserData(String userId);
}

class RemoteProfileDatasourceImpl implements RemoteProfileDatasource {
  final FirebaseAuthServices firebaseAuthServices;

  RemoteProfileDatasourceImpl({required this.firebaseAuthServices});
  @override
  Future<List<UserModel>> getUserData( String userId ) async {
    final data = await firebaseAuthServices.getUserData(userId);
    if (data != null) {
      return data.entries.map((entry) => UserModel.fromJson(entry.value)).toList();
    } else {
      return [];
    }
  }
}