import 'package:clothshop/clothes.dart';
import 'package:clothshop/features/payments/payment_keys.dart';
import 'package:clothshop/firebase_options.dart';
import 'package:clothshop/injection.dart';
import 'package:clothshop/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // تهيئة Stripe
  Stripe.publishableKey = ApiKeys.publisibleKey;

  // تهيئة Hive
  await HiveHelper.initHive();

  // تهيئة Supabase
  await Supabase.initialize(
    url: 'https://nxlpcezgxgqupxajyyaw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im54bHBjZXpneGdxdXB4YWp5eWF3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczODU3NzgxNCwiZXhwIjoyMDU0MTUzODE0fQ.CEJsRqC_i-f0OSVvcg8pO8UPmvhAEe6MoLGqGgLBm3M',
  );

  // تهيئة الاعتمادات الأخرى
  init();

  runApp(Shirty());
}
