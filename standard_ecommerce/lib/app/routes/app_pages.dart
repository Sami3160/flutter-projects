import 'package:get/get.dart';
import 'package:standard_ecommerce/app/presentation/modules/auth/bindings/auth_binding.dart';
import 'package:standard_ecommerce/app/presentation/modules/auth/views/login_view.dart';
import 'package:standard_ecommerce/app/presentation/modules/cart/bindings/cart_binding.dart';
import 'package:standard_ecommerce/app/presentation/modules/cart/views/cart_view.dart';
import 'package:standard_ecommerce/app/presentation/modules/home/bindings/home_binding.dart';
import 'package:standard_ecommerce/app/presentation/modules/home/views/home_view.dart';
import 'package:standard_ecommerce/app/presentation/modules/profile/bindings/profile_binding.dart';
import 'package:standard_ecommerce/app/presentation/modules/profile/views/profile_view.dart';
import 'package:standard_ecommerce/app/presentation/modules/settings/bindings/settings_binding.dart';
import 'package:standard_ecommerce/app/presentation/modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
