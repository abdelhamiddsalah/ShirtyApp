import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAuthServices {
  Future<User> createNewUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
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

  Future<User> signInUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
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

  Future<bool> forgetPasswordService(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
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

  Future<bool> isLoggedIn() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user != null;
    } catch (e) {
      print("Error checking login status: $e");
      return false;
    }
  }

  Future<void> saveTokenToDatabase(String userId) async {
  String? token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    await FirebaseFirestore.instance.collection('Users').doc(userId).update({
      'fcmToken': token,
    });
  }
}
}