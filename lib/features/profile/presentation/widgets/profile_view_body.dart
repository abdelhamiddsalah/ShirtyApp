import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: GestureDetector(
              onTap: () async{
            await    FirebaseAuth.instance.signOut();
              },
              child: Icon(Icons.logout)),)
          ],
        ),
      ),
    );
  }
}