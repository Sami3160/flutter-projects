import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';

class ResultController extends GetxController {
  late ConfettiController confettiController;
  var userSelections = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    userSelections.assignAll(Get.arguments ?? []);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      confettiController.play();
    });
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
}
