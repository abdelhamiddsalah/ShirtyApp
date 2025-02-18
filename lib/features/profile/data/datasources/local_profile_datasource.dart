import 'dart:convert';

import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/profile/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalProfileDatasource {
  Future<List<UserModel>> getlocalProfile();
  Future<void> cacheprofile(List<UserModel> profile);
}

class LocalProfileDatasourceImpl implements LocalProfileDatasource {

  final SharedPreferences sharedPreferences;
  static const String CACHED_Profile_KEY = 'CACHED_Profile_KEY';
  LocalProfileDatasourceImpl( this.sharedPreferences);
  @override
 
  Future<List<UserModel>> getlocalProfile() async {
    try {
      final String? profileJson = sharedPreferences.getString(CACHED_Profile_KEY);
      if (profileJson != null && profileJson.isNotEmpty) {
        List<dynamic> decodedList = json.decode(profileJson);
        return decodedList
            .map((profile) => UserModel.fromJson(profile))
            .toList();
      }
      return []; // Return empty list if no cached data
    } catch (e) {
      throw CacheFailure( 'Failed to get categories: ${e.toString()}');
    }
  }


 @override
  Future<bool> cacheprofile(List<UserModel> profiledata) async {
    try {
      final profileJson = json.encode(
        profiledata.map((profile) => profile.toJson()).toList(),
      );
      return await sharedPreferences.setString(CACHED_Profile_KEY, profileJson);
    } catch (e) {
      throw CacheFailure('Failed to cache categories: ${e.toString()}');
    }
  }

Future<bool> hasCachedData() async {
    final String? profileJson = sharedPreferences.getString(CACHED_Profile_KEY);
    return profileJson != null && profileJson.isNotEmpty;
  }



}
