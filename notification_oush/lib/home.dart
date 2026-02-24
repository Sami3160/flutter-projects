import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_oush/notification_service.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    _setupNotifications();
    super.initState();
  }

  void _setupNotifications() async {
    notificationService.requestNotificationPermission();
    notificationService.getFcmToken();

    notificationService.initilizeLocalNotification();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.notification?.title}");
      notificationService.showNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(child: Text("Home")),
    );
  }
}
