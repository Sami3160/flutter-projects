import 'package:get/get.dart';
import 'package:login_route/app/bindings/auth_binding.dart';
import 'package:login_route/app/routes/app_routes.dart';
import 'package:login_route/app/views/pages/home_page.dart';
import 'package:login_route/app/views/pages/login_page.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    // GetPage(
    //   name: Routes.PROFILE,
    //   page: () => ProfilePage(),
    //   binding: ProfileBinding(),
    //   middlewares: [AuthMiddleware()],
    // ),
  ];
}