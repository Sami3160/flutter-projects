import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final notificationsEnabled = true.obs;
  final darkModeEnabled = false.obs;
  final selectedLanguage = 'English'.obs;

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void toggleDarkMode(bool value) {
    darkModeEnabled.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void updateLanguage(String value) {
    selectedLanguage.value = value;
  }
}
