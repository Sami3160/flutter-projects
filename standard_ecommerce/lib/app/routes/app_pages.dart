import 'package:get/get.dart';
import 'package:standard_ecommerce/app/presentation/modules/auth/bindings/auth_binding.dart';
import 'package:standard_ecommerce/app/presentation/modules/auth/views/login_view.dart';
import 'package:standard_ecommerce/app/presentation/modules/cart/bindings/cart_binding.dart';
import 'package:standard_ecommerce/app/presentation/modules/cart/views/cart_view.dart';
import 'package:standard_ecommerce/app/presentation/modules/home/bindings/home_binding.dart';
import 'package:standard_ecommerce/app/presentation/modules/home/views/home_view.dart';

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
  ];
}
