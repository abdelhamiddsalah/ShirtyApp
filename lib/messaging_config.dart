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
import 'dart:developer';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/notifications/data/models/notification_model.dart';
import 'package:clothshop/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class MessagingConfig {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  
  static Future<void> initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("🔔 User granted notification permission.");

      await messaging.subscribeToTopic("all_users");
      log("📢 User subscribed to topic: all_users");

      String? token = await messaging.getToken();
      log("📌 FCM Token: $token");
    } else {
      log("❌ User denied notification permission.");
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("📩 Notification received: ${message.notification?.title}");

      final notification = NotificationModel(
        title: message.notification?.title ?? "No Title",
        body: message.notification?.body ?? "No Body",
        timestamp: DateTime.now(),
      );

      // ✅ استخدام GetIt للوصول إلى NotificationsCubit
      sl<NotificationsCubit>().addNotification(notification);

      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("🔄 User opened the app from notification.");
    });

    _initializeLocalNotifications();
  }

  static void _initializeLocalNotifications() {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    _notificationsPlugin.initialize(initializationSettings);
  }

  static void showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id', 'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }
}
