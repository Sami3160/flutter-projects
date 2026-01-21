import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_ecommerce/app/routes/app_pages.dart';
import 'package:standard_ecommerce/core/theme/app_theme.dart';
import 'package:standard_ecommerce/core/values/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
