import 'package:clothshop/features/profile/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel  extends UserEntity{
  UserModel({required super.userId,
   required super.firstName,
    required super.lastName,
     required super.email, 
     required super.age, 
    // required super.fcmToken, 
    // required super.lastLogin
     });

     factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      age: json['age'],
      //fcmToken: json['fcmToken'],
   //  lastLogin: json['lastLogin'] is Timestamp 
      //  ? (json['lastLogin'] as Timestamp).toDate() // إذا كان Timestamp
       // : DateTime.parse(json['lastLogin']), // إذا كان String
    );
  }

   toJson() => {
    'userId': userId,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'age': age,
   // 'fcmToken': fcmToken,
 // 'lastLogin': lastLogin.toIso8601String(), // ✅ يحول DateTime إلى String

  };

}
