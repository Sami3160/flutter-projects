import 'package:assigment_1/app_config/app_routes.dart';
import 'package:assigment_1/core/base/base_controller.dart';
import 'package:assigment_1/data/repositories/auth_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';

class LoginController extends BaseController {
final AuthRepository authRepository;
LoginController(this.authRepository);
final usernameController=TextEditingController();
final passwordController=TextEditingController();
Future<void> login() async{
  isLoading.value=true;
  try {
   
   await authRepository.login(
    usernameController.text,
    passwordController.text
    );
    Get.offAllNamed(AppRoutes.HOME);
  } finally {
    isLoading.value=false;
  }
}

@override
void onClose(){
  usernameController.dispose();
  passwordController.dispose();
  super.onClose();
}
}