import 'package:get/instance_manager.dart';
import 'package:puzzle_game/presentation/pages/player/player_controller.dart';

class PlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>PlayerController());
  }
}