
import 'package:get/get.dart';
import 'package:login_route/app/controllers/auth_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(AuthController(), permanent: true);
  }
}