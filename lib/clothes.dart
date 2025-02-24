import 'package:clothshop/config/routing/routing_app.dart';
import 'package:clothshop/config/themes/themeapp.dart';
import 'package:flutter/material.dart';

class Shirty extends StatelessWidget {
  const Shirty({super.key}); // استخدم `const` لتحسين الأداء

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shirty',
      theme: themeApp, // تأكد أن `themeApp` معرف في `themeapp.dart`
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router, // استخدم `GoRouter`
    );
  }
}
