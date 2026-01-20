import 'package:assigment_1/app_config/app_routes.dart';
import 'package:assigment_1/modules/login/login_binding.dart';
import 'package:assigment_1/modules/login/login_view.dart';
import 'package:assigment_1/modules/profile/profile_view.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = AppRoutes.HOME;
  static final pages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(name: AppRoutes.HOME, page: () => ProfileView()),
  ];
}
