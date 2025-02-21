import 'package:equatable/equatable.dart';

class LoginModel extends Equatable{
  final String email;
  final String password;
  const LoginModel({required this.email,required this.password});


 @override
  List<Object?> get props => [email, password];

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
    );
  }

  toJson() => {
    'email': email,
    'password': password,
  };
}