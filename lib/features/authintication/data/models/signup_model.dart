import 'package:clothshop/features/authintication/domain/entities/signup_entity.dart';

class SignupModel extends SignupEntity {
  const SignupModel(super.userId, {required super.firstname, 
  required super.lastname, required super.email,
   required super.password, required super.age});

  factory SignupModel.fromEntity(SignupEntity entity) {
    return SignupModel(
      firstname: entity.firstname,
      lastname: entity.lastname,
      email: entity.email,
      password: entity.password,
      age: entity.age,
       entity.userId
    );
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      firstname: json['firstName'],
      lastname: json['lastName'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
      json['userId']
    );
  }

  toJson() => {
    'firstName': firstname,
    'lastName': lastname,
    'email': email,
    'password': password,
    'age': age,
    'userId': userId
  };

 SignupModel copyWith({
    String? userId,
    String? firstname,
    String? lastname,
    String? email,
    String? password,
    String? age,
  }) {
    return SignupModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
      age: age ?? this.age,
      userId ?? this.userId
    );
  }

}