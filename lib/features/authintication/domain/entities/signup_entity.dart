import 'package:equatable/equatable.dart';

class SignupEntity extends Equatable{
  final String firstname;
  final String lastname;
  final String email;
  final String password;
 final  String age;
 final String userId;
  const SignupEntity({required this.firstname,required this.lastname,required this.email,required this.password,required this.age,required this.userId});
  
  @override
  List<Object?> get props => [firstname,lastname,email,password,age,userId];
}