import 'package:clothshop/features/profile/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
    super.lastname,
    super.age,
    super.firstname, {
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['firstName'],
      json['lastName'],
      json['age'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstname,
      'lastName': lastname,
      'age': age,
      'email': email,
    };
  }
}
