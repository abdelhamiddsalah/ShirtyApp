import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/features/authintication/data/models/login_model.dart';
import 'package:clothshop/features/authintication/data/models/signup_model.dart';
import 'package:clothshop/features/authintication/domain/entities/login_entity.dart';
import 'package:clothshop/features/authintication/domain/entities/signup_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepositries{
  Future<Either<Failure, SignupModel>> signup(SignupEntity signupEntity);
  Future<Either<Failure, LoginModel>> login(LoginEntity loginentity);
  Future<Either<Failure, List<QueryDocumentSnapshot>>> getages();
  Future<Either<Failure, String>> forgotPasswordrepo(String email);
  Future<Either<Failure,bool>> isLoggedIn();


}