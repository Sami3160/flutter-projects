import 'package:assigment_1/core/services/auth_service.dart';
import 'package:assigment_1/core/services/stoarge_service.dart';
import 'package:assigment_1/data/providers/auth_provider.dart';
import 'package:assigment_1/modules/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:assigment_1/data/repositories/auth_repository.dart';
// class LoginBinding extends Bindings{
//   @override
//   void dependencies() {
//     Get.lazyPut(() => LoginController(
//       AuthRepository(
//         AuthProvider(Get.find(<AuthService>)),
//         Get.find<StorageService>(),
//       )
//     ));
//   }
// }
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
      AuthRepository(
        AuthProvider(Get.find<AuthService>()),
        Get.find<StorageService>(),
      ),
    ));
  }
}

