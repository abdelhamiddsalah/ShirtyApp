import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupModel extends Equatable {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String age;

  const SignupModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
   required this.age,
  });

  @override
  List<Object?> get props => [firstname, lastname, email, password, age];

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
    'password': password,
    'age': age,
  };

  factory SignupModel.fromfirebase(User user, String age) {
    final nameParts = user.displayName?.split(' ') ?? [];
    final firstname = nameParts.isNotEmpty ? nameParts[0] : '';
    final lastname = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return SignupModel(
      firstname: firstname,
      lastname: lastname,
      email: user.email ?? '',
      password: user.uid,  // This is just a placeholder for the password, be cautious here
      age: age,
    );
  }
}
