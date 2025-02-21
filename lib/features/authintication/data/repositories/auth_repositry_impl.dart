import 'package:clothshop/core/errors/failure.dart';
import 'package:clothshop/core/services/firebase_auth_services.dart';
import 'package:clothshop/features/authintication/data/models/login_model.dart';
import 'package:clothshop/features/authintication/data/models/signup_model.dart';
import 'package:clothshop/features/authintication/domain/entities/login_entity.dart';
import 'package:clothshop/features/authintication/domain/entities/signup_entity.dart';
import 'package:clothshop/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class AuthRepositryImpl extends AuthRepositries {
  final FirebaseAuthServices firebaseAuthServices;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference ages = FirebaseFirestore.instance.collection('ages');

  AuthRepositryImpl({required this.firebaseAuthServices});

  @override
 Future<Either<Failure, SignupEntity>> signup(SignupEntity signupentity) async {
  try {
    // إنشاء مستخدم جديد في Firebase Authentication والحصول على UID
    String userId = await firebaseAuthServices.createNewUser(
      signupentity.email, 
      signupentity.password
    );

    // إنشاء نموذج تسجيل المستخدم بعد الحصول على UID
    SignupModel signupModel = SignupModel(
      firstname: signupentity.firstname,
      lastname: signupentity.lastname,
      email: signupentity.email,
      password: signupentity.password,
      age: signupentity.age,
      userId: userId, // ✅ تخزين UID في SignupModel
    );

    // حفظ بيانات المستخدم في Firestore باستخدام UID
    await users.doc(userId).set({
      'userId': userId, // ✅ تخزين UID في Firestore
      'firstName': signupModel.firstname,
      'lastName': signupModel.lastname,
      'email': signupModel.email,
      'age': signupModel.age,
      'password': signupModel.password, // ⚠️ لا يُفضل تخزين كلمات المرور
    });

    return Right(signupModel as SignupEntity); // ✅ إرجاع SignupModel مع UID
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}


  @override
  Future<Either<Failure, LoginEntity>> login(LoginEntity loginentity) async {
    try {
      LoginModel loginModel = LoginModel(email: loginentity.email, password: loginentity.password);
      await firebaseAuthServices.signInUser(loginentity.email, loginentity.password);
      return Right(loginModel as LoginEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<QueryDocumentSnapshot>>> getages() async {
    try {
      var result = await ages.get();
      return Right(result.docs);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
  
  @override
Future<Either<Failure, String>> forgotPasswordrepo(String email) async {
  try {
    await firebaseAuthServices.forgetPasswordService(email);
    return const Right("Password reset email sent successfully");
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}

  @override
  Future<Either<Failure, bool>> isLoggedIn() async{
   try {
    bool isLoggeddIn= await firebaseAuthServices.isLoggedIn();
     return  Right(isLoggeddIn);
   } catch (e) {
     return  Left(Failure(e.toString()));
   }
  }

}
