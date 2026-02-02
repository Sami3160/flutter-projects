import 'package:digitomize/app/routes/app_routes.dart';
import 'package:digitomize/presentation/pages/home/home_binding.dart';
import 'package:digitomize/presentation/pages/home/home_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    // Add other routes here when created
  ];
}
