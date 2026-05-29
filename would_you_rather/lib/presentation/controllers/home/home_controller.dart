import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';
import '../../../domain/entities/user.dart';

class HomeController extends GetxController {
  var currentUser = Rxn<User>();
  final nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final user = Get.find<LocalStorageService>().user;
    if (user != null) {
      currentUser.value = user;
      nameController.text = user.name;
    }
  }

  void updateName() {
    final newName = nameController.text.trim();
    if (newName.isEmpty) return;

    if (currentUser.value != null) {
      // Create an updated user object keeping the same ID
      final updatedUser = User(id: currentUser.value!.id, name: newName);
      currentUser.value = updatedUser;

      // Save it back to local storage
      Get.find<LocalStorageService>().user = updatedUser;

      Get.back(); // close the drawer
      Get.snackbar(
        'Success',
        'Name updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
