import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Create the Android notification channel
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // same id as used in showNotification
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  Future<void> initilizeLocalNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
       initializationSettings,
    );

    // Create the notification channel on Android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    // Tell FCM to show foreground notifications
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void requestNotificationPermission() async {
    NotificationSettings setting = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (setting.authorizationStatus == AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else if (setting.authorizationStatus == AuthorizationStatus.denied) {
      print("User denied permission");
    } else if (setting.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      print("User not determined permission");
    }
  }

  Future<String> getFcmToken() async {
    String? token = await messaging.getToken();
    print("FCM Token: $token");
    return token!;
  }

  void showNotification(RemoteMessage message) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          _channel.id, // use the same channel
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    flutterLocalNotificationsPlugin.show(
      0,
       message.notification?.title ?? "no title found",
       message.notification?.body ?? "no body found",
       notificationDetails,
    );
  }
}
