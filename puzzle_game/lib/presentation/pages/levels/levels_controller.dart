import 'package:get/get.dart';

class LevelsController extends GetxController {
  var mode = "".obs;

  @override
  void onInit() {
    super.onInit();

    mode.value = Get.arguments?["mode"] ?? 'single';
  }
}
