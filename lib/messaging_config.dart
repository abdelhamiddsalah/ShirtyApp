import 'dart:convert';
import 'dart:io';
import 'package:clothshop/features/notifications/data/models/notification_model.dart';
import 'package:clothshop/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:clothshop/injection.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
  );

  static Future<void> initialize() async {
    print('🔄 بدء تهيئة خدمة الإشعارات...');
    await _requestPermissions();
    await _initializeLocalNotifications();
    await _setupFirebaseMessaging();
   // await testLocalNotification();
    print('✅ تم تهيئة خدمة الإشعارات بنجاح');
  }

  static Future<void> _requestPermissions() async {
    print('🔄 طلب أذونات الإشعارات...');
    // طلب أذونات Firebase Messaging
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ تم منح إذن الإشعارات من Firebase');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('⚠️ تم منح إذن مؤقت للإشعارات');
    } else {
      print('❌ تم رفض إذن الإشعارات من Firebase: ${settings.authorizationStatus}');
    }

    // طلب أذونات الإشعارات المحلية على Android
    if (Platform.isAndroid) {
      try {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            _localNotifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        if (androidImplementation != null) {
          final bool? granted = await androidImplementation.requestNotificationsPermission();
          print('✅ إذن الإشعارات المحلية: $granted');
        }
      } catch (e) {
        print('❌ خطأ في طلب أذونات الإشعارات المحلية: $e');
      }
    }
  }

  static Future<void> _initializeLocalNotifications() async {
    print('🔄 تهيئة الإشعارات المحلية...');
    try {
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initSettings =
          InitializationSettings(android: androidSettings);

      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (details) {
          print('✅ تم النقر على الإشعار: ${details.payload}');
          // يمكنك إضافة التنقل هنا
        },
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      
      print('✅ تم تهيئة الإشعارات المحلية بنجاح');
    } catch (e) {
      print('❌ خطأ في تهيئة الإشعارات المحلية: $e');
    }
  }

  static Future<void> _setupFirebaseMessaging() async {
    print('🔄 إعداد Firebase Messaging...');
    try {
      // الاستماع للرسائل عندما يكون التطبيق في المقدمة
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('📩 تم استلام إشعار في المقدمة:');
        print('عنوان: ${message.notification?.title}');
        print('محتوى: ${message.notification?.body}');
        print('بيانات: ${message.data}');
        
        _showLocalNotification(message);
        
        final notification = NotificationModel(
          title: message.notification?.title ?? 'بدون عنوان',
          body: message.notification?.body ?? 'بدون محتوى',
          timestamp: DateTime.now(),
        );
        
        sl<NotificationsCubit>().addNotification(notification);
      });

      // الاستماع للنقر على الإشعار عندما يكون التطبيق في الخلفية
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('🔄 تم فتح التطبيق من الإشعار:');
        print('عنوان: ${message.notification?.title}');
        print('محتوى: ${message.notification?.body}');
        print('بيانات: ${message.data}');
        // يمكنك إضافة التنقل هنا
      });

      // التعامل مع الإشعارات التي تفتح التطبيق من حالة الإغلاق
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print('🔄 تم فتح التطبيق من إشعار عندما كان مغلقًا:');
        print('عنوان: ${initialMessage.notification?.title}');
      }

      // الاشتراك في موضوع للإشعارات الجماعية
      await _firebaseMessaging.subscribeToTopic('all_users');
      print('✅ تم الاشتراك في موضوع all_users');
      
      // الحصول على رمز الجهاز
      final token = await _firebaseMessaging.getToken();
      print('📌 FCM Token: $token');
      
      print('✅ تم إعداد Firebase Messaging بنجاح');
    } catch (e) {
      print('❌ خطأ في إعداد Firebase Messaging: $e');
    }
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    print('🔄 عرض إشعار محلي...');
    try {
      if (message.notification == null) {
        print('⚠️ لا يوجد محتوى للإشعار');
        return;
      }

      await _localNotifications.show(
        DateTime.now().millisecond,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.data),
      );
      print('✅ تم عرض الإشعار المحلي بنجاح');
    } catch (e) {
      print('❌ خطأ في عرض الإشعار المحلي: $e');
    }
  }
  
 
  
  static Future<void> checkTopicSubscription() async {
    try {
      print('🔄 التحقق من الاشتراك في الموضوع...');
      await _firebaseMessaging.subscribeToTopic('all_users');
      print('✅ تم الاشتراك في موضوع: all_users');
    } catch (e) {
      print('❌ فشل في الاشتراك في الموضوع: $e');
    }
  }
}