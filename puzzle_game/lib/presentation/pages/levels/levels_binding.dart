import 'package:get/instance_manager.dart';
import 'package:puzzle_game/presentation/pages/levels/levels_controller.dart';

class LevelsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LevelsController());
  }
}