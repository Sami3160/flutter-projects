import 'package:get/get.dart';
import 'package:puzzle_game/app/routes/app_routes.dart';
import 'package:puzzle_game/presentation/pages/home/home_view.dart';
import 'package:puzzle_game/presentation/pages/levels/levels_binding.dart';
import 'package:puzzle_game/presentation/pages/levels/levels_view.dart';
import 'package:puzzle_game/presentation/pages/player/player_binding.dart';
import 'package:puzzle_game/presentation/pages/player/player_view.dart';

class AppPages {
  AppPages._();
  static const INITIAL=AppRoutes.HOME;

  static final routes=[
    GetPage(name: AppRoutes.HOME, page:()=> HomeView()),
    GetPage(name: AppRoutes.LEVELS, page:()=> LevelsView(),binding: LevelsBinding()),
    GetPage(name: AppRoutes.PLAYER, page:()=> PlayerView(),binding: PlayerBinding()),
  ];
}