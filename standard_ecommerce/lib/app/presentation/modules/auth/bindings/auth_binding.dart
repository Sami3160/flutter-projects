import 'package:get/get.dart';
import 'package:standard_ecommerce/app/data/providers/api_provider.dart';
import 'package:standard_ecommerce/app/data/repositories/auth_repository_impl.dart';
import 'package:standard_ecommerce/app/domain/repositories/auth_repository.dart';
import 'package:standard_ecommerce/app/domain/usecases/login_usecase.dart';
import 'package:standard_ecommerce/app/presentation/modules/auth/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiProvider());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(provider: Get.find()));
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => AuthController(Get.find()));
  }
}
