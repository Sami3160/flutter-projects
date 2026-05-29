import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';
import '../../../domain/usecases/register_user_use_case.dart';
import '../home/home_binding.dart';
import '../../pages/home/home_page.dart';

class RegistrationController extends GetxController {
  final RegisterUserUseCase registerUserUseCase;
  RegistrationController(this.registerUserUseCase);

  final nameController = TextEditingController();
  var isLoading = false.obs;

  void register() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your name',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    final user = await registerUserUseCase.execute(name);

    // Save to local storage
    Get.find<LocalStorageService>().user = user;

    isLoading.value = false;

    // Navigate to Home
    Get.offAll(() => const HomePage(), binding: HomeBinding());
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
