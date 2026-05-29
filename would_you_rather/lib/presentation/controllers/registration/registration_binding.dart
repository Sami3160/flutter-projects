import 'package:get/get.dart';
import 'registration_controller.dart';
import '../../../domain/usecases/register_user_use_case.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController(RegisterUserUseCase(Get.find())));
  }
}
