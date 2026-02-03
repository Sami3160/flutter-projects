import 'package:digitomize/presentation/pages/blogs/blogs_binding.dart';
import 'package:digitomize/presentation/pages/blogs/blogs_view.dart';
import 'package:digitomize/presentation/pages/contests/contests_binding.dart';
import 'package:digitomize/presentation/pages/contests/contests_view.dart';
import 'package:digitomize/presentation/pages/hackathons/hackathons_binding.dart';
import 'package:digitomize/presentation/pages/hackathons/hackathons_view.dart';
import 'package:digitomize/presentation/pages/home/home_binding.dart';
import 'package:digitomize/presentation/pages/home/home_view.dart';
import 'package:digitomize/presentation/pages/login/login_binding.dart';
import 'package:digitomize/presentation/pages/login/login_view.dart';
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
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CONTESTS,
      page: () => const ContestsView(),
      binding: ContestsBinding(),
    ),
    GetPage(
      name: _Paths.HACKATHONS,
      page: () => const HackathonsView(),
      binding: HackathonsBinding(),
    ),
    GetPage(
      name: _Paths.BLOGS,
      page: () => const BlogsView(),
      binding: BlogsBinding(),
    ),
  ];
}
