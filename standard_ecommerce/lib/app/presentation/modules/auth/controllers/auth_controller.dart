import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_ecommerce/app/domain/usecases/login_usecase.dart';
import 'package:standard_ecommerce/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;

  AuthController(this.loginUseCase);

  final usernameController = TextEditingController(
    text: 'emilys',
  ); // dummy default
  final passwordController = TextEditingController(
    text: 'emilyspass',
  ); // dummy default
  final isLoading = false.obs;

  Future<void> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter username and password');
      return;
    }

    try {
      isLoading.value = true;
      final user = await loginUseCase(
        usernameController.text,
        passwordController.text,
      );
      // final user = await loginUseCase.call(
      //   usernameController.text,
      //   passwordController.text,
      // );
      // loginUseCase.call(username, password)
      // Save user/token if needed (shared preferences usually, skipping for simplicity as requested "very very simple")
      // In a real app we'd save the token here.
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      print('Login failed: $e');
      Get.snackbar('Error', 'Login failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
