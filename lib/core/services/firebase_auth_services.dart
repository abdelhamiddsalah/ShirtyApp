import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// إنشاء مستخدم جديد
  Future<User> createNewUser(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      
      // حفظ بيانات المستخدم في Firestore
      await _firestore.collection('Users').doc(user.uid).set({
        'email': user.email,
        'userId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // حفظ FCM Token
      await saveTokenToDatabase(user.uid);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception(e.message ?? 'Failed to create user.');
      }
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  /// تسجيل دخول المستخدم
  Future<User> signInUser(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      
      // تحديث بيانات المستخدم عند تسجيل الدخول
      await _firestore.collection('Users').doc(user.uid).set({
        'email': user.email,
        'userId': user.uid,
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // حفظ FCM Token
      await saveTokenToDatabase(user.uid);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception(e.message ?? 'Failed to sign in user.');
      }
    } catch (e) {
      throw Exception('Failed to sign in user: $e');
    }
  }

  /// إعادة تعيين كلمة المرور
  Future<bool> forgetPasswordService(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception(e.message ?? 'Failed to send password reset email.');
      }
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }

  /// التحقق مما إذا كان المستخدم مسجل دخول
  Future<bool> isLoggedIn() async {
    try {
      final user = _auth.currentUser;
      return user != null;
    } catch (e) {
      print("Error checking login status: $e");
      return false;
    }
  }

  /// حفظ FCM Token في Firestore
  Future<void> saveTokenToDatabase(String userId) async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firestore.collection('Users').doc(userId).update({
        'fcmToken': token,
      });
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('Users').doc(userId).get();

    if (snapshot.exists) {
      return snapshot.data(); // إرجاع بيانات المستخدم كـ Map
    } else {
      return null; // إذا لم يكن هناك بيانات
    }
  } catch (e) {
    throw Exception('Failed to fetch user data: $e');
  }
}


Future<void> logout()async{
await _auth.signOut();
}

}

/// استرجاع بيانات المستخدم من Firestore