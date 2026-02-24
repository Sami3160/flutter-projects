import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_oush/firebase_options.dart';
import 'package:notification_oush/home.dart';

//must be a top lvl function and not unedr any class
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}
