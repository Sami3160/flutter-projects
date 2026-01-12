import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_route/app/routes/app_pages.dart';
import 'package:login_route/app/routes/app_routes.dart';
import 'package:login_route/app/views/pages/home_page.dart';
import 'package:login_route/app/views/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Usage',
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
