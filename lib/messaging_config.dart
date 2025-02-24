/*import 'dart:developer';
import 'package:clothshop/main.dart';
import 'package:clothshop/send_notifications_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class MessagingConfig {
  static initFirebaseMessaging() async {
    FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    // AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'high_importance_channel', 'Hight Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse payload) {
        log("payload1: ${payload.payload.toString()}");
        // try {
        //   log(payload.payload.toString());
        //   handleNotification(
        //       navigatorKey.currentContext!, jsonDecode(payload.payload ?? ""));
        //   log("payload: ${payload.toString()}");
        // } catch (e) {
        //   log("Exception: $e");
        // }
        return;
      },
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      log("message recieved");
      try {
        RemoteNotification? notification = event.notification;
        AndroidNotification? android = event.notification?.android;
        log(notification!.body.toString());
        log(notification.title.toString());
        // var jsdata = json.decode(notification!.body!);
        var body = notification.body;
        handleNotification(navigatorKey.currentContext!, event.data);
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            body,
            NotificationDetails(
                iOS: const DarwinNotificationDetails(
                    presentAlert: true, presentBadge: true, presentSound: true),
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: '@mipmap/ic_launcher')));
      } catch (err) {
        log(err.toString());
      }
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        handleNotification(navigatorKey.currentContext!, message.data);
      }
    });

    // Handle notification when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotification(navigatorKey.currentContext!, message.data);
    });
  }

  @pragma('vm:entry-point')
  static Future<void> messageHandler(RemoteMessage message) async {
    log('background message ${message.notification!.body}');
    //  Fluttertoast.showToast(
    //       msg:  message.notification!.title.toString() + "\n" + message.notification!.body.toString(),
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //        backgroundColor: Colors.greenAccent,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
  }
}*/
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
    await _requestPermissions();
    await _initializeLocalNotifications();
    await _setupFirebaseMessaging();
  }

  static Future<void> _requestPermissions() async {
    // طلب أذونات Firebase Messaging
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ تم منح إذن الإشعارات من Firebase');
    } else {
      print('❌ تم رفض إذن الإشعارات من Firebase');
    }

    // طلب أذونات الإشعارات المحلية على Android
    if (Platform.isAndroid) {
      // تم إزالة requestPermission() واستبدالها بالطريقة الصحيحة
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
      }
    }
  }

  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        print('تم النقر على الإشعار: ${details.payload}');
        // يمكنك إضافة التنقل هنا
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> _setupFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📩 تم استلام إشعار: ${message.notification?.title}');
      
      _showLocalNotification(message);
      
      final notification = NotificationModel(
        title: message.notification?.title ?? 'بدون عنوان',
        body: message.notification?.body ?? 'بدون محتوى',
        timestamp: DateTime.now(),
      );
      
      sl<NotificationsCubit>().addNotification(notification);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🔄 تم فتح التطبيق من الإشعار');
      // يمكنك إضافة التنقل هنا
    });

    await _firebaseMessaging.subscribeToTopic('all_users');
    final token = await _firebaseMessaging.getToken();
    print('📌 FCM Token: $token');
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    if (message.notification == null) return;

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
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }
}