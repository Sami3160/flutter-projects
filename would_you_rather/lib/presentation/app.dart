import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/home/home_binding.dart';
import 'pages/home/home_page.dart';
import 'controllers/registration/registration_binding.dart';
import 'pages/registration/registration_page.dart';
import '../app/services/local_storage.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final hasUser = Get.find<LocalStorageService>().user != null;

    return GetMaterialApp(
      title: 'Would You Rather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: hasUser ? "/home" : "/register",
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegistrationPage(),
          binding: RegistrationBinding(),
        ),
      ],
    );
  }
}
