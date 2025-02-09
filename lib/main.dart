import 'package:clothshop/clothes.dart';
import 'package:clothshop/firebase_options.dart';
import 'package:clothshop/injection.dart';
import 'package:clothshop/messaging_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // **🔹 تأكد من تهيئة Firebase قبل أي استخدام له**
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // **🔹 تهيئة Firestore مع التحقق من التهيئة**
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
  );

  // **🔹 تهيئة Supabase**
  await Supabase.initialize(
    url: 'https://nxlpcezgxgqupxajyyaw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im54bHBjZXpneGdxdXB4YWp5eWF3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczODU3NzgxNCwiZXhwIjoyMDU0MTUzODE0fQ.CEJsRqC_i-f0OSVvcg8pO8UPmvhAEe6MoLGqGgLBm3M',
  );

  // **🔹 تهيئة Injection و Firebase Messaging**
  init();
await MessagingConfig.initFirebaseMessaging();
//  FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);

  // **🔹 تشغيل التطبيق بعد التهيئة**
  runApp(Shirty());
}