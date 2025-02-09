import 'package:clothshop/config/routing/routing_app.dart';
import 'package:clothshop/config/themes/themeapp.dart';
import 'package:flutter/material.dart';

class Shirty extends StatelessWidget {
  final String initialRoute = '/';
  final AppRoutes appRoutes = AppRoutes();
   Shirty({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Shirty',
      theme: themeApp,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: appRoutes.generateRoute,
    );
  }
}

